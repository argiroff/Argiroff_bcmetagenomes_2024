#!/bin/bash

# name: filter_adapters_local.sh
# author: William Argiroff
# inputs: interleaved fastq in data/int/
# output: fastq with adapter contamination removed in data/adaptfilt/

# Get input and output filenames
infile=`echo "$1"`
outfile=`echo "$2"`

# Filter out adapter sequences
./code/bbmap/bbduk.sh bbduk.sh in=$infile out=$outfile maq=20

echo 'Done.'
