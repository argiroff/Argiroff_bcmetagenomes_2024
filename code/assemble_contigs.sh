#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=mega_%a
#SBATCH --output=mega_%a.out
#SBATCH -p batch 
#SBATCH -A bsd
#SBATCH --array=1-10

# name: assemble_contigs.sh
# author: William Argiroff
# inputs: quality filtered fastq
# output: fasta of assembled contigs and additional temp files from megahit

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

# Activate python environment
source activate megahit_env

# Input files
inlist=`echo "$1"`
outdirlist=`echo "$2"`
outprelist=`echo "$3"`

# Get intput files according to task ID
infile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$inlist")
outdir=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$outdirlist")
outpre=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$outprelist")

# Assemble contigs
megahit --12 $infile -o data/assembly/1_assembly --out-prefix 1_assembly --presets meta-large -t 32

# Deactivate
conda deactivate

echo 'Done.'
