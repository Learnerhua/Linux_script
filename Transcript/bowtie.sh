#!/bin/bash
set -euxo pipefail
work_dir=$(dirname `readlink -f $0`)
cd $work_dir

prefix="m33922_transcript"
index_file="${work_dir}/${prefix}_index"
threads=40

if [ ! -d $index_file ];then
	mkdir $index_file
fi

cd $index_file
bowtie2-build ${work_dir}/rawData/${prefix}.fasta  ${prefix}_index --threads ${threads} > build_index.log
cd $work_dir
bowtie2 -p ${threads} -q --no-unal -x ${index_file}/${prefix}_index -1 ${work_dir}/rawData/GC1_1.fq -2 ${work_dir}/rawData/GC1_2.fq -S ${prefix}.sam 2>align_stats.txt
samtools view -Sb ${prefix}.sam -@ $threads -o ${prefix}.bam
samtools view -Sb ${prefix}.bam -F 12 -@ $threads -o ${prefix}_filtered.bam
samtools sort ${prefix}_filtered.bam -o ${prefix}_filteredSorted.bam -@ ${threads}
samtools index ${prefix}_filteredSorted.bam -@ ${threads}
samtools faidx ${work_dir}/rawData/${prefix}.fasta
#The following command can only be run when your terminal has good compatibility with your server.
#igv.sh -g ${2} ${prefix}_coordSorted.bam
