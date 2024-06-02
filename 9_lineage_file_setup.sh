#!/bin/bash
#SBATCH --job-name=lineage_file_setup
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=6gb
#SBATCH --time=4:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

module load Java/13.0.2

##Will need to make lineage folder with your strain_key.txt and lineage_file_setup.class file inside of it

#Set directory to execute script
cd /scratch/mandyh/crypto_diversity_test_04.01.2024/lineage_files

java lineage_file_setup strain_key.txt