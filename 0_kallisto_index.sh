#!/bin/bash
#SBATCH --job-name=Kallisto_indexing
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=12
#SBATCH --mem=8gb
#SBATCH --export=NONE
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=email@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load kallisto/0.48.0-gompi-2022a

#Set directory
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

#define directory
input='/scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/ref_genome_setup'

kallisto index -i sequences.kallisto_idx $input/14_crypto_genomes_clean.fasta 