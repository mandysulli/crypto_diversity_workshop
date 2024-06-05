#!/bin/bash
#SBATCH --job-name=gatk_HaplotypeCaller
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=5gb
#SBATCH --export=NONE
#SBATCH --time=96:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=email@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

#loading the software in the cluster​
module load GATK/4.4.0.0-GCCcore-11.3.0-Java-17
module load SAMtools/1.10-GCC-8.3.0

#set directory 
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

mkdir ./gatk_output/minlen60/snpcalling

#define directory
ref='/scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes'
bam_file='/scratch/mandyh/crypto_diversity_test_04.01.2024/gatk_output/minlen60'
output='/scratch/mandyh/crypto_diversity_test_04.01.2024/gatk_output/minlen60/snpcalling'

##Index the ref
##had to rename
gatk --java-options "-Xmx20g" CreateSequenceDictionary -R $ref/C_parvum_C.fasta -O $ref/C_parvum_C.dict

SAMPLES="C_twelve_large_C_parvum
C_twelve_large_C_hominis
C_parvum_IOWA-ATCC_large_C_parvum
C_three_large_C_parvum
C_five_large_C_parvum
C_five_large_C_hominis
C_three_large_C_hominis
C_hominis_30976_large_C_hominis
2_UKRC_70_C_parvum
C_twelve_large_C_tyzzeri
C_five_large_C_tyzzeri
C_five_large_C_meleagridis
C_twelve_large_C_meleagridis
2_UKRC_32_C_parvum
C_twelve_large_C_viatorum
2_UKRC_31_C_parvum
2_UKRC_88_C_parvum
2_UKRC_5_C_parvum
C_three_large_C_cuniculus
C_five_large_C_cuniculus
C_twelve_large_C_cuniculus
2_UKRC_57_C_parvum
2_UKRC_55_C_hominis
2_UKRC_70_unmapped
C_twelve_large_unmapped
C_twelve_large_C_ubiquitum
2_UKRC_2_C_parvum
2_UKRC_25_C_parvum
C_five_large_unmapped
2_UKRC_27_C_parvum
2_UKRC_11_C_parvum
2_UKRC_31_unmapped
2_UKRC_32_unmapped
C_three_large_unmapped
2_UKRC_30_C_hominis
2_UKRC_5_unmapped
2_UKRC_57_unmapped
2_UKRC_2_unmapped
2_UKRC_88_unmapped
C_parvum_IOWA-ATCC_large_unmapped
C_hominis_30976_large_unmapped
2_UKRC_10_C_hominis
2_UKRC_25_unmapped
2_UKRC_27_unmapped
2_UKRC_55_unmapped
C_twelve_large_C_baileyi
2_UKRC_11_unmapped
2_UKRC_92_C_parvum
2_UKRC_30_unmapped
C_twelve_large_C_muris
C_twelve_large_C_andersoni
2_UKRC_88_C_tyzzeri
2_UKRC_70_C_tyzzeri
"
i=1

for i in $SAMPLES
do
echo $i
gatk --java-options "-Xmx20g" HaplotypeCaller -R $ref/C_parvum_C.fasta -I $bam_file/$i\.md.fx.bam -O $output/$i\.g.vcf.gz -ERC GVCF
done