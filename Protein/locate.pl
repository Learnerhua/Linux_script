#!/bin/perl
use v5.16;
use warnings;
use utf8;
#已知一个文件中的序列是来自另一个文件，根据这个脚本确定那些序列的位置

my $fasta_file="ACPs31.fasta";
my $domain_file="all.fasta";

open FULL,"<",$fasta_file or die "Cannot open $fasta_file : $!";
my @full_fasta;
while (<FULL>){
chomp;
push @full_fasta,$_;
}
my %full_fasta=@full_fasta;

open DOMAIN,"<",$domain_file or die "Cannot open $domain_file : $!";
my @domain_fasta;
while (<DOMAIN>){
chomp;
push @domain_fasta,$_;
}
my %domain_fasta=@domain_fasta;

my @locate_result;
foreach (keys %full_fasta){
	my $line=$_;
	my @array=grep {/$line/}(keys %domain_fasta);
	my $full_fasta=$full_fasta{$line};
	foreach (@array){
	my $domain_fasta=$domain_fasta{$_};
	my $len=length($domain_fasta);
	my $start=index($full_fasta,$domain_fasta)+1;
	my $end=$start+$len-1;
	s/>//;
	my @list=($_,"$start-$end");
	push @locate_result,@list;
	}
}
#print "$_\n" foreach @locate_result;
my %locate_result=@locate_result;
print "ID\tLength\tP1\tP2\tP3\tP4\tP5\tP6\tP7\n";
foreach (keys %full_fasta){
my $line=s/>//r;
my @IDs;
push @IDs,"${line}_P$_" foreach (1..7);
my $name=">$line";
my $full_length=length($full_fasta{$name});
$line.="\t$full_length";
$line.="\t$locate_result{$_}" foreach (@IDs);
print "$line\n";
}
