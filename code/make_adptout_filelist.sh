#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=64G
#SBATCH --job-name=adpt_list
#SBATCH --output=adpt_list.out
#SBATCH -p batch 
#SBATCH -A bsd

# name: make_intout_filelist.sh
# author: William Argiroff
# inputs: txt file with list of interleaved fastq names
# output: .txt file with list of adapter filtered fastq names

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

# Get intput files according to task ID
infileR1=`echo "$1"`
outfile=`echo "$2"`

# Generate file lists
cp $infileR1 $outfile
sed -i "s/int/adpt/g" $outfile # syntax for CADES

echo 'done'
