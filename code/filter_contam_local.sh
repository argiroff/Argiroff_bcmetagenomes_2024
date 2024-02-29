#!/bin/bash

# name: filter_contam_local.sh
# author: William Argiroff
# inputs: interleaved fastq in data/int/
# output: fastq with adapter contamination removed in data/adaptfilt/ or
#       fastq with PhiX contamination removed in data/phixfilt/

# Get input and output filenames
infile=`echo "$1"`
reffile=`echo "$2"`
outfile=`echo "$3"`

# Filter out adapter sequences
./code/bbmap/bbduk.sh in=$infile out=$outfile ref=$reffile ktrim=r k=23 mink=11 hdist=1 tpe tbo

echo 'Done.'
