#!/bin/perl
#Warning: you should check the integrity of the results, the command you enter may like this:
#	perl -0ne 'print "$ARGV\n" unless (/FINISHED/)' *txt
#if some results are not complete,you should get the complete results by running the program.

use v5.16;
use warnings;
use utf8;
use File::Basename;

my $output_dir="SMART_results";
foreach (<$output_dir/*txt>){
my @list=(split /_/,basename $_);
my $prefix=join("_",@list[0..$#list-2]);
open FILE,"<",$_;
my @contents=<FILE>;
my @positions = grep { $contents[$_]=~/STATUS=visible/ } 0..$#contents;
foreach (@positions){
chomp;
my @pos=($_-4,$_-3,$_-5);
my @items;
foreach (@contents[@pos]){
chomp;
my $item=(split /=/)[1];
push @items,$item;
}
unshift @items,$prefix;
my $line=join("\t",@items);
print "$line\n";
}
close FILE;
}






