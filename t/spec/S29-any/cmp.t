use v6-alpha;
use Test

plan tests => 3;

# L<S29/Any/"=item cmp">

is('a' cmp 'a', 0,  'a is equal to a');
is('a' cmp 'b', -1, 'a is less than b');
is('b' cmp 'a', 1,  'b is greater than a');

