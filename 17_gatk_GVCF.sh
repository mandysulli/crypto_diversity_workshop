#!/bin/bash
#SBATCH --job-name=gatk_genotype_GVCFs_2
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=5gb
#SBATCH --time=48:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@uga.edu

#loading the software in the cluster​
module load GATK/4.4.0.0-GCCcore-11.3.0-Java-17

#set directory 
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

gatk --java-options "-Xmx20g" \
	GenotypeGVCFs \
	-R /scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes/C_parvum_C.fasta \
	-V gendb://my_database \
	-O ./ref_output.vcf.gz