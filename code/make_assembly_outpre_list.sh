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

# name: make_assembly_outpre_list.sh
# author: William Argiroff
# inputs: .txt file with list of output directories for the assemblies
# output: .txt file with list of file prefixes for the assemblies

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

# Get intput files according to task ID
infile=`echo "$1"`
outpre=`echo "$2"`

# Generate file lists
cp $infile $outpre
sed -i "s/data\/assembly\///g" $outpre

echo 'done'
