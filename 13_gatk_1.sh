#!/bin/bash
#SBATCH --job-name=gatk_step_1
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20gb
#SBATCH --export=NONE
#SBATCH --time=96:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=email@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

#loading the software in the cluster<200b>
module load GATK/4.4.0.0-GCCcore-11.3.0-Java-17

#set directory
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

mkdir gatk_output
mkdir ./gatk_output/minlen60

#define directory
bam_file='/scratch/mandyh/crypto_diversity_test_04.01.2024/sep_read_alignment_ref'
output='/scratch/mandyh/crypto_diversity_test_04.01.2024/gatk_output/minlen60'
ref='/scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes'

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
gatk --java-options "-Xmx20g"  AddOrReplaceReadGroups --INPUT $bam_file/$i\_sorted.bam --OUTPUT $bam_file/$i\_sorted.rg.bam --RGLB lib1 --RGPL illumina --RGPU unit1 --RGSM 20
gatk --java-options "-Xmx20g" MarkDuplicatesSpark --spark-runner LOCAL --input $bam_file/$i\_sorted.rg.bam --output $output/$i\.md.bam --conf 'spark.executor.cores=4'
gatk --java-options "-Xmx20g" SetNmMdAndUqTags --INPUT $output/$i\.md.bam --OUTPUT $output/$i\.md.fx.bam --REFERENCE_SEQUENCE $ref/C_parvum_C.fasta
gatk --java-options "-Xmx20g" BuildBamIndex --INPUT $output/$i\.md.fx.bam
done

# run duplicate marking using Spark (in local mode) and setting the cores appropriately<200b>
# we are assuming the number of threads here will be 12