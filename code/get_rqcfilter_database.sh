#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=50G
#SBATCH --job-name=getRQCF
#SBATCH --output=getRCQF.out
#SBATCH -p batch 
#SBATCH -A bsd

# name: get_rcqfilter_database.sh
# author: William Argiroff
# inputs: URL
# output: unzipped RQCFilter database in data/references/RQCFilterData

cd /lustre/or-scratch/cades-bsd/7wa/Argiroff_bcmetagenomes_2024

# Download
wget --directory-prefix=data/reference/ --no-clobber https://portal.nersc.gov/dna/microbial/assembly/bushnell/RQCFilterData.tar

# Unzip in 
tar -xvzf data/reference/RQCFilterData.tar -C data/reference/

# Remove archive
rm data/reference/RQCFilterData.tar

echo "Done."
