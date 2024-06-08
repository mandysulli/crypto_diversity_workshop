#!/bin/bash
#SBATCH --job-name=gatk_genotype_GVCFs
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10gb
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@uga.edu

#This script can take a ridiculously long time

#loading the software in the cluster​
module load GATK/4.4.0.0-GCCcore-11.3.0-Java-17
module load SAMtools/1.10-GCC-8.3.0

#set directory 
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

mkdir -p ./tmp

gatk --java-options "-Xmx10g" GenomicsDBImport \
	--genomicsdb-workspace-path my_database \
	--sample-name-map gvcfs-for-db-import.sample_map \
	--tmp-dir ./tmp \
	--batch-size 32 \
	-L /scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes/C_parvum_C.bed