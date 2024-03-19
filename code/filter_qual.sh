#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=qual_%a
#SBATCH --output=qual_%a.out
#SBATCH -p batch 
#SBATCH -A bsd
#SBATCH --array=1-80

# name: filter_qual.sh
# author: William Argiroff
# inputs: fastq with phiX contamination removed
# output: quality filtered fastq

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

inlist=`echo "$1"`
outlist=`echo "$2"`

# Get intput files according to task ID
infile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$inlist")
outfile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$outlist")

# Filter files
./code/bbmap/bbduk.sh bbduk.sh in=$infile out=$outfile maq=20 threads=32

echo 'Done.'
