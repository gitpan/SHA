#!/usr/local/bin/perl -w

require 'getopts.pl';
use SHA qw(sha_version);
$ver = &sha_version();

sub do_test
{
    my ($label, $str, $expect0, $expect1) = @_;
    my ($c, @tmp);
    my $sha = new SHA;
    $sha->add($str);
    $expect = ($ver eq 'SHA-1') ? $expect1 : $expect0;
    print "$label:\nEXPECT:   $expect\n";
    print "RESULT 1: " . $sha->hexdigest() . "\n";
    print "RESULT 2: " . $sha->hexhash($str) . "\n";
# set run_big_test to 0 if you run out of memory if you run out of memory
    $run_big_test = 0;
    if ($run_big_test) {
	$sha->reset();
	@tmp = split(//, $str);
	foreach $c (@tmp) {
	    $sha->add($c);
	}
	print "RESULT 3: " . $sha->hexdigest() . "\n";
    }
}

undef $opt_x;
undef $opt_h;
&Getopts('s:xh');

print "Using digest version $ver, library version $SHA::VERSION\n";
$sha = new SHA;

if (defined($opt_s)) {
    $sha->add($opt_s);
    print("$ver(\"$opt_s\") = " . $sha->hexdigest() . "\n");
} elsif ($opt_h) {
    print <<"END_OF_STRING";
Usage:
    $0 -h               print this message, then quit
    $0 -x               perform some tests of the digest function
    $0 -s "string"      compute the digest of the specified string
    $0 file1 file2 ...  compute the digests of the specified file(s)
    $0                  compute the digest of standard input
END_OF_STRING
    exit;
} elsif ($opt_x) {
    print <<"END_OF_STRING";
If the following results don't match, check that the byte order
is correctly set in 'endian.h', and that you are using the version
of SHA that you expect (SHA or SHA-1).
END_OF_STRING
    do_test("test1",
	"abc",
	"0164b8a9 14cd2a5e 74c4f7ff 082c4d97 f1edf880",
	"a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d");
    do_test("test2",
	"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
	"d2516ee1 acfa5baf 33dfc1c4 71e43844 9ef134c8",
	"84983e44 1c3bd26e baae4aa1 f95129e5 e54670f1");
    do_test("test3",
	"a" x 1000000,
	"3232affa 48628a26 653b5aaa 44541fd9 0d690603",
	"34aa973c d4c4daa4 f61eeb2b dbad2731 6534016f");
} else {
    if (scalar @ARGV > 0) {
	foreach $ARGV (@ARGV) {
	    die "Can't open file '$ARGV' ($!)\n" unless open(ARGV, $ARGV);
	    $sha->reset();
	    $sha->addfile(*ARGV{IO});
	    print "$ver($ARGV) = " . $sha->hexdigest() . "\n";
	    close(ARGV);
	}
    } else {
	$sha->reset();
	$sha->addfile(STDIN);
	print "$ver(STDIN) = " . $sha->hexdigest() . "\n";
    }
}
exit 0;
