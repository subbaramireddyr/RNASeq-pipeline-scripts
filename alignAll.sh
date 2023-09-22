#!/usr/bin/env bash
# alignAll.sh
# Usage: bash scripts/alignAll.sh 1>results/logs/alignAll.log 2>results/logs/alignAll.err &

# Initialize variable to contain the directory of paired fastq files
genome_index="Path_to_reference" 
fastqPath="Path_to_fastq_files""

# Initialize variable to contain the suffix for the left reads
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"
samOutPath="results/sam/"

# Create needed folders
mkdir -p $samOutPath 

# alignAll will loop through all files and align them
function alignAll {
    # Loop through all the left-read fastq files in $fastqPath
    for leftInFile in $fastqPath*$leftSuffix
    do
        # Remove the path from the filename and assign to pathRemoved
        pathRemoved="${leftInFile/$fastqPath/}"
        # Remove the left-read suffix from $pathRemoved and assign to suffixRemoved
        sampleName="${pathRemoved/$leftSuffix/}"
        # Print $sampleName to see what it contains after removing the path
        echo $sampleName
        hisat2 -p 4 \
               -x $genome_index \
               -1 $fastqPath$sampleName$leftSuffix \
               -2 $fastqPath$sampleName$rightSuffix \
               -S $samOutPath$sampleName.sam
    done
}
alignAll
