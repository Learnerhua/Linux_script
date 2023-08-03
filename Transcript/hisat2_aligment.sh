#!/bin/bash
set -euxo pipefail
work_dir=$(dirname `readlink -f $0`)/..

for ID in `cat accession_list.txt`;do
	hisat2 -t -p 40 --dta -x $work_dir/rawData/target_gene/CG_targetGene_index -1 $work_dir/rawData/transcriptome_prefetch/fastqFiltered/${ID}_1_val_1.fq.gz -2 $work_dir/rawData/transcriptome_prefetch/fastqFiltered/${ID}_2_val_2.fq.gz -S ${ID}_target.sam && samtools view -bS ${ID}_target.sam > ${ID}_target.bam
samtools view -@ 40 -bF 12 ${ID}_target.bam > ${ID}_target_map_pair.bam && samtools sort ${ID}_target_map_pair.bam -o ${ID}_target_map_sort_pair.bam -@ 40 && samtools index ${ID}_target_map_sort_pair.bam
done
