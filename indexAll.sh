#!/usr/bin/env bash
# indexAll.sh
# Usage: bash scripts/indexAll.sh 1>results/logs/indexAll.log 2>results/logs/indexAll.err &

# Initialize variable to contain the directory of .sam files
bamFilesPath="results/bam/"

# Initialize variable to contain the suffix for the align reads
suffix=".sorted.bam"
baiSuffix="sorted.bam.bai"
baiOutPath="results/bam/"

# Create needed folders
mkdir -p $baiOutPath

# indexAll will loop through all files and index them
function indexAll {
    # Loop through all the bam files in $bamFilesPath
    for bamInFile in $bamFilesPath*$suffix
    do
      	# Remove the path from the filename and assign to pathRemoved
        pathRemoved="${bamInFile/$bamFilesPath/}"
        # Remove the suffix from $pathRemoved and assign to sampleName
        sampleName="${pathRemoved/$suffix/}"
        # Print $sampleName to see that it contains after removing the path
        echo $sampleName
	samtools index \
	$baiOutPath$sampleName$suffix 
    done 
}
indexAll
