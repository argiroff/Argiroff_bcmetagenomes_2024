#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=64G
#SBATCH --job-name=int_list
#SBATCH --output=int_list.out
#SBATCH -p batch 
#SBATCH -A bsd

# name: make_assembly_outdir_list.sh
# author: William Argiroff
# inputs: .txt file with list of quality filtered file names
# output: .txt file with list of output directories for the assemblies

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

# Get intput files according to task ID
infile=`echo "$1"`
outdir=`echo "$2"`

# Generate file lists
cp $infile $outdir
sed -i "s/qfilt/assembly/g" $outdir
sed -i "s/\_001.fastq.gz//g" $outdir

echo 'done'
