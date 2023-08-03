#!/bin/bash
set -euxo pipefail
work_dir=$(dirname `readlink -f $0`)
cd $work_dir
out_dir=$work_dir/fastqResult

for dir in $work_dir/SRR*;do
	prefix=`basename ${dir%.*}`
	pfastq-dump ${prefix}/${prefix}.sra --split-3 --gzip -O ${out_dir} -t 40
done



