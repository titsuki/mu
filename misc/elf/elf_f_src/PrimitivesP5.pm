
sub header is p5 {'use Math::Trig qw();'}
header();


class Num {
sub pi() is p5 {'Math::Trig::pi();'}
}

$*PID = (sub () is p5 {'$$'}).();

package GLOBAL { # sub *f(){} isn't working yet.

  sub primitive_runtime_version is p5 {'CORE::sprintf "perl %vd", $^V'}

}

class Any {
  method perl() { self.WHAT ~ '.new(!!!)' }
}
class STRING {
  method perl() is p5 {'q{"} . CORE::quotemeta($self) . q{"}'}
}
class INTEGER {
  method perl() { ''~self }
}
class FLOAT {
  method perl() { ''~self }
}
class ARRAY {
  method perl() { '[' ~ self.map(sub($e){$e.perl()}).join(",") ~ ']' }
}
class HASH {
  method perl() {
    '{' ~ self.keys.map(sub($k){$k.perl() ~ ' => ' ~ self.{$k}.perl}).join(", ") ~ '}'
  }
}
