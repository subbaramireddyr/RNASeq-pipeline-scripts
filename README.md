 # RNA-seq Analysis Pipeline

This pipeline used to process and analyze RNA-seq data, including quality control, trimming, alignment, sorting, and counting features. Each step in the pipeline is essential for preparing raw sequencing data for downstream analyses, such as differential gene expression.

## Overview of Scripts

### 1. fastQC.sh

To conduct quality control checks on raw FASTQ files, the following command is executed: `fastqc data/rawreads/*.fastq -o fastqc/`. This command processes all FASTQ files located within the `data/rawreads/` directory, generating detailed HTML reports and summary QC metrics for each file. The output is directed to the `fastqc/` directory. The log of this operation, including results and status updates, is captured in `results/logs/fastqc.log`, while any errors encountered during execution are logged in `results/logs/fastqc.err`.

### 2. trimAll.sh

To trim low-quality bases and adapter sequences from paired-end FASTQ files, This script is executed that loops through all raw FASTQ files (`.R1.fastq`, `.R2.fastq`) in the `data/rawreads/` directory and processes them using Trimmomatic. Output consists of trimmed paired-end FASTQ files saved in `data/trimmed/paired/` and unpaired reads in `data/trimmed/unpaired/`. Logs detailing the trimming process are recorded in `results/logs/trimAll.log`, while any errors encountered are captured in `results/logs/trimAll.err`.

### 3. alignAll.sh

To align the trimmed paired-end FASTQ files to a reference genome, a script is executed using HISAT2. The script processes each pair of trimmed reads from the `data/trimmed/paired/` directory, aligning them to the reference genome and producing a SAM file for each sample. The resulting SAM files are stored in the `results/sam/` directory. Logs detailing the alignment process are recorded in `results/logs/alignAll.log`, while any errors encountered during the operation are logged in `results/logs/alignAll.err`.

### 4. sortAll.sh

To sort the aligned SAM files by genomic position, a script utilizing Samtools is executed. This script processes each SAM file from the `results/sam/` directory, sorting the alignments and producing corresponding sorted BAM files. The sorted BAM files are saved in the `results/bam/` directory. Logs of sorting process are captured in `results/logs/sortAll.log`, while any errors that occur during execution are recorded in `results/logs/sortAll.err`.

### 5. featureCounts.sh

To count the number of reads aligned to each gene, the `featureCounts` tool is employed on the sorted BAM files. A script is executed that utilizes the annotation file (GTF) along with the sorted BAM files from the `results/bam/` directory to count the reads mapped to gene features. The resulting gene counts are saved in the specified output path. Logs detailing the counting process are recorded in `results/logs/featureCounts.log`, while any errors encountered during execution are captured in `results/logs/featureCounts.err`.

## Workflow Summary

Analysis pipeline begins with quality control, where the script `fastQC.sh` generates reports assessing the quality of the raw sequencing data. Following this, the `trimAll.sh` script is executed to trim the reads, effectively removing low-quality bases and adapter contamination. Next, the `alignAll.sh` script aligns the trimmed reads to the reference genome, producing SAM files. The alignment results are then processed by the `sortAll.sh` script, which sorts the aligned reads by genomic position to generate BAM files. Finally, the `featureCounts.sh` script counts the number of reads mapped to each gene, resulting in a gene-level count matrix for downstream analysis.
