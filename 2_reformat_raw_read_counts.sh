#!/bin/bash
#SBATCH --job-name=reformat_raw_read_counts
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
#Using this version because it is the one that the program was compiled with - have to use the version that you compiled with

#set directory 
cd /scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024

java reformat_Read_Counts count_raw_27583715.out raw_read_counts_reformat.txt

#example
#java reformat_Read_Counts input.out output.txt