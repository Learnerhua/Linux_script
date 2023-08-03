#!/bin/bash
set -euxo pipefail

work_dir=$(dirname `readlink -f $0`)
input_dir=${work_dir}/Pla_ACPs_213_fastafile
output_dir=${work_dir}/Pla_ACPs_213_cdhit

if [ ! -d $output_dir ];then
	mkdir ${output_dir}
else
	rm -rf ${output_dir}
	mkdir ${output_dir}
fi

for file in ${input_dir}/*;do
	prefix=`basename ${file%%.*}`
	cd-hit -i ${file} -o ${output_dir}/${prefix}_cdhit.fasta -M 0 -T 0 -c 0.9 -n 5 -d 0 -g 1
done


