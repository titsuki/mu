#!/usr/bin/pugs

use v6;
require Test;

=pod

I/O tests

=cut

plan 38;

my $filename = 'tempfile';

# create and write a file

my $out = open(">$filename");
is(ref($out), 'Handle', 'got a file handle');
$out.print("Hello World\n");
print($out, "Foo Bar Baz\n");
$out.print("The End\n");
ok($out.close, 'file closed okay');

# read the file all possible ways

my $in1 = open($filename);
is(ref($in1), 'Handle', 'got a file handle');
my $line1a = readline($in1);
is($line1a, "Hello World\n", 'readline($in) worked');
my $line1b = readline($in1);
is($line1b, "Foo Bar Baz\n", 'readline($in) worked');
my $line1c = readline($in1);
is($line1c, "The End\n", 'readline($in) worked');
ok($in1.close, 'file closed okay');

my $in2 = open($filename);
is(ref($in2), 'Handle', 'got a file handle');
my $line2a = $in2.readline();
is($line2a, "Hello World\n", '$in.readline() worked');
my $line2b = $in2.readline();
is($line2b, "Foo Bar Baz\n", '$in.readline() worked');
my $line2c = $in2.readline();
is($line2c, "The End\n", '$in.readline() worked');
ok($in2.close, 'file closed okay');

my $in3 = open($filename);
is(ref($in3), 'Handle', 'got a file handle');
my $line3a = =$in3;
is($line3a, "Hello World\n", 'unary =$in worked');
my $line3b = =$in3;
is($line3b, "Foo Bar Baz\n", 'unary =$in worked');
my $line3c = =$in3;
is($line3c, "The End\n", 'unary =$in worked');
ok($in3.close, 'file closed okay');

# append to the file

my $append = open(">>$filename");
is(ref($append), 'Handle', 'got a file handle');
$append.print("... Its not over yet!\n");
ok($append.close, 'file closed okay');

# now read in in list context

my $in4 = open($filename);
my @lines4 = readline($in4);
is(+@lines4, 4, 'we got two lines from the file');
is(@lines4[0], "Hello World\n", 'readline($in) worked in list context');
is(@lines4[1], "Foo Bar Baz\n", 'readline($in) worked in list context');
is(@lines4[2], "The End\n", 'readline($in) worked in list context');
is(@lines4[3], "... Its not over yet!\n", 'readline($in) worked in list context');
ok($in4.close, 'file closed okay');

my $in5 = open($filename);
my @lines5 = $in5.readline();
is(+@lines5, 4, 'we got two lines from the file');
is(@lines5[0], "Hello World\n", '$in.readline() worked in list context');
is(@lines5[1], "Foo Bar Baz\n", '$in.readline() worked in list context');
is(@lines5[2], "The End\n", '$in.readline() worked in list context');
is(@lines5[3], "... Its not over yet!\n", '$in.readline() worked in list context');
ok($in5.close, 'file closed okay');

my $in6 = open($filename);
my @lines6 = =$in6;
is(+@lines6, 4, 'we got two lines from the file');
is(@lines6[0], "Hello World\n", 'unary =$in worked in list context');
is(@lines6[1], "Foo Bar Baz\n", 'unary =$in worked in list context');
is(@lines6[2], "The End\n", 'unary =$in worked in list context');
is(@lines6[3], "... Its not over yet!\n", 'unary =$in worked in list context');
ok($in6.close, 'file closed okay');

# now be sure to delete the file as well

ok(?unlink($filename), 'file has been removed');
