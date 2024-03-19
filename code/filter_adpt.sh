#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=64G
#SBATCH --job-name=adpt_%a
#SBATCH --output=adpt_%a.out
#SBATCH -p batch 
#SBATCH -A bsd
#SBATCH --array=1-80

# name: filter_adpt.sh
# author: William Argiroff
# inputs: interleaved fastq with R1 followed by R2
# output: fastq with adapter contamination removed

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

inlist=`echo "$1"`
outlist=`echo "$2"`

# Get intput files according to task ID
infile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$inlist")
outfile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$outlist")

# Interleave files
./code/bbmap/bbduk.sh in=$infile out=$outfile ref=code/bbmap/resources/adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo

echo 'Done.'
