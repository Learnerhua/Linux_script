#!/bin/perl

use v5.16;
use warnings;
use utf8;
#后面接一个SMART软件整理后的输出文件
#这个脚本能将同一条序列的结构域收集在一起并以分号隔开

my %hash;
while(<>){
my ($key,$value)=(split)[0,3];
$hash{$key} .= "$value;";
}
say "$_\t$hash{$_}" foreach (keys %hash);
