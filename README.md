 # RNA-seq Analysis Pipeline

This pipeline used to process and analyze RNA-seq data, including quality control, trimming, alignment, sorting, and counting features. Each step in the pipeline is essential for preparing raw sequencing data for downstream analyses, such as differential gene expression.

## Overview of Scripts

### 1. fastQC.sh
Purpose: Perform quality control checks on raw FASTQ files.
Command: `fastqc data/rawreads/*.fastq -o fastqc/`
Input: Raw FASTQ files located in `data/rawreads/`.
Output: HTML and summary QC reports for each FASTQ file in the `fastqc/` directory.
Log: Results are written to `results/logs/fastqc.log` and errors to `results/logs/fastqc.err`.

### 2. trimAll.sh
Purpose: Trim low-quality bases and adapter sequences from paired-end FASTQ files using Trimmomatic.
Command: The script loops through all paired-end FASTQ files, trimming them using Trimmomatic.
Input: Raw FASTQ files (`.R1.fastq`, `.R2.fastq`) in `data/rawreads/`.
Output: Trimmed FASTQ files (paired and unpaired) in `data/trimmed/paired/` and `data/trimmed/unpaired/`.
Log: Results are written to `results/logs/trimAll.log` and errors to `results/logs/trimAll.err`.

### 3. alignAll.sh
Purpose: Align the trimmed paired-end FASTQ files to a reference genome using HISAT2.
Command: The script aligns each pair of reads and outputs a SAM file for each sample.
Input: Trimmed paired-end FASTQ files from `data/trimmed/paired/`.
Output: SAM files in `results/sam/`.
Log: Results are written to `results/logs/alignAll.log` and errors to `results/logs/alignAll.err`.

### 4. sortAll.sh
Purpose: Sort the aligned SAM files by genomic position using samtools.
Command: The script sorts each SAM file and outputs a sorted BAM file.
Input: SAM files from `results/sam/`.
Output: Sorted BAM files in `results/bam/`.
Log: Results are written to `results/logs/sortAll.log` and errors to `results/logs/sortAll.err`.

### 5. featureCounts.sh
Purpose: Count the number of reads aligned to each gene using `featureCounts` from the sorted BAM files.
Command: The script counts the reads mapped to gene features using the annotation file (GTF) and sorted BAM files.
Input: Sorted BAM files from `results/bam/` and an annotation file.
Output: Gene counts in the specified output path.
Log: Results are written to `results/logs/featureCounts.log` and errors to `results/logs/featureCounts.err`.

## Workflow Summary

1. Quality Control: `fastQC.sh` generates reports on the quality of raw sequencing data.
2. Trimming: `trimAll.sh` trims the reads to remove low-quality bases and adapter contamination.
3. Alignment: `alignAll.sh` aligns the trimmed reads to the reference genome, generating SAM files.
4. Sorting: `sortAll.sh` sorts the aligned reads by genomic position, producing BAM files.
5. Counting: `featureCounts.sh` counts the number of reads mapped, generating a gene-level count matrix.
