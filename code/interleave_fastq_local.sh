#!/bin/bash

# name: interleave_fastq_local.sh
# author: William Argiroff
# inputs: R1 fastq, R2 fastq
# output: interleaved fastq with R1 followed by R2

# Get input and output filenames
infileR1=`echo "$1"`
infileR2=`echo "$2"`
outfile=`echo "$3"`

# Interleave files
./code/bbmap/reformat.sh in1=$infileR1 in2=$infileR2 out=$outfile

echo 'Done.'
