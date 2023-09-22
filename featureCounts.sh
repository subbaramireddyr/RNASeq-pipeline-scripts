#!/usr/bin/env bash
# featureCounts.sh
# Usage: bash scripts/featureCounts.sh 1>results/logs/featureCounts.log 2>results/logs/featureCounts.err &

annotation_file="path_to_Homo_sapiens.GRCh38.109.gtf"
outputpath="path_to_output_file"
inputpath="Path_to_.sorted.bam"


featureCounts -T 8 -p \
              -t exon \
              -g gene_id \
              -a $annotation_file \
              -o $outputpath \
              $inputpath
