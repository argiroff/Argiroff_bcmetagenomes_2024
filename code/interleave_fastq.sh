#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=50G
#SBATCH --job-name=int_%a
#SBATCH --output=int_%a.out
#SBATCH -p batch 
#SBATCH -A bsd
#SBATCH --array=1-80

# name: interleave_fastq.sh
# author: William Argiroff
# inputs: R1 fastq, R2 fastq
# output: interleaved fastq with R1 followed by R2

# Installation of SeqFu
# module load anaconda3
# conda create --name seqfu_env
# conda activate seqfu_env
# conda install -c conda-forge -c bioconda "seqfu>1.0"
# conda deactivate

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

source activate seqfu_env

# Get intput files according to task ID
infileR1=$(awk "NR==${SLURM_ARRAY_TASK_ID}" int_R1_infiles.txt)
infileR2=$(awk "NR==${SLURM_ARRAY_TASK_ID}" int_R2_infiles.txt)
outfile=$(awk "NR==${SLURM_ARRAY_TASK_ID}" int_outfiles.txt)

# Interleave files
seqfu ilv -1 $infileR1 -2 $infileR2 -c | gzip -c > $outfile

conda deactivate

echo 'done'