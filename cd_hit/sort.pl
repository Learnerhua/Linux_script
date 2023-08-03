#!/bin/perl
use v5.16;
use warnings;
use utf8;

my $input_file="rawData/Pla_ACPs_213.fasta";
my $out_dir="Pla_ACPs_213_fastafile";
mkdir $out_dir unless (-d $out_dir);

open INPUT,"<",$input_file or die "Cannot open file $input_file : $!";
my %hash;
while (<INPUT>){
chomp;
my $specie=(split)[0];
my $abbre=(split)[1];
my $seq=(split)[2];
$hash{$specie}.="${abbre}\t${seq}\n";
}

foreach (keys %hash){
my $result_file="$out_dir/$_.fasta";
unlink $result_file if (-f $result_file);
}

foreach (keys %hash){
my $result_file="$out_dir/$_.fasta";
open OUT,">",$result_file  or die "Cannot open file $_.fasta : $!";
print OUT "$hash{$_}";
close OUT;
}

#The next command line:
system q(perl -i -wpe '$_=">".$_;s/\t/\n/' Pla_ACPs_213_fastafile/*);



