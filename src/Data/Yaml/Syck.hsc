{-# OPTIONS_GHC -fglasgow-exts -O2 -optc-O3 -fvia-C -optc-w -fno-warn-unused-binds #-}
#include "../../syck/syck.h"
#include "../../cbits/fpstring.h"

module Data.Yaml.Syck (
    parseYamlFS, emitYamlFS,
    parseYaml, emitYaml,
    YamlNode(..), YamlElem(..), YamlAnchor(..), tagNode, nilNode, mkNode, mkTagNode, SYMID,
) where

import Control.Exception (bracket)
import Data.IORef
import Data.Word                (Word8)
import qualified Data.FastPackedString as Str
import Foreign.Ptr
import Foreign.StablePtr
import Foreign.ForeignPtr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Marshal.Alloc
import Foreign.Marshal.Utils
import Foreign.Storable
import Data.Generics
import qualified Data.HashTable as Hash
import qualified Data.FastPackedString as Str

type Str        = Str.FastString
type YamlTag    = Maybe Str
data YamlAnchor
    = MkYamlAnchor    Int
    | MkYamlReference Int
    deriving (Show, Ord, Eq, Typeable, Data)
type SYMID = CULong

instance Data SYMID where
  toConstr x = mkIntConstr (mkIntType "Foreign.C.Types.CULong") (fromIntegral x)
  gunfold k z c = case constrRep c of
                    (IntConstr x) -> z (fromIntegral x)
                    _ -> error "gunfold"
  dataTypeOf _ = mkIntType "Foreign.C.Types.CULong"

data YamlNode = MkYamlNode
    { nid      :: SYMID
    , el       :: YamlElem
    , tag      :: YamlTag
    , anchor   :: Maybe YamlAnchor
    }
    deriving (Show, Ord, Eq, Typeable, Data)

data YamlElem
    = YamlMap [(YamlNode, YamlNode)]
    | YamlSeq [YamlNode]
    | YamlStr Str
    | YamlNil
    deriving (Show, Ord, Eq, Typeable, Data)

type SyckNode = Ptr ()
type SyckParser = Ptr ()
type SyckNodeHandler = SyckParser -> SyckNode -> IO SYMID
type SyckErrorHandler = SyckParser -> CString -> IO ()
type SyckNodePtr = Ptr CString
type FSPtr = Ptr CString
type SyckEmitter = Ptr ()  
type SyckEmitterHandler = SyckEmitter -> Ptr () -> IO ()
type SyckOutputHandler = SyckEmitter -> CString -> CLong -> IO ()
data SyckKind = SyckMap | SyckSeq | SyckStr
    deriving (Show, Ord, Eq, Enum)

nilNode :: YamlNode
nilNode = MkYamlNode 0 YamlNil Nothing Nothing

tagNode :: YamlTag -> YamlNode -> YamlNode
tagNode _ MkYamlNode{tag=Just x} = error ("can't add tag: already tagged with" ++ (Str.unpack x))
tagNode tag node                 = node{tag = tag}

mkNode :: YamlElem -> YamlNode
mkNode x = MkYamlNode 0 x Nothing Nothing

mkTagNode :: String -> YamlElem -> YamlNode
mkTagNode s x = MkYamlNode 0 x (Just $ Str.pack s) Nothing

-- the extra commas here are not a bug
#enum CInt, , scalar_none, scalar_1quote, scalar_2quote, scalar_fold, scalar_literal, scalar_plain
#enum CInt, , seq_none, seq_inline
#enum CInt, , map_none, map_inline

{-
#def typedef void* EmitterExtras;
type EmitterExtras = Ptr ()
-}

emitYamlFS :: YamlNode -> IO (Either Str.FastString Str.FastString)
emitYamlFS node = do
    bracket syck_new_emitter syck_free_emitter $ \emitter -> do
        -- set up output port
        out    <- newIORef Str.empty
        #{poke SyckEmitter, style} emitter scalarFold
        -- #{poke SyckEmitter, sort_keys} emitter (1 :: CInt)
        withCString "%d" $ #{poke SyckEmitter, anchor_format} emitter

        marks <- Hash.new (==) (Hash.hashInt)

        let freeze = freezeNode marks
        syck_emitter_handler emitter =<< mkEmitterCallback (emitterCallback freeze)
        syck_output_handler emitter =<< mkOutputCallback (outputCallbackPS out)

        markYamlNode marks emitter node

        nodePtr <- freeze node
        let nodePtr' = fromIntegral $ nodePtr `minusPtr` nullPtr
        syck_emit emitter nodePtr'
        syck_emitter_flush emitter 0
        fmap Right $ readIORef out

emitYaml :: YamlNode -> IO (Either String String)
emitYaml node = fmap (either (Left . Str.unpack) (Right . Str.unpack)) (emitYamlFS node)

markYamlNode :: Hash.HashTable Int SyckNodePtr -> SyckEmitter -> YamlNode -> IO ()
markYamlNode marks emitter MkYamlNode{ anchor = Just (MkYamlReference n) } = do
    Just nodePtr <- Hash.lookup marks n
    syck_emitter_mark_node emitter nodePtr
    return ()
markYamlNode marks emitter node = do
    nodePtr <- freezeNode marks node
    rv      <- syck_emitter_mark_node emitter nodePtr
    if rv == 0 then return () else do
    case anchor node of
        Just (MkYamlAnchor n) -> Hash.insert marks n nodePtr
        _                     -> return ()
    case el node of
        YamlMap xs  -> sequence_ [ mark x >> mark y | (x, y) <- xs ]
        YamlSeq xs  -> mapM_ mark xs
        _           -> return ()
    where
    mark = markYamlNode marks emitter

outputCallbackPS :: IORef Str.FastString -> SyckEmitter -> CString -> CLong -> IO ()
outputCallbackPS out emitter buf len = do
    let str =  Str.packCStringLen (buf, fromEnum len)
    modifyIORef out (`Str.append` str)

outputCallback :: SyckEmitter -> CString -> CLong -> IO ()
outputCallback emitter buf len = do
    outPtr  <- #{peek SyckEmitter, bonus} emitter
    out     <- deRefStablePtr (castPtrToStablePtr outPtr)
    str     <- peekCStringLen (buf, fromIntegral len)
    modifyIORef out (++ str)

freezeFS :: ForeignPtr Word8 -> IO FSPtr
freezeFS ps = do
    ptr     <- newStablePtr ps
    return (castPtr $ castStablePtrToPtr ptr)

readFS :: FSPtr -> IO (ForeignPtr Word8)
readFS fs = do
    ptr     <- peek . castPtr =<< peek fs
    deRefStablePtr (castPtrToStablePtr ptr)


emitterCallback :: (YamlNode -> IO SyckNodePtr) -> SyckEmitter -> Ptr () -> IO ()
emitterCallback f e vp = emitNode f e =<< thawNode vp
    
emitNode :: (YamlNode -> IO SyckNodePtr) -> SyckEmitter -> YamlNode -> IO ()
emitNode _ e n@(MkYamlNode{el = YamlNil}) = do
    withTag n "string" $ \tag ->
        withCString "~" $ \cs ->       
            syck_emit_scalar e tag scalarNone 0 0 0 cs 1

emitNode _ e n@(MkYamlNode{el = YamlStr s}) | s == Str.pack "~" = do
    withTag n "string" $ \tag ->
        withCString "~" $ \cs ->
            syck_emit_scalar e tag scalar1quote 0 0 0 cs 1

emitNode _ e n@(MkYamlNode{el = YamlStr str}) = do
    withTag n "string" $ \tag ->       
        Str.unsafeUseAsCStringLen str $ \(cs, l) ->       
            syck_emit_scalar e tag scalarNone 0 0 0 cs (toEnum l)

emitNode freeze e n@(MkYamlNode{el = YamlSeq seq}) = do
    withTag n "array" $ \tag ->
        syck_emit_seq e tag seqNone
    mapM_ (syck_emit_item e) =<< mapM freeze seq
    syck_emit_end e

emitNode freeze e n@(MkYamlNode{el = YamlMap m}) = do
    withTag n "hash" $ \tag -> 
        syck_emit_map e tag mapNone
    flip mapM_ m (\(k,v) -> do
        syck_emit_item e =<< freeze k
        syck_emit_item e =<< freeze v)
    syck_emit_end e

withTag :: YamlNode -> String -> (CString -> IO a) -> IO a
withTag node def f = Str.useAsCString (maybe (Str.pack def) id (tag node)) f

parseYaml :: String -> IO (Either String (Maybe YamlNode))
parseYaml = (`withCString` parseYamlCStr)

parseYamlFS :: Str.FastString -> IO (Either String (Maybe YamlNode))
parseYamlFS = (`Str.useAsCString` parseYamlCStr)

parseYamlCStr :: CString -> IO (Either String (Maybe YamlNode))
parseYamlCStr cstr = do
    bracket syck_new_parser syck_free_parser $ \parser -> do
        err <- newIORef Nothing
        syck_parser_str_auto parser cstr nullFunPtr
        syck_parser_handler parser =<< mkNodeCallback nodeCallback
        syck_parser_error_handler parser =<< mkErrorCallback (errorCallback err)
        syck_parser_implicit_typing parser 1
        syck_parser_taguri_expansion parser 0
        symId <- syck_parse parser
        if symId /= 0 then fmap (Right . Just) (readNode parser symId) else do
        rv <- readIORef err
        return $ case rv of
            Nothing     -> Right Nothing
            Just err    -> Left err

nodeCallback :: SyckParser -> SyckNode -> IO SYMID
nodeCallback parser syckNode = do
    kind    <- syckNodeKind syckNode
    len     <- syckNodeLength kind syckNode
    node    <- parseNode kind parser syckNode len
    nodePtr <- writeNode node
    symId   <- syck_add_sym parser nodePtr
    return (toEnum . fromEnum $ symId)

errorCallback :: IORef (Maybe String) -> SyckParser -> CString -> IO ()
errorCallback err parser cstr = do
    msg     <- peekCString cstr
    lineptr <- #{peek SyckParser, lineptr} parser :: IO CChar
    cursor  <- #{peek SyckParser, cursor} parser  :: IO CChar
    linect  <- #{peek SyckParser, linect} parser  :: IO CChar
    writeIORef err . Just $ concat
        [ msg
        , ": line ", show (1 + fromEnum linect)
        , ", column ", show (cursor - lineptr)
        ]

freezeNode :: Hash.HashTable Int (Ptr a) -> YamlNode -> IO (Ptr a)
freezeNode nodes node@MkYamlNode{ anchor = Just (MkYamlReference n) } = do
    Just ptr <- Hash.lookup nodes n
    return ptr
freezeNode nodes node = do
    ptr     <- newStablePtr node
    let ptr' = castPtr $ castStablePtrToPtr ptr
    case anchor node of
        Just (MkYamlAnchor n) -> Hash.insert nodes n ptr' >> return ptr'
        _                     -> return ptr'

thawNode :: Ptr () -> IO YamlNode
thawNode nodePtr = deRefStablePtr (castPtrToStablePtr nodePtr)

writeNode :: YamlNode -> IO SyckNodePtr
writeNode node = do
    ptr     <- newStablePtr node
    new (castPtr $ castStablePtrToPtr ptr)

readNode :: SyckParser -> SYMID -> IO YamlNode
readNode parser symId = alloca $ \nodePtr -> do
    syck_lookup_sym parser symId nodePtr
    ptr     <- peek . castPtr =<< peek nodePtr
    deRefStablePtr (castPtrToStablePtr ptr)

syckNodeTag :: SyckNode -> IO (Maybe Str)
syckNodeTag syckNode = do
    tag <- #{peek SyckNode, type_id} syckNode
    if (tag == nullPtr) then (return Nothing) else do
        return $ Just $ Str.packMallocCString tag

syckNodeKind :: SyckNode -> IO SyckKind
syckNodeKind syckNode = fmap toEnum $ #{peek SyckNode, kind} syckNode

syckNodeLength :: SyckKind -> SyckNode -> IO CLong
syckNodeLength SyckMap = (#{peek struct SyckMap, idx} =<<) . #{peek SyckNode, data}
syckNodeLength SyckSeq = (#{peek struct SyckSeq, idx} =<<) . #{peek SyckNode, data}
syckNodeLength SyckStr = (#{peek struct SyckStr, len} =<<) . #{peek SyckNode, data}

parseNode :: SyckKind -> SyckParser -> SyckNode -> CLong -> IO YamlNode
parseNode SyckMap parser syckNode len = do
    tag   <- syckNodeTag syckNode
    pairs <- (`mapM` [0..len-1]) $ \idx -> do
        keyId   <- syck_map_read syckNode 0 idx
        key     <- readNode parser keyId
        valId   <- syck_map_read syckNode 1 idx
        val     <- readNode parser valId
        return (key, val)
    return $ nilNode{ el = YamlMap pairs, tag = tag}

parseNode SyckSeq parser syckNode len = do
    tag   <- syckNodeTag syckNode
    nodes <- (`mapM` [0..len-1]) $ \idx -> do
        symId   <- syck_seq_read syckNode idx
        readNode parser symId
    return $ nilNode{ el = YamlSeq nodes, tag = tag }

parseNode SyckStr _ syckNode len = do
    tag   <- syckNodeTag syckNode
    cstr  <- syck_str_read syckNode
    let str = Str.packCStringLen (cstr, fromEnum len)
    return $ nilNode{ el = YamlStr str, tag = tag }

foreign import ccall "wrapper"  
    mkNodeCallback :: SyckNodeHandler -> IO (FunPtr SyckNodeHandler)

foreign import ccall "wrapper"  
    mkErrorCallback :: SyckErrorHandler -> IO (FunPtr SyckErrorHandler)

foreign import ccall "wrapper"
    mkOutputCallback :: SyckOutputHandler -> IO (FunPtr SyckOutputHandler)

foreign import ccall "wrapper"
    mkEmitterCallback :: SyckEmitterHandler -> IO (FunPtr SyckEmitterHandler)

foreign import ccall
    syck_new_parser :: IO SyckParser

foreign import ccall
    syck_parser_str_auto :: SyckParser -> CString -> FunPtr () -> IO ()

foreign import ccall
    syck_parser_error_handler :: SyckParser -> FunPtr SyckErrorHandler -> IO ()

foreign import ccall
    syck_parser_implicit_typing :: SyckParser -> CInt -> IO ()

foreign import ccall
    syck_parser_taguri_expansion :: SyckParser -> CInt -> IO ()

foreign import ccall
    syck_parser_handler :: SyckParser -> FunPtr SyckNodeHandler -> IO ()

foreign import ccall
    syck_add_sym :: SyckParser -> SyckNodePtr -> IO CInt

foreign import ccall
    syck_parse :: SyckParser -> IO SYMID

foreign import ccall
    syck_free_parser :: SyckParser -> IO ()

foreign import ccall
    syck_lookup_sym :: SyckParser -> SYMID -> Ptr SyckNodePtr -> IO CInt

foreign import ccall
    syck_str_read :: SyckNode -> IO CString

foreign import ccall
    syck_seq_read :: SyckNode -> CLong -> IO SYMID

foreign import ccall
    syck_map_read :: SyckNode -> CInt -> CLong -> IO SYMID

foreign import ccall
    syck_new_emitter :: IO SyckEmitter

foreign import ccall
    syck_free_emitter :: SyckEmitter -> IO ()

foreign import ccall
    syck_emitter_handler :: SyckEmitter -> FunPtr SyckEmitterHandler -> IO ()

foreign import ccall
    syck_output_handler :: SyckEmitter -> FunPtr SyckOutputHandler -> IO ()

foreign import ccall
    syck_emit :: SyckEmitter -> CLong -> IO ()

foreign import ccall
    syck_emitter_flush :: SyckEmitter -> CLong -> IO ()

foreign import ccall
    syck_emitter_mark_node :: SyckEmitter -> SyckNodePtr -> IO SYMID

foreign import ccall
    syck_emit_scalar :: SyckEmitter -> CString -> CInt -> CInt -> CInt -> CInt -> CString -> CInt -> IO ()

foreign import ccall
    syck_emit_seq :: SyckEmitter -> CString -> CInt -> IO ()

foreign import ccall
    syck_emit_item :: SyckEmitter -> SyckNodePtr -> IO ()

foreign import ccall
    syck_emit_end :: SyckEmitter -> IO ()

foreign import ccall
    syck_emit_map :: SyckEmitter -> CString -> CInt -> IO ()
