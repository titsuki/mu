# This is a regexp engine, written in p5.  It the very beginnings of a
# proof of concept.  A feasibility and performance reality check.
# Hopefully it will develop into a p6 rules engine, and then a p6
# parser, for p5.

# It's a backtracking, recursive-decent engine, generated from the
# regexp ast nodes created by Regexp::Parser.

# We're using the normal Regexp::Parser nodes, rather than it's p6
# ones, because the latter currently lack tests, so I am uncertain of
# their status.  The nodes are basically the same, so it's not a big
# deal.

# Test suite:
#  re_tests - tests from p5 HEAD 2006-02-12
#  re_tests_perl5.t - driver from same.
#  re_tests_parrot.t - parrot's driver, same date.
#  re_tests_match.el - an old driver putter wrote, adapted to call a Match obj.
# Just  prove regexp_engine_demo.t   or somesuch.

# Currently "implemented", and perhaps even working, are literals "a",
# alternation "|", concatentation "ab", and some anchors "\A\z^$".

#XXX - feel free to flesh things out.
# Most of it is simple (concat is anomalous).

#XXX:
# - write an accompanying .t file to dump tests into.
# - play with Regexp::Parser's Perl6::Rules to establish it's state.
#   Summarize that here.
# - Create a subrule node for it, and teach it to parse it.


#XXX - create a p5->p6 regexp syntax converter! :)
# create methods (in_p6_syntax?) which return the p6 version of the regexp.
# We will then pour the re_test suite through it, yielding a more complete
# version of t/rules/rules.t.

use Regexp::Parser;
use Data::Dumper;
use Match;
use strict;
{
  package Hacks;
  my $noop;
  $noop = sub{return 1 if $_[0] eq $noop; goto $_[0]($noop);};
  sub noop {
    $noop;
  }
  sub concat {
    my($o,$aref)=@_;
    die "bug $aref" if ref($aref) ne 'ARRAY';
    my @a = @$aref;
    return $o->noop if @a == 0;
    return $a[0]->emit if @a == 1;
    my @fs = map { $_->emit } @a;
    my $code1 = ""; my $code2 = "";
    my $code0 = "my \$f0 = \$fs[0]; ";
    for my $i (reverse(1..$#a)) {
      $code0 .= "my \$f$i = \$fs[$i]; ";
      $code1 .= "sub{\@_=";
      $code2 .= ";goto \&\$f$i}";
    }
    my $code = $code0."\n sub{my \$cn = \$_[0]; \@_=".$code1."\$cn".$code2.";goto \&\$f0}\n";
    #print $code;
    eval($code) || die "$@";
  }   
  sub mk_eater_for_re {
    my($o,$re)=@_;
    my $noop = $o->noop;
    my $qr = qr/\G$re/;
    sub {
      my $c = $_[0];
      my($s) = $X::str;
      pos($s) = $X::pos;
      my $x = $s =~ $qr;
      return undef if !$x;
      $X::pos += length($x);
      @_=$noop;
      goto &$c;
    };
  }

  #my %warned_about;
  sub emit {
    my $cls = ref($_[0]);
    die "$cls emit() unimplemented\n";
    #warn "$cls emit() unimplemented\n" if !defined $warned_about{$cls}++;
    #sub{return undef};
  }
  sub inf {
    1000**1000**1000 #XXX there has to be a better way. :(
  }
}
{
  package Regexp::Parser::__object__;
  @Regexp::Parser::__object__::ISA=qw(Hacks);
}  
{
  # \A ^ \B \b \G \Z \z $
  package Regexp::Parser::anchor;
  sub emit {
    my($o)=@_;
    my $noop = $o->noop;
    my $re = $o->raw();
    return sub{return undef if !($X::pos == 0);
               my $c = $_[0]; @_=$noop; goto &$c
    } if $re eq '\A';
    return sub{return undef if !($X::pos == 0 || substr($X::str,$X::pos-1,1) eq "\n");
               my $c = $_[0]; @_=$noop; goto &$c
    } if $re eq '^';
    # \B
    # \b
    # \G
    return sub{return undef if !($X::pos == (length($X::str)) || substr($X::str,$X::pos,1) eq "\n");
               my $c = $_[0]; @_=$noop; goto &$c
    } if $re eq '$';
    # \Z
    return sub{return undef if !($X::pos == (length($X::str)));
               my $c = $_[0]; @_=$noop; goto &$c
    } if $re eq '\z';
    #die "didn't implement $re"
    sub{return undef};
  }
}
{
  # . \C
  package Regexp::Parser::reg_any;
  sub emit {
    my($o)=@_;
    my $noop = $o->noop;
    my $re = $o->raw();
    return sub{return undef if $X::pos == (length($X::str)-1);
               $X::pos++; 
               my $c = $_[0]; @_=$noop; goto &$c
    } if $re eq '.';
    #die "didn't implement $re"
    sub{return undef};
  }
}
{
  # \w \W
  package Regexp::Parser::alnum;
  sub emit {
    my($o)=@_;
    my $re = $o->raw();
    return $o->mk_eater_for_re('\w') if $re eq '\w';
    return $o->mk_eater_for_re('\W') if $re eq '\W';
    die "Regexp compilation bug";
  }
}
{
  # \s \S
  package Regexp::Parser::space;
  sub emit {
    my($o)=@_;
    my $re = $o->raw();
    return $o->mk_eater_for_re('\s') if $re eq '\s';
    return $o->mk_eater_for_re('\S') if $re eq '\S';
    die "Regexp compilation bug";
  }
}
{
  # \d \D
  package Regexp::Parser::digit;
  sub emit {
    my($o)=@_;
    my $re = $o->raw();
    return $o->mk_eater_for_re('\d') if $re eq '\d';
    return $o->mk_eater_for_re('\D') if $re eq '\D';
    die "Regexp compilation bug";
  }
}
{
  package Regexp::Parser::anyof;
}
{
  package Regexp::Parser::anyof_char;
}
{
  package Regexp::Parser::anyof_range;
}
{
  package Regexp::Parser::anyof_class;
}
{
  package Regexp::Parser::anyof_close;
}
{
  package Regexp::Parser::prop;
}
{
  package Regexp::Parser::clump;
}
{
  # |
  package Regexp::Parser::branch;
  sub emit {
    my($o)=@_;
    my(@fs) = map { $o->concat($_) } @{$o->data};
    my $f_last = pop(@fs);
    sub{
      my $c = $_[0];
      for my $f (@fs) {
        my $c_down = $c;
        my($str,$pos); my $v;
        { local($X::str,$X::pos)=($X::str,$X::pos);
          $v = $f->($c_down);
          ($str,$pos)=($X::str,$X::pos) if defined $v;
        }
        if(defined $v) {
          ($X::str,$X::pos)=($str,$pos);
          return $v;
        }
      }
      # @_= $c; # Hasn't changed.
      goto &$f_last;
    };
  }
}
{
  package Regexp::Parser::exact;
  sub emit{
    my($o)=@_;
    my $noop = $o->noop;
    my $s = join("",$o->data);
    my $len = length($s);
    sub{ my $c = $_[0]; return undef if !(substr($X::str,$X::pos,$len) eq $s); $X::pos += $len; @_=$noop; goto &$c};
  }
}
{
  package Regexp::Parser::quant;
  sub emit {
    my($o)=@_;
    my $noop = $o->noop;
    my($min,$max)= (@$o{'min','max'});
    $min = 0 if $min eq "";
    $max = $o->inf if $max eq "";
    $min += 0; $max += 0; 
    my $f = $o->data->emit;
    sub{
      my $c = $_[0];
      my $i = 0;
      my($fmin,$fmax);
      $fmin = sub{ goto &$fmax if $i >= $min; @_=$fmin; $i++; goto &$f};
      $fmax = sub{
        if($i >= $max) {
          @_=$noop;
          goto &$c;
        }
        $i++;
        my $c_down = $fmax;
        my($str,$pos); my $v;
        { local($X::str,$X::pos)=($X::str,$X::pos);
          $v = $f->($c_down);
          ($str,$pos)=($X::str,$X::pos) if defined $v;
        }
        if(defined $v) { 
         ($X::str,$X::pos)=($str,$pos);
          return $v;
        } else {
          @_=$noop;
          goto &$c;
        }
      };
      goto &$fmin;
    };        
  }
}
{
  # ( non-capturing
  package Regexp::Parser::group;
}
{
  # ( capturing
  package Regexp::Parser::open;
}
{
  # ) closing
  package Regexp::Parser::close;
}
{
  # ) for non-captures
  package Regexp::Parser::tail;
}
{
  # \1 (backrefs)
  package Regexp::Parser::ref;
}
{
  package Regexp::Parser::assertion;
}
{
  # (?=) (?<=)
  package Regexp::Parser::ifmatch;
}
{
  # (?!) (?<!)
  package Regexp::Parser::unlessm;
}
{
  # (?>)
  package Regexp::Parser::suspend;
}
{
  # (?(n)t|f)
  package Regexp::Parser::ifthen;
}
{
  # the N in (?(N)t|f) when N is a number
  package Regexp::Parser::groupp;
}
{
  # (?{ ... })
  package Regexp::Parser::eval;
  sub emit {
    my($o)=@_;
    my $embedded_code = join("",$o->data);
    my $code = 'sub{my $__c__ = $_[0]; '.$embedded_code.'; goto &$__c__}';
    eval($code) || die "Error compiling (?{$embedded_code}) :\n$@\n";
  }
}
{
  # (??{ ... })
  package Regexp::Parser::logical;
}
{
  package Regexp::Parser::flags;
}
{
  package Regexp::Parser::minmod;
}

my $noop = Hacks->noop;
sub compile {
  my($re)=@_;
  my $parser = Regexp::Parser->new($re);
  my $n = eval{ $parser->root };
  die "$@" if !defined $n;
  #print Dumper $n;
  my $r = Hacks->concat($n);
  return $r;
}
sub match {
  my($r,$s)=@_;
  local $X::str = $s;
  local $X::pos = 0;
  local $X::match = MatchX->new();
  my $m = $r->($noop);
  if(defined($m)) {
    $X::match->set_str(substr($X::str,0,$X::pos));
    ${$X::match}->{'from'}=0; #EEEP
    ${$X::match}->{'to'}=$X::pos; #EEEP
  } else {
    $X::match->set_as_failed;
  }
  return $X::match;
}
sub match_re {
  my($re,$s)=@_;
  my $r = compile($re);
  my $m = match($r,$s);
  return $m;
}

if(@ARGV && $ARGV[0] eq '--test') {
  require './re_tests_match.pl';
  Pkg_re_tests::test(sub{my($mods,$re)=@_;my $r = compile($re); sub{my($s)=@_;match($r,$s)}});
  exit;
}
print Dumper match_re('a','abc');
