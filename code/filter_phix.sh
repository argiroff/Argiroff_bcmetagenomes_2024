#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=phix_%a
#SBATCH --output=phix_%a.out
#SBATCH -p batch 
#SBATCH -A bsd
#SBATCH --array=1-80

# name: filter_adpt.sh
# author: William Argiroff
# inputs: fastq with adapter contamination removed
# output: fastq with phiX contamination removed

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

inlist=`echo "$1"`
outlist=`echo "$2"`

# Get intput files according to task ID
infile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$inlist")
outfile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$outlist")

# Interleave files
./code/bbmap/bbduk.sh in=$infile out=$outfile ref=code/bbmap/resources/phix174_ill.ref.fa.gz ktrim=r k=23 mink=11 hdist=1 tpe tbo threads=32

echo 'Done.'
