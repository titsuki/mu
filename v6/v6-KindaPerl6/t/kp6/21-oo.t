use v6-alpha;
class Foo {
    method ok1() {
        say "ok 1";
    };
    method ok2() {
        say "ok 2";
    }
}
module Main {
    say '1..2';
    my $foo = Foo.new();
    $foo.ok1();
    $foo.ok2();
}
