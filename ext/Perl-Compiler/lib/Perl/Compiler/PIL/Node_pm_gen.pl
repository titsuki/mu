
=pod




30 Aug 2005 - some notes on macros:

Ideally, the node definition clauses would be in one file,
and the defining macros, for each of various class hierarchies,
in others.  But we cant do that yet.

And since macros cannot currently define classes,
   macro f($x) { "class $x \{};" }  f("C");  C.new
   Error: No compatible subroutine found: "&C" 
this file is currently simply a source code generator.
Which also addresses the problem that macros are currently
quite slow (~10sec for this file).

And because macros are buggy, the node_Mumble macros are
currently defined as subs, which we can get away with since
this is currently simply a code generator.

=cut

# XXX - macro's cant currently define classes, so...
BEGIN{ say "\n# autogenerated file. DO NOT EDIT.  pugsbug workaround\n\n"; }

say '
class Perl::Compiler::PIL::Node::X0::Base {
}
';

my %done;
sub common_code ($name,$data,$constructor,@fields) {
    my $code = "";
    $code ~= "class Perl::Compiler::PIL::Node::$data;\n\n"
	if !%done{$data}++;
    $code ~= "class Perl::Compiler::PIL::Node::{$name}::{$constructor} \{";
    $code ~= "\n  does Perl::Compiler::PIL::Node::{$name}::Base;";
    $code ~= "\n  does Perl::Compiler::PIL::Node::$data;";
    for @fields -> $n,$t { $code ~= "\n  has \$.$n;"; }
    $code;
}
sub node_h ($data,$constructor,*@fields) {
    my $code = common_code('X0',$data,$constructor,*@fields);
    $code ~= "\n}\n";
    say $code; # XXX - see above
    $code;
}
sub node_a ($data,$constructor,*@fields) {
    my $code = common_code('X0',$data,$constructor,*@fields);
    $code ~= ("\n  sub new(\$v0) { "~
	      '$.'~@fields[0]~' = $v0; };');
    $code ~= "\n}\n";
    say $code; # XXX - see above
    $code;
}
sub node_a2 ($data,$constructor,*@fields) {
    my $code = common_code('X0',$data,$constructor,*@fields);
    $code ~= ("\n  sub new(\$v0,\$v1) { "~
	      '$.'~@fields[0]~' = $v0; '~
	      '$.'~@fields[2]~' = $v1; };');
    $code ~= "\n}\n";
    say $code; # XXX - see above
    $code;
}
sub node_s ($data,$constructor) {
    my $code = "";
    $code ~= ("\nmulti method does(String \$s, ",
	      ~"Perl::Compiler::PIL::Node::X0::$constructor) ",
	      ~"\{ \$s eq '$constructor'}");
    $code ~= ("\mmulti method does(String \$s, "
	      ~"Perl::Compiler::PIL::Node::XO::Base) "
	      ~"\{ \$s eq '$constructor'}");
    $code ~= ("\nmulti method does(String \$s, "
	      ~"Perl::Compiler::PIL::Node::$data) "
	      ~"\{ \$s eq '$constructor'}");
    $code;
}

# from src/Pugs/PIL1.hs_drift

node_h 'PIL_Environment',      'PIL_Environment', 
  'pilGlob' ,'[PIL_Decl]',
  'pilMain' ,'PIL_Stmts';

node_s 'PIL_Stmts',            'PNil';
node_h 'PIL_Stmts',            'PStmts', 
  'pStmt'  ,'PIL_Stmt',
  'pStmts' ,'PIL_Stmts';
node_h 'PIL_Stmts',            'PPad', 
  'pScope' ,'Scope',
  'pSyms'  ,'[(VarName, PIL_Expr)]',
  'pStmts' ,'PIL_Stmts';

node_s 'PIL_Stmt',             'PNoop';
node_h 'PIL_Stmt',             'PStmt', 
  'pExpr' ,'PIL_Expr';
node_h 'PIL_Stmt',             'PPos', 
  'pPos'  ,'Pos',
  'pExp'  ,'Exp',
  'pNode' ,'PIL_Stmt';

node_h 'PIL_Expr',             'PRawName', 
  'pRawName' ,'VarName';
node_h 'PIL_Expr',             'PExp', 
  'pLV'   ,'PIL_LValue';
node_h 'PIL_Expr',             'PLit', 
  'pLit'  ,'PIL_Literal';
node_h 'PIL_Expr',             'PThunk', 
  'pThunk' ,'PIL_Expr';
node_h 'PIL_Expr',             'PCode', 
  'pType'   ,'SubType',
  'pParams' ,'[TParam]',
  'pLValue' ,'Bool',
  'pBody'   ,'PIL_Stmts';

node_h 'PIL_Decl',             'PSub', 
  'pSubName'   ,'SubName',
  'pSubType'   ,'SubType',
  'pSubParams' ,'[TParam]',
  'pSubLValue' ,'Bool',
  'pSubBody'   ,'PIL_Stmts';

node_h 'PIL_Literal',          'PVal', 
  'pVal'  ,'Val';

node_h 'PIL_LValue',           'PVar', 
  'pVarName' ,'VarName';
node_h 'PIL_LValue',           'PApp', 
  'pCxt'  ,'TCxt',
  'pFun'  ,'PIL_Expr',
  'pInv'  ,'(Maybe PIL_Expr)',
  'pArgs' ,'[PIL_Expr]';
node_h 'PIL_LValue',           'PAssign', 
  'pLHS'  ,'[PIL_LValue]',
  'pRHS'  ,'PIL_Expr';
node_h 'PIL_LValue',           'PBind', 
  'pLHS'  ,'[PIL_LValue]',
  'pRHS'  ,'PIL_Expr';

node_h 'TParam',               'MkTParam', 
  'tpParam'   ,'Param',
  'tpDefault' ,'(Maybe (PIL_Expr))';

node_s 'TCxt',                 'TCxtVoid';
node_a 'TCxt',                 'TCxtLValue',
  'xType' ,'Type';
node_a 'TCxt',                 'TCxtItem',
  'xType' ,'Type';
node_a 'TCxt',                 'TCxtSlurpy',
  'xType' ,'Type';
node_a 'TCxt',                 'TTailCall',
  'xCtx' ,'TCxt';

node_h 'TEnv',                 'MkTEnv', 
  'tLexDepth' ,'Int',
  'tTokDepth' ,'Int',
  'tCxt'      ,'TCxt',
  'tReg'      ,'(TVar (Int, String))',
  'tLabel'    ,'(TVar Int)';


node_s 'Scope', 'SState';
node_s 'Scope', 'SMy';
node_s 'Scope', 'SOur';
node_s 'Scope', 'SLet';
node_s 'Scope', 'STemp';
node_s 'Scope', 'SGlobal';

node_s 'SubType', 'SubMethod';
node_s 'SubType', 'SubCoroutine';
node_s 'SubType', 'SubMacro';
node_s 'SubType', 'SubRoutine';
node_s 'SubType', 'SubBlock';
node_s 'SubType', 'SubPointy';
node_s 'SubType', 'SubPrim';

node_s 'Val', 'VUndef';
node_a 'Val', 'VBool' , 'xVal' ,'unk';
node_a 'Val', 'VInt'  , 'xVal' ,'unk';
node_a 'Val', 'VRat'  , 'xVal' ,'unk';
node_a 'Val', 'VNum'  , 'xVal' ,'unk';
node_a 'Val', 'VStr'  , 'xVal' ,'unk';
node_a 'Val', 'VList' , 'xVal' ,'unk';
node_a 'Val', 'VType' , 'xVal' ,'unk';

node_s 'Cxt', 'CxtVoid';
node_a 'Cxt', 'CxtItem'   , 'xType' ,'Type';
node_a 'Cxt', 'CxtSlurpy' , 'xType' ,'Type';

node_a 'Type', 'MkType',
  'xTypeName', 'String';
node_a2 'Type', 'TypeOr',
  'xLHS' ,'Type',
  'xRHS' ,'Type';
node_a2 'Type', 'TypeAnd',
  'xLHS' ,'Type',
  'xRHS' ,'Type';

node_h 'Param', 'MkParam',
  'isInvocant'   ,'Bool',
  'isOptional'   ,'Bool',
  'isNamed'      ,'Bool',
  'isLValue'     ,'Bool',
  'isWritable'   ,'Bool',
  'isLazy'       ,'Bool',
  'paramName'    ,'String',
  'paramContext' ,'Ctx',
  'paramDefault' ,'Exp';

node_h 'Pos', 'MkPos',
  'posName'        ,'String',
  'posBeginLine'   ,'Int',
  'posBeginColumn' ,'Int',
  'posEndLine'     ,'Int',
  'posEndColumn'   ,'Int';
