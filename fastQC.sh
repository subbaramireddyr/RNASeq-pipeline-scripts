#!/usr/bin/env bash
# fastQC.sh

# check for fasta sequence quality for every sequence and output html files to fastqc folder
fastqc data/rawreads/*.fastq -o fastqc/
