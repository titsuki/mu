# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package KindaPerl6::Visitor::EmitLisp;
sub new { shift; bless {@_}, "KindaPerl6::Visitor::EmitLisp" }

sub visit {
    my $self   = shift;
    my $List__ = \@_;
    my $node;
    do { $node = $List__->[0]; [$node] };
    $node->emit_lisp( $self->{visitor_args}->{'secure'} );
}

package CompUnit;
sub new { shift; bless {@_}, "CompUnit" }

sub set_secure_mode {
    my $List__ = \@_;
    my $args_secure;
    do { $args_secure = $List__->[0]; [$args_secure] };
    do {
        if ( ( $args_secure != 0 ) ) { return ( ( '(pushnew :kp6-lisp-secure *features*)' . Main::newline() ) ) }
        else                         { return ('') }
        }
}

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $args_secure;
    do { $args_secure = $List__->[0]; [$args_secure] };
    my $interpreter = ( '|' . ( $self->{name} . '|' ) );
    (   ';; Do not edit this file - Lisp generated by '
            . (
            $Main::_V6_COMPILER_NAME
                . (
                Main::newline()
                    . (
                    '(eval-when (:compile-toplevel :load-toplevel :execute)'
                        . (
                        Main::newline()
                            . (
                            '  (when (null (find-package \'kp6-lisp))'
                                . (
                                Main::newline()
                                    . (
                                    '   '
                                        . (
                                        set_secure_mode($args_secure)
                                            . (
                                            '   (load "src/KindaPerl6/Runtime/Lisp/Runtime.lisp")))'
                                                . (
                                                Main::newline()
                                                    . (
                                                    '(in-package #:kp6-lisp-user)'
                                                        . (
                                                        Main::newline()
                                                            . (
                                                            '(kp6-add-program ('
                                                                . (
                                                                $interpreter
                                                                    . (
                                                                    ')'
                                                                        . (
                                                                        Main::newline()
                                                                            . (
                                                                            ' (kp6-ensure-package '
                                                                                . (
                                                                                $interpreter
                                                                                    . (
                                                                                    ' "'
                                                                                        . (
                                                                                        $self->{name}
                                                                                            . (
                                                                                            '")'
                                                                                                . (
                                                                                                Main::newline()
                                                                                                    . (
                                                                                                    ' (with-kp6-package ('
                                                                                                        . (
                                                                                                        $interpreter
                                                                                                            . ( ' "' . ( $self->{name} . ( '")' . ( Main::newline() . ( $self->{body}->emit_lisp( $interpreter, 3 ) . ( '))' . Main::newline() ) ) ) ) ) )
                                                                                                        )
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )
                                                                                )
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
    );
}

package Val::Int;
sub new { shift; bless {@_}, "Val::Int" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-Int :value ' . ( $self->{int} . ')' ) );
}

package Val::Bit;
sub new { shift; bless {@_}, "Val::Bit" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-Bit :value ' . ( $self->{bit} . ')' ) );
}

package Val::Num;
sub new { shift; bless {@_}, "Val::Num" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-Num :value ' . ( $self->{num} . ')' ) );
}

package Val::Buf;
sub new { shift; bless {@_}, "Val::Buf" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-Str :value ' . ( '"' . ( Main::mangle_string( $self->{buf} ) . ( '"' . ')' ) ) ) );
}

package Val::Char;
sub new { shift; bless {@_}, "Val::Char" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-Char :value (code-char ' . ( $self->{char} . '))' ) );
}

package Val::Undef;
sub new { shift; bless {@_}, "Val::Undef" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    '(make-instance \'kp6-Undef)';
}

package Val::Object;
sub new { shift; bless {@_}, "Val::Object" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "literal objects")' ) );
}

package Native::Buf;
sub new { shift; bless {@_}, "Native::Buf" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "Native::Buf objects")' ) );
}

package Lit::Seq;
sub new { shift; bless {@_}, "Lit::Seq" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(list ' . ( Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{seq} } ], ' ' ) . ')' ) );
}

package Lit::Array;
sub new { shift; bless {@_}, "Lit::Array" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-Array :value (list ' . ( Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{array} } ], ' ' ) . '))' ) );
}

package Lit::Hash;
sub new { shift; bless {@_}, "Lit::Hash" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $fields = $self->{hash};
    my $str    = '';
    my $field;
    do {

        for my $field ( @{$fields} ) {
            $str = ( $str . ( '(kp6-dispatch hash ' . ( $interpreter . ( ' :store ' . ( $field->[0]->emit_lisp( $interpreter, $indent ) . ( ' ' . ( $field->[1]->emit_lisp( $interpreter, $indent ) . ( ')' . Main::newline() ) ) ) ) ) ) ) );
        }
    };
    ( '(let ((hash (make-instance \'kp6-Hash)))' . ( Main::newline() . ( $str . ' hash)' ) ) );
}

package Lit::Pair;
sub new { shift; bless {@_}, "Lit::Pair" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-instance \'kp6-pair :key ' . ( $self->{key}->emit_lisp( $interpreter, $indent ) . ( ' :value ' . ( $self->{value}->emit_lisp( $interpreter, $indent ) . ')' ) ) ) );
}

package Lit::NamedArgument;
sub new { shift; bless {@_}, "Lit::NamedArgument" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(make-kp6-argument \'named (make-instance \'kp6-pair :key ' . ( $self->{key}->emit_lisp( $interpreter, $indent ) . ( ' :value ' . ( $self->{value}->emit_lisp( $interpreter, $indent ) . '))' ) ) ) );
}

package Lit::Code;
sub new { shift; bless {@_}, "Lit::Code" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(with-kp6-pad (' . ( $interpreter . ( ')' . ( Main::newline() . ( $self->emit_declarations( $interpreter, $indent ) . ( Main::newline() . ( $self->emit_body( $interpreter, $indent ) . ')' ) ) ) ) ) ) );
}

sub emit_body {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{body} } ], Main::newline() );
}

sub emit_signature {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    $self->{sig}->emit_lisp( $interpreter, $indent );
}

sub emit_declarations {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $s = '';
    my $name;
    do {

        for my $name ( @{ $self->{pad}->variable_names() } ) {
            my $decl = Decl->new( 'decl' => 'my', 'type' => '', 'var' => Var->new( 'sigil' => '', 'twigil' => '', 'name' => $name, 'namespace' => [], ), );
            do {
                if ( ( $s ne '' ) ) { $s = ( $s . Main::newline() ) }
                else                { }
            };
            $s = ( $s . $name->emit_lisp( $interpreter, $indent ) );
        }
    };
    return ($s);
}

package Lit::Object;
sub new { shift; bless {@_}, "Lit::Object" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "literal objects")' ) ) );
}

package Index;
sub new { shift; bless {@_}, "Index" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(kp6-lookup ' . ( $self->{obj}->emit_lisp( $interpreter, $indent ) . ( ' (perl->cl ' . ( $self->{index}->emit_lisp( $interpreter, $indent ) . '))' ) ) ) );
}

package Lookup;
sub new { shift; bless {@_}, "Lookup" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    ( '(kp6-lookup ' . ( $self->{obj}->emit_lisp( $interpreter, $indent ) . ( ' (perl->cl ' . ( $self->{index}->emit_lisp( $interpreter, $indent ) . '))' ) ) ) );
}

package Assign;
sub new { shift; bless {@_}, "Assign" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $node = $self->{parameters};
    do {
        if ( Main::isa( $node, 'Var' ) ) { return ( $node->emit_lisp_assignment( $self->{arguments}->emit_lisp( $interpreter, $indent ) ) ) }
        else                             { }
    };
    do {
        if ( ( ( Main::isa( $node, 'Lookup' ) || Main::isa( $node, 'Index' ) ) && Main::isa( $node->obj(), 'Var' ) ) ) {
            return ( ( '(kp6-store ' . ( $node->obj()->emit_lisp() . ( ' (perl->cl ' . ( $node->index()->emit_lisp() . ( ') ' . ( $self->{arguments}->emit_lisp( $interpreter, $indent ) . ')' ) ) ) ) ) ) );
        }
        else { }
    };
    do {
        if ( ( Main::isa( $node, 'Call' ) && ( Main::isa( $node->invocant(), 'Var' ) && ( ( $node->method() eq 'INDEX' ) || ( $node->method() eq 'LOOKUP' ) ) ) ) ) {
            return (
                (   '(kp6-dispatch '
                        . (
                        $node->invocant()->emit_lisp( $interpreter, $indent )
                            . ( ' ' . ( $interpreter . ( ' ' . ( ' :store ' . ( $node->arguments()->[0]->emit_lisp( $interpreter, $indent ) . ( ' ' . ( $self->{arguments}->emit_lisp( $interpreter, $indent ) . ')' ) ) ) ) ) ) )
                        )
                )
            );
        }
        else { }
    };
    ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "assigning to anything other than variables")' ) );
}

package Var;
sub new { shift; bless {@_}, "Var" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( $self->emit_lisp_lookup(0) );
}

sub emit_lisp_name {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '(kp6-generate-variable "' . ( $self->{sigil} . ( '" "' . ( $self->{name} . '")' ) ) ) );
}

sub emit_lisp_namespace {
    my $self   = shift;
    my $List__ = \@_;
    do { [] };
    ( '"' . ( Main::join( $self->{namespace}, '::' ) . '"' ) );
}

sub emit_lisp_lookup {
    my $self   = shift;
    my $List__ = \@_;
    my $cell;
    do { $cell = $List__->[0]; [$cell] };
    my $variant = ( $cell ? '/c' : '' );
    do {
        if ( @{ $self->{namespace} } ) { return ( ( '(lookup-package-variable' . ( $variant . ( ' ' . ( $self->emit_lisp_name() . ( ' ' . ( $self->emit_lisp_namespace() . ')' ) ) ) ) ) ) ) }
        else                           { return ( ( '(lookup-lexical-variable' . ( $variant . ( ' ' . ( $self->emit_lisp_name() . ')' ) ) ) ) ) }
        }
}

sub emit_lisp_assignment {
    my $self   = shift;
    my $List__ = \@_;
    my $value;
    my $cell;
    do { $value = $List__->[0]; $cell = $List__->[1]; [ $value, $cell ] };
    my $variant = ( $cell ? '/c' : '' );
    do {
        if ( @{ $self->{namespace} } ) { return ( ( '(set-package-variable' . ( $variant . ( ' ' . ( $self->emit_lisp_name() . ( ' ' . ( $value . ( ' ' . ( $self->emit_lisp_namespace() . ')' ) ) ) ) ) ) ) ) ) }
        else                           { return ( ( '(set-lexical-variable' . ( $variant . ( ' ' . ( $self->emit_lisp_name() . ( ' ' . ( $value . ')' ) ) ) ) ) ) ) }
        }
}

package Bind;
sub new { shift; bless {@_}, "Bind" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    do {
        if ( Main::isa( $self->{arguments}, 'Var' ) ) { return ( $self->{parameters}->emit_lisp_assignment( $self->{arguments}->emit_lisp_lookup(1), 1 ) ) }
        else                                          { }
    };
    do {
        if ( Main::isa( $self->{arguments}, 'Sub' ) ) { return ( $self->{parameters}->emit_lisp_assignment( $self->{arguments}->emit_lisp( $interpreter, $indent ) ) ) }
        else                                          { }
    };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "binding anything other than variables")' ) ) );
}

package Proto;
sub new { shift; bless {@_}, "Proto" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "proto-objects")' ) ) );
}

package Call;
sub new { shift; bless {@_}, "Call" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    do {
        if ( ( Main::isa( $self->{invocant}, 'Var' ) && ( ( $self->{method} eq 'LOOKUP' ) || ( $self->{method} eq 'INDEX' ) ) ) ) {
            return ( ( '(kp6-dispatch ' . ( $self->{invocant}->emit_lisp( $interpreter, $indent ) . ( ' ' . ( $interpreter . ( ' :lookup ' . ( $self->{arguments}->[0]->emit_lisp( $interpreter, $indent ) . ')' ) ) ) ) ) ) );
        }
        else { }
    };
    my $invocant;
    do {
        if ( Main::isa( $self->{invocant}, 'Proto' ) ) {
            do {
                if   ( ( $self->{invocant}->name() eq 'self' ) ) { $invocant = '$self' }
                else                                             { $invocant = $self->{invocant}->emit_lisp() }
                }
        }
        else { $invocant = $self->{invocant}->emit_lisp() }
    };
    do {
        if ( ( $invocant eq 'self' ) ) { $invocant = '$self' }
        else                           { }
    };
    my $meth = $self->{method};
    do {
        if ( ( $meth eq 'postcircumfix:<( )>' ) ) { $meth = '' }
        else                                      { }
    };
    my $call = Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{arguments} } ], ' ' );
    do {
        if ( $self->{hyper} ) { return ('XXX: Hyper') }
        else {
            do {
                if   ( ( $meth eq '' ) ) { ( '::DISPATCH( ' .   ( $invocant . ( ', \'APPLY\', ' . ( $call .        ( ' )' . Main::newline() ) ) ) ) ) }
                else                     { ( '(kp6-dispatch ' . ( $invocant . ( ' ' .             ( $interpreter . ( ' ' . ( ':' . ( $meth . ( ' ' . ( $call . ( ')' . Main::newline() ) ) ) ) ) ) ) ) ) ) }
                }
        }
        }
}

package Apply;
sub new { shift; bless {@_}, "Apply" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $name = $self->{code}->name();
    do {
        if ( ( $name eq 'infix:<//>' ) ) {
            my $apply_func = ( '(kp6-apply-function ' . ( $interpreter . ( ' ' . ( '(perl->cl (lookup-package-variable (kp6-generate-variable "&" "defined") "GLOBAL")) ' . '(list ' ) ) ) );
            return ( ( '(make-instance \'kp6-Bit :value (or (kp6-true ' . ( $apply_func . ( Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{arguments} } ], '))) (kp6-true ' ) . ')))' ) ) ) );
        }
        else { }
    };
    do {
        if ( ( $name eq 'infix:<&&>' ) ) {
            return (
                (   '(make-instance \'kp6-Bit :value (and (kp6-dispatch (kp6-dispatch '
                        . (
                        Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{arguments} } ], ( ' ' . ( $interpreter . ( ' :true) ' . ( $interpreter . ' :cl-landish) (kp6-dispatch (kp6-dispatch ' ) ) ) ) )
                            . ( ' ' . ( $interpreter . ( ' :true) ' . ( $interpreter . ' :cl-landish)))' ) ) ) )
                        )
                )
            );
        }
        else { }
    };
    do {
        if ( ( $name eq 'infix:<||>' ) ) {
            return (
                (   '(make-instance \'kp6-Bit :value (or (kp6-dispatch (kp6-dispatch '
                        . (
                        Main::join( [ map { $_->emit_lisp( $interpreter, $indent ) } @{ $self->{arguments} } ], ( ' ' . ( $interpreter . ( ' :true) ' . ( $interpreter . ' :cl-landish) (kp6-dispatch (kp6-dispatch ' ) ) ) ) )
                            . ( ' :true) ' . ( $interpreter . ' :cl-landish)))' ) )
                        )
                )
            );
        }
        else { }
    };
    do {
        if ( ( $name eq 'ternary:<?? !!>' ) ) {
            return (
                (   '(if (kp6-dispatch (kp6-dispatch '
                        . (
                        $self->{arguments}->[0]->emit_lisp( $interpreter, $indent )
                            . (
                            ' '
                                . (
                                $interpreter
                                    . (
                                    ' '
                                        . (
                                        ':true) '
                                            . ( $interpreter . ( ' :cl-landish) (progn ' . ( $self->{arguments}->[1]->emit_lisp( $interpreter, $indent ) . ( ') (progn ' . ( $self->{arguments}->[2]->emit_lisp( $interpreter, $indent ) . '))' ) ) ) ) )
                                        )
                                    )
                                )
                            )
                        )
                )
            );
        }
        else { }
    };
    my $op = $self->{code}->emit_lisp( $interpreter, $indent );
    my $str = ( '(kp6-apply-function ' . ( $interpreter . ( ' (perl->cl ' . ( $op . ') (list' ) ) ) );
    do {
        for my $arg ( @{ $self->{arguments} } ) {
            $str = ( $str . ' (make-instance \'kp6-positional-parameter :value ' );
            do {
                if   ( Main::isa( $arg, 'Var' ) ) { $str = ( $str . $arg->emit_lisp_lookup(1) ) }
                else                              { $str = ( $str . ( '(make-kp6-cell ' . ( $arg->emit_lisp( $interpreter, $indent ) . ')' ) ) ) }
            };
            $str = ( $str . ')' );
        }
    };
    $str = ( $str . '))' );
    return ($str);
}

package Return;
sub new { shift; bless {@_}, "Return" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( 'return(' . ( $self->{result}->emit_lisp( $interpreter, $indent ) . ')' ) ) );
}

package If;
sub new { shift; bless {@_}, "If" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $cond = ( '(kp6-dispatch' . ( ' ' . ( '(kp6-dispatch' . ( ' ' . ( $self->{cond}->emit_lisp( $interpreter, $indent ) . ( ' ' . ( $interpreter . ( ' ' . ( ':true)' . ( ' ' . ( $interpreter . ( ' ' . ':cl-landish)' ) ) ) ) ) ) ) ) ) ) ) );
    (   '(cond '
            . (
            Main::newline()
                . (
                '('
                    . (
                    $cond
                        . (
                        ' '
                            . (
                              ( $self->{body} ? $self->{body}->emit_lisp( $interpreter, $indent ) : 'nil' )
                            . ( ')' . ( ( $self->{otherwise} ? ( Main::newline() . ( '(t ' . ( $self->{otherwise}->emit_lisp( $interpreter, $indent ) . ')' ) ) ) : '' ) . ')' ) )
                            )
                        )
                    )
                )
            )
    );
}

package For;
sub new { shift; bless {@_}, "For" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $cond = $self->{cond};
    do {
        if   ( ( Main::isa( $cond, 'Var' ) && ( $cond->sigil() eq '@' ) ) ) { }
        else                                                                { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&', 'twigil' => '', 'name' => 'prefix:<@>', 'namespace' => ['GLOBAL'], ), 'arguments' => [$cond], ) }
    };
    ( '(kp6-for-loop-structure ('
            . ( $interpreter . ( ' ' . ( $self->{topic}->emit_lisp_name() . ( ' ' . ( $cond->emit_lisp( $interpreter, $indent ) . ( ')' . ( Main::newline() . ( ' ' . ( $self->{body}->emit_lisp( $interpreter, $indent ) . ')' ) ) ) ) ) ) ) ) ) );
}

package While;
sub new { shift; bless {@_}, "While" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $cond = $self->{cond};
    do {
        if   ( ( Main::isa( $cond, 'Var' ) && ( $cond->sigil() eq '@' ) ) ) { }
        else                                                                { $cond = Apply->new( 'code' => Var->new( 'sigil' => '&', 'twigil' => '', 'name' => 'prefix:<@>', 'namespace' => ['GLOBAL'], ), 'arguments' => [$cond], ) }
    };
    (   '(loop :while (kp6-dispatch'
            . (
            Main::newline()
                . (
                '  (kp6-dispatch '
                    . (
                    $self->{cond}->emit_lisp( $interpreter, $indent )
                        . (
                        ' ' . ( $interpreter . ( ' :true) ' . ( Main::newline() . ( $interpreter . ( ' :cl-landish)' . ( Main::newline() . ( ' :do ' . ( $self->{body}->emit_lisp( $interpreter, $indent ) . ( ')' . Main::newline() ) ) ) ) ) ) ) ) )
                        )
                    )
                )
            )
    );
}

package Decl;
sub new { shift; bless {@_}, "Decl" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $decl = $self->{decl};
    my $name = $self->{var}->name();
    do {

        if ( ( $decl eq 'our' ) ) {
            return (
                (   '(define-package-variable '
                        . (
                        $self->{var}->emit_lisp_name()
                            . (
                            ' (enclosing-package))'
                                . (
                                Main::newline()
                                    . (
                                    '(define-lexical-variable '
                                        . (
                                        $self->{var}->emit_lisp_name()
                                            . ( ')' . ( Main::newline() . ( '(set-lexical-variable/c ' . ( $self->{var}->emit_lisp_name() . ( ' (lookup-package-variable/c ' . ( $self->{var}->emit_lisp_name() . ' (enclosing-package)))' ) ) ) ) ) )
                                        )
                                    )
                                )
                            )
                        )
                )
            );
        }
        else { }
    };
    do {
        if ( ( $decl eq 'my' ) ) { return ( ( '(define-lexical-variable ' . ( $self->{var}->emit_lisp_name() . ')' ) ) ) }
        else                     { }
    };
    return ( ( '(kp6-error ' . ( $interpreter . ( ' \'kp6-not-implemented :feature "\\"' . ( $decl . '\\" variables")' ) ) ) ) );
}

package Sig;
sub new { shift; bless {@_}, "Sig" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $str = '(make-instance \'kp6-signature';
    do {
        if ( $self->{invocant} ) { $str = ( $str . ( ' :invocant ' . $self->{invocant}->emit_lisp( $interpreter, $indent ) ) ) }
        else                     { }
    };
    $str = ( $str . ' :positional (list' );
    do {
        for my $decl ( @{ $self->{positional} } ) { $str = ( $str . ( ' (make-instance \'kp6-named-parameter :name ' . ( $decl->emit_lisp_name( $interpreter, $indent ) . ')' ) ) ) }
    };
    $str = ( $str . ')' );
    $str = ( $str . ')' );
    return ($str);
}

package Capture;
sub new { shift; bless {@_}, "Capture" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    my $s = '(kp6-new \'capture ';
    do {
        if ( defined( $self->{invocant} ) ) { $s = ( $s . ( 'invocant: ' . ( $self->{invocant}->emit_lisp( $interpreter, $indent ) . ', ' ) ) ) }
        else                                { $s = ( $s . 'invocant: $::Undef, ' ) }
    };
    do {
        if ( defined( $self->{array} ) ) {
            $s = ( $s . 'array: ::DISPATCH( $::Array, "new", { _array => [ ' );
            my $item;
            do {
                for my $item ( @{ $self->{array} } ) { $s = ( $s . ( $item->emit_lisp( $interpreter, $indent ) . ', ' ) ) }
            };
            $s = ( $s . ' ] } ),' );
        }
        else { }
    };
    do {
        if ( defined( $self->{hash} ) ) {
            $s = ( $s . 'hash: ::DISPATCH( $::Hash, "new", { _hash => { ' );
            my $item;
            do {
                for my $item ( @{ $self->{hash} } ) { $s = ( $s . ( $item->[0]->emit_lisp( $interpreter, $indent ) . ( '->{_value} => ' . ( $item->[1]->emit_lisp($interpreter) . ', ' ) ) ) ) }
            };
            $s = ( $s . ' } } ),' );
        }
        else { }
    };
    return ( ( $s . ')' ) );
}

package Subset;
sub new { shift; bless {@_}, "Subset" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "subsets")' ) ) );
}

package Method;
sub new { shift; bless {@_}, "Method" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "methods")' ) ) );
}

package Sub;
sub new { shift; bless {@_}, "Sub" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( '(make-kp6-sub (' . ( $self->{block}->emit_signature( $interpreter, $indent ) . ( ')' . ( Main::newline() . ( $self->{block}->emit_body( $interpreter, $indent ) . ')' ) ) ) ) ) );
}

package Do;
sub new { shift; bless {@_}, "Do" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    $self->{block}->emit_lisp( $interpreter, $indent );
}

package BEGIN;
sub new { shift; bless {@_}, "BEGIN" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "BEGIN blocks")' ) ) );
}

package Use;
sub new { shift; bless {@_}, "Use" }

sub emit_lisp {
    my $self   = shift;
    my $List__ = \@_;
    my $interpreter;
    my $indent;
    do { $interpreter = $List__->[0]; $indent = $List__->[1]; [ $interpreter, $indent ] };
    do {
        if ( ( $self->{mod} eq 'v6' ) ) { return ( (undef) ) }
        else                            { }
    };
    return ( ( '(kp6-error ' . ( $interpreter . ' \'kp6-not-implemented :feature "importing modules")' ) ) );
}

1;
