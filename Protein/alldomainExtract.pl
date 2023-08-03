#!/bin/perl

use v5.16;
use warnings;
use utf8;
#在fasta_file中将position_file中存在的序列片段全部提取出来

my $fasta_file="ACPs157.fasta";
my $position_file="allApeCdomain.txt";

open FASTA,"<",$fasta_file or die "Cannot open $fasta_file : $!";
my @fasta_array;
while (<FASTA>){
chomp;
s/>// if />/;
push @fasta_array,$_;
}
#say "@fasta_array";
my %fasta_hash=@fasta_array;
#print "$_\n" foreach (keys %fasta_hash);

open POS,"<",$position_file or die "Cannot open $position_file : $!";
while (<POS>){
my ($ID,$start,$end)=(split /\s+/)[0..2];
my $seq=substr($fasta_hash{$ID},$start-1,$end-$start+1);
print ">${ID}_${start}\n${seq}\n";
}



