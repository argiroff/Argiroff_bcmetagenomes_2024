#!/bin/bash

# name: filter_adapters_local.sh
# author: William Argiroff
# inputs: interleaved fastq in data/int/
# output: fastq with adapter contamination removed in data/adaptfilt/

# Activate conda environment
source activate megahit_env

# Get input and output filenames
infile=`echo "$1"`
outdir=`echo "$2"`
outpre=`echo "$3"`

# Assemble reads
megahit --12 $infile -o $outdir --out-prefix $outpre --presets meta-large -t 10

# Deactivate conda environment
conda deactivate

echo 'Done.'
