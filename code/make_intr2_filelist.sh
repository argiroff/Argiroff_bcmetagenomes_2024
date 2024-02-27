#!/bin/bash

# SBATCH --nodes=1
# SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
# SBATCH --time=20:00:00
# SBATCH --mem-per-cpu=64G
# SBATCH --job-name=int_list
# SBATCH --output=int_list.out
# SBATCH -p batch 
# SBATCH -A bsd

# name: make_intr2_filelist.sh
# author: William Argiroff
# inputs: name of file listing R2 fastq in raw/
# output: .txt file listing R2 fastq names

#cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

# Get intput files according to task ID
infileR2=`echo "$1"`

# Generate file lists
ls data/raw/*_R2_001.fastq.gz > $infileR2

echo 'done'
