#!/bin/perl
use v5.16;
use warnings;
use utf8;
#本脚本能够将含有特定关键字的结构域片段提取出来

my $fasta_file="Pla_ACP_tblastn_proteinRename.fasta";
my $position_file="Pla_ACP_tblastn_protein_Domain.txt";
my $spe_class="Rha";
my $target_domain="KR";

open FASTA,"<",$fasta_file or die "Cannot open file $fasta_file : $!";
my @fasta=<FASTA>;
chomp foreach (@fasta);
my %fasta_hash=@fasta;
#print "$_\t$fasta_hash{$_}\n" foreach keys %fasta_hash;

open POS,"<",$position_file or die "Cannot open file $position_file : $!";
my @positions;
while (<POS>){
chomp;
if (/${spe_class}.*${target_domain}/){
my @position= (split)[0,1,2];
my $element="$position[0]"." $position[1]"." $position[2]";
push @positions,$element;
}}
#print "$_\n" foreach @positions;
#print "$_\t$fasta_hash{$_}\n" foreach keys %fasta_hash;
foreach (@positions){
my ($ID,$start,$end)=(split)[0,1,2];
my $len=$end-$start+1;
my $seq= substr $fasta_hash{">$ID"},$start-1,$len;
print ">$ID\n$seq\n";
}
