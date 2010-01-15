use v6;
use Test;
plan *;

#L<S03/"Smart matching"/Regex Hash hash key grep>
{
    my %h = (moep => 'foo', bar => 'baz');
    ok  (/oep/ ~~ %h),      'Regex ~~ Hash (+,1)';
    ok  (/bar/ ~~ %h),      'Regex ~~ Hash (+,2)';
    ok !(/ugh/ ~~ %h),      'Regex ~~ Hash (-,1)';
    ok !(/foo/ ~~ %h),      'Regex ~~ Hash (-,value)';
}

done_testing;

# vim: ft=perl6
