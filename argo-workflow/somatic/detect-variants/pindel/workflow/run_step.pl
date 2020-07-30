#!/usr/bin/perl

use strict;
use warnings;

use IO::File;

unless (@ARGV > 5) {
    die "Usage: $0 normal.bam tumor.bam insert_size normal_sample_name tumor_sample_name <args>";
}

my ($normal_bam, $tumor_bam, $insert_size, $normal_name, $tumor_name, @args) = @ARGV;

my $fh = IO::File->new("> pindel.config");

$fh->say(join("\t", $normal_bam, $insert_size, $normal_name));
$fh->say(join("\t", $tumor_bam, $insert_size, $tumor_name));
$fh->close;

exit system(qw(/usr/bin/pindel -i pindel.config -w 70 -T 5 -o all), @args);
