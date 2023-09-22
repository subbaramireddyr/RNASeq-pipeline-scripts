#!/usr/bin/env bash
# sortAll.sh
# Usage: bash scripts/sortAll.sh 1>results/logs/sortAll.log 2>results/logs/sortAll.err &

# Initialize variable to contain the directory of .sam files
samFilesPath="results/sam/"

# Initialize variable to contain the suffix for the align reads
suffix=".sam"
bamSuffix=".sorted.bam"
bamOutPath="results/bam/"

# Create needed folders
mkdir -p $bamOutPath

# sortAll will loop through all files and sort them
function sortAll {
    # Loop through all the aligned files in $samFilesPath
    for samInFile in $samFilesPath*$suffix
    do
      	# Remove the path from the filename and assign to pathRemoved
        pathRemoved="${samInFile/$samFilesPath/}"
        # Remove the suffix from $pathRemoved and assign to sampleName
        sampleName="${pathRemoved/$suffix/}"
        # Print $sampleName to see that it contains after removing the path
        echo $sampleName
        samtools sort \
	$samFilesPath$sampleName.sam \
	-o $bamOutPath$sampleName$bamSuffix 
    done
}
sortAll
