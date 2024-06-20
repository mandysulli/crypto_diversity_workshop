#!/bin/bash
#SBATCH --job-name=VCF_filtering
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=5gb
#SBATCH --time=48:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

#loading the software in the cluster​
module load VCFtools/0.1.16-GCC-11.2.0

#set directory
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

vcftools --gzvcf ref_output.vcf.gz --minDP 30 --minQ 30 --minGQ 25 --max-alleles 2 --remove-indels --recode --out filtered_output
bgzip filtered_output.recode.vcf
tabix -p vcf filtered_output.recode.vcf.gz