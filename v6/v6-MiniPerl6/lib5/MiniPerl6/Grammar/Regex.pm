# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package MiniPerl6::Grammar::Regex; sub new { shift; bless { @_ }, "MiniPerl6::Grammar::Regex" } my $Hash_rule_terms; sub ws { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { do { my $m2 = MiniPerl6::Grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } } }); return($MATCH) }; sub ident { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { do { my $m2 = MiniPerl6::Grammar->full_ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } } || do { $MATCH->to($pos1); do { my $m2 = $grammar->digit($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'digit'} = $m2;1 } else { 0 } } } }) }); return($MATCH) }; sub any { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); return($MATCH) }; sub literal { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $m2 = $grammar->literal($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'literal'} = $m2;1 } else { 0 } } })) } || (do { $MATCH->to($pos1); (do { my $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(), ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp } && ((('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $m2 = $grammar->literal($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'literal'} = $m2;1 } else { 0 } } })) } || do { $MATCH->to($pos1); 1 })) }); return($MATCH) }; sub metasyntax { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $pos1 = $MATCH->to(); (do { ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) } || (do { $MATCH->to($pos1); ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->literal($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0))) } || (do { $MATCH->to($pos1); ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->string_code($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0))) } || (do { $MATCH->to($pos1); ((('<' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->metasyntax($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0))) } || do { $MATCH->to($pos1); (do { my $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(), ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp } && (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) })))) } && do { my $pos1 = $MATCH->to(); (do { do { my $m2 = $grammar->metasyntax($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'metasyntax'} = $m2;1 } else { 0 } } } } || do { $MATCH->to($pos1); 1 }) }) } }); return($MATCH) }; sub char_range { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $pos1 = $MATCH->to(); (do { ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) } || do { $MATCH->to($pos1); (do { my $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(), ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { ((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp } && (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) }) } && do { my $pos1 = $MATCH->to(); (do { do { my $m2 = $grammar->char_range($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'char_range'} = $m2;1 } else { 0 } } } } || do { $MATCH->to($pos1); 1 }) }) } }); return($MATCH) }; sub char_class { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { do { my $m2 = $grammar->ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } } || do { $MATCH->to($pos1); ((('[' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->char_range($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && ((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0))) }) }); return($MATCH) }; sub string_code { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $pos1 = $MATCH->to(); (do { ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) } || (do { $MATCH->to($pos1); ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->literal($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0))) } || (do { $MATCH->to($pos1); ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->string_code($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0))) } || do { $MATCH->to($pos1); (do { my $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(), ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp } && (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) }))) } && do { my $pos1 = $MATCH->to(); (do { do { my $m2 = $grammar->string_code($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'string_code'} = $m2;1 } else { 0 } } } } || do { $MATCH->to($pos1); 1 }) }) } }); return($MATCH) }; sub parsed_code { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $m2 = $grammar->string_code($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && do { my $ret = sub  { do { return(("" . $MATCH)) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }) } }); return($MATCH) }; sub named_capture_body { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { ((('(' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && (((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return({ 'capturing_group' => ${$MATCH->{'rule'}}, }) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('[' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && (((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(${$MATCH->{'rule'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('<' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->metasyntax($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'metasyntax'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Subrule->new( 'metasyntax' => ${$MATCH->{'metasyntax'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { die('invalid alias syntax') }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }))) }); return($MATCH) }; sub variables { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { ((('$<' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'ident'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(('$/{' . ('\'' . ($MATCH->{'ident'} . ('\'' . '}'))))) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); (do { my $m2 = MiniPerl6::Grammar->sigil($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'MiniPerl6::Grammar.sigil'} = $m2;1 } else { 0 } } } && (do { my $m2 = MiniPerl6::Grammar->digits($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'MiniPerl6::Grammar.digits'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(($MATCH->{'MiniPerl6::Grammar.sigil'} . ('/[' . ($MATCH->{'MiniPerl6::Grammar.digits'} . ']')))) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })) } || do { $MATCH->to($pos1); (do { my $m2 = MiniPerl6::Grammar->sigil($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'MiniPerl6::Grammar.sigil'} = $m2;1 } else { 0 } } } && (do { my $m2 = MiniPerl6::Grammar->twigil($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'MiniPerl6::Grammar.twigil'} = $m2;1 } else { 0 } } } && (do { my $m2 = MiniPerl6::Grammar->full_ident($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'MiniPerl6::Grammar.full_ident'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::Var->new( 'sigil' => ("" . $MATCH->{'MiniPerl6::Grammar.sigil'}),'twigil' => ("" . $MATCH->{'MiniPerl6::Grammar.twigil'}),'name' => ("" . $MATCH->{'MiniPerl6::Grammar.full_ident'}), )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) })) }); return($MATCH) }; sub rule_terms { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { ((('(' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && (((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Capture->new( 'rule' => ${$MATCH->{'rule'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('<(' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && (((')>' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::CaptureResult->new( 'rule' => ${$MATCH->{'rule'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('<after' eq substr($str, $MATCH->to(), 6)) ? (1 + $MATCH->to((6 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::After->new( 'rule' => ${$MATCH->{'rule'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })))) } || (do { $MATCH->to($pos1); ((('<before' eq substr($str, $MATCH->to(), 7)) ? (1 + $MATCH->to((7 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Before->new( 'rule' => ${$MATCH->{'rule'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })))) } || (do { $MATCH->to($pos1); ((('<!before' eq substr($str, $MATCH->to(), 8)) ? (1 + $MATCH->to((8 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::NotBefore->new( 'rule' => ${$MATCH->{'rule'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })))) } || (do { $MATCH->to($pos1); ((('<!' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->metasyntax($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'metasyntax'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return({ negate() => { 'metasyntax' => ${$MATCH->{'metasyntax'}}, }, }) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('<+' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->char_class($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'char_class'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::CharClass->new( 'chars' => ("" . $MATCH->{'char_class'}), )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('<-' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->char_class($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'char_class'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::NegateCharClass->new( 'chars' => ("" . $MATCH->{'char_class'}), )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('<' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->literal($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'literal'} = $m2;1 } else { 0 } } } && ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Constant->new( 'constant' => ${$MATCH->{'literal'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))))) } || (do { $MATCH->to($pos1); ((('<' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->variables($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'variables'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::InterpolateVar->new( 'var' => ${$MATCH->{'variables'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })) } || (do { $MATCH->to($pos1); ((('?' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->metasyntax($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'metasyntax'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::SubruleNoCapture->new( 'metasyntax' => ${$MATCH->{'metasyntax'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || do { $MATCH->to($pos1); (do { my $m2 = $grammar->metasyntax($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'metasyntax'} = $m2;1 } else { 0 } } } && ((('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Subrule->new( 'metasyntax' => ${$MATCH->{'metasyntax'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })) })) }) } || (do { $MATCH->to($pos1); ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->parsed_code($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'parsed_code'} = $m2;1 } else { 0 } } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Block->new( 'closure' => ${$MATCH->{'parsed_code'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || (do { $MATCH->to($pos1); ((('\\' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && do { my $pos1 = $MATCH->to(); do { (do { my $m2 = $grammar->any($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'any'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::SpecialChar->new( 'char' => ${$MATCH->{'any'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }) } }) } || (do { $MATCH->to($pos1); ((('.' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(Rul::Dot->new( 'dot' => 1, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }) } || do { $MATCH->to($pos1); ((('[' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->rule($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule'} = $m2;1 } else { 0 } } } && (((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return(${$MATCH->{'rule'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) }))))))))))))) }); return($MATCH) }; sub term { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->variables($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'variables'} = $m2;1 } else { 0 } } } && do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((':=' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my $m2 = $grammar->named_capture_body($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'named_capture_body'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::NamedCapture->new( 'rule' => ${$MATCH->{'named_capture_body'}},'ident' => ${$MATCH->{'variables'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })))) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { return(${$MATCH->{'variables'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }) }) } || (do { $MATCH->to($pos1); (do { my $m2 = $grammar->rule_terms($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'rule_terms'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(${$MATCH->{'rule_terms'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }) } || do { $MATCH->to($pos1); (do { my $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(), ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { ((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); ((')' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('>' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); ((':' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('?' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('+' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('*' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('|' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('&' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || do { $MATCH->to($pos1); (('/' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) })))))))))) }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp } && (do { my $m2 = $grammar->any($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'any'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::Constant->new( 'constant' => ${$MATCH->{'any'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })) })) }); return($MATCH) }; sub quant { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { ((('**' eq substr($str, $MATCH->to(), 2)) ? (1 + $MATCH->to((2 + $MATCH->to()))) : 0) && (do { my $m2 = MiniPerl6::Grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->parsed_code($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'parsed_code'} = $m2;1 } else { 0 } } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my $ret = sub  { do { return({ 'closure' => ${$MATCH->{'parsed_code'}}, }) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))))) } || do { $MATCH->to($pos1); do { my $pos1 = $MATCH->to(); (do { (('?' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('*' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || do { $MATCH->to($pos1); (('+' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) })) } }) }); return($MATCH) }; sub greedy { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { (('?' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('+' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || do { $MATCH->to($pos1); 1 })) }); return($MATCH) }; sub quantifier { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $m2 = MiniPerl6::Grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (do { my $m2 = $grammar->term($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'term'} = $m2;1 } else { 0 } } } && (do { my $m2 = MiniPerl6::Grammar->opt_ws2($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->quant($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quant'} = $m2;1 } else { 0 } } } && (do { my $m2 = $grammar->greedy($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'greedy'} = $m2;1 } else { 0 } } } && (do { my $m2 = MiniPerl6::Grammar->opt_ws3($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::Quantifier->new( 'term' => ${$MATCH->{'term'}},'quant' => ${$MATCH->{'quant'}},'greedy' => ${$MATCH->{'greedy'}},'ws1' => ${$MATCH->{'MiniPerl6::Grammar.opt_ws'}},'ws2' => ${$MATCH->{'MiniPerl6::Grammar.opt_ws2'}},'ws3' => ${$MATCH->{'MiniPerl6::Grammar.opt_ws3'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }))) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { return(${$MATCH->{'term'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }) }))) } }); return($MATCH) }; sub concat_list { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->quantifier($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quantifier'} = $m2;1 } else { 0 } } } && do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->concat_list($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'concat_list'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return([${$MATCH->{'quantifier'}}, @{${$MATCH->{'concat_list'}}}]) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { return([${$MATCH->{'quantifier'}}]) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }) }) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { return([]) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }) }); return($MATCH) }; sub concat { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $m2 = $grammar->concat_list($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'concat_list'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::Concat->new( 'concat' => ${$MATCH->{'concat_list'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 }) } }); return($MATCH) }; sub or_list { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->concat($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'concat'} = $m2;1 } else { 0 } } } && do { my $pos1 = $MATCH->to(); (do { ((('|' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my $m2 = $grammar->or_list($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'or_list'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return([${$MATCH->{'concat'}}, @{${$MATCH->{'or_list'}}}]) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { return([${$MATCH->{'concat'}}]) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }) }) } || do { $MATCH->to($pos1); do { my $ret = sub  { do { return([]) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 } }) }); return($MATCH) }; sub rule { my $grammar = $_[0]; my $str = $_[1]; my $pos = $_[2]; my $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my $pos1 = $MATCH->to(); do { (do { my $pos1 = $MATCH->to(); (do { (do { my $m2 = $grammar->ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (('|' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0)) } || do { $MATCH->to($pos1); 1 }) } && (do { my $m2 = $grammar->or_list($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'or_list'} = $m2;1 } else { 0 } } } && do { my $ret = sub  { do { return(Rul::Or->new( 'or' => ${$MATCH->{'or_list'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);return($MATCH) } else {  } }; 1 })) } }); return($MATCH) }
;
1;
