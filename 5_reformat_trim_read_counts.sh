#!/bin/bash
#SBATCH --job-name=reformat_trim_read_counts
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=100mb
#SBATCH --time=2:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

module load Java/13.0.2
#Using this version because it is the one that the program was compiled with

#set directory 
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

java reformat_Read_Counts count_trim_27600188.out trim_read_counts_reformat.txt