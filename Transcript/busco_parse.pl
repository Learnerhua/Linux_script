#!/bin/perl
use v5.16;
use warnings;
use utf8;

my $input_file="BUSCO_targetGene.depth";
my $output_file="BUSCO_targetGene_result.txt";
unlink $output_file if(-f $output_file);
my %ID_Count;
open INPUT,'<',$input_file or die "Cannot open file $input_file ";

while (<INPUT>){
my $ID=(split)[0];
$ID_Count{$ID}++;
}

open INPUT,'<',$input_file or die "Cannot open file $input_file";
my @input_content=<INPUT>;

open OUTPUT,'>>',$output_file or die "Cannot open file $output_file";
while (my ($ID,$length)=each %ID_Count){
#say $length;
my $seq=$length/100;
my @threshold;
for (my $i=1;$i<$length+$seq;$i+=$seq){
push @threshold,$i;
}
#say "@threshold";
my %sum;
foreach (@input_content){
if (/$ID/){
chomp;
my $position=(split)[1];
my $read_count=(split)[2];
for (my $i=0;$i<100;$i++){
my $start=$threshold[$i];
my $end=$threshold[$i+1];
if ($position>=$start && $position<$end){
$sum{"${ID}_partition_$i"}+=$read_count;
last;
}
}
}
}
#say qq(${ID}_partition_$_:$sum{"${ID}_partition_$_"}) foreach(0..99);
print OUTPUT "$ID\t";
print OUTPUT qq($sum{"${ID}_partition_$_"}\t) foreach (0..99);
print OUTPUT "\n";
}

