#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=50G
#SBATCH --job-name=rqcfilt_%a
#SBATCH --output=rqcfilt_%a.out
#SBATCH -p batch 
#SBATCH -A bsd
#SBATCH --array=1-80

# name: filter_reads.sh
# author: William Argiroff
# inputs: .txt file listing interleaved fastq files in data/int/
#       data/reference/RQCFilterData/*
# output: filtered fastq files in data/qfiltered/

# Installation of BBTools
# module load anaconda3
# conda create --name bbtools_env
# conda activate bbtools_env
# conda install -c agbiome bbtools

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

source activate bbtools_env

# Get input file
inlist=`echo "$1"`
refdb=`echo "$2" | sed -E "s/(.*\/).*/\1/"`
infile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" "$inlist")

# Filter
rqcfilter2 jni=t in=$infile path=data/qfiltered/rqfilterout.$infile/ rqcfilterdata=$refdb  rna=f trimfragadapter=t qtrim=r trimq=0 maxns=3 maq=3 minlen=51 mlf=0.33 phix=t removehuman=t removedog=t removecat=t removemouse=t khist=t removemicrobes=t sketch kapa=t clumpify=t usetmpdir=f tmpdir=../tmpdir.$infile.temp/ barcodefilter=f trimpolyg=5 usejni=f

conda deactivate

echo "Done."
