#!/bin/bash
#SBATCH --job-name=trim_filter
#SBATCH --partition=highmem_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=3gb
#SBATCH --time=48:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

module load Trimmomatic/0.39-Java-13

##Using Nextera adapters from trimming
##Simulated reads will not have adapters to trim

#Set directory
cd /scratch/mandyh/crypto_diversity_test_04.01.2024

## have to have both of these folder or program will fail
mkdir paired_trim_reads
mkdir unpaired_trim_reads

set -ueo pipefail
SAMPLES="2_UKRC_10
2_UKRC_11
2_UKRC_2
2_UKRC_25
2_UKRC_27
2_UKRC_30
2_UKRC_31
2_UKRC_32
2_UKRC_5
2_UKRC_55
2_UKRC_57
2_UKRC_70
2_UKRC_88
2_UKRC_92
C_five_large
C_hominis_30976_large
C_parvum_IOWA-ATCC_large
C_ten_large
C_three_large
C_twelve_large
"
i=1

for i in $SAMPLES
do
echo $i
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE ./Raw_data/$i\.1.fq.gz ./Raw_data/$i\.2.fq.gz ./paired_trim_reads/$i\_R1_pair_trim.fastq.gz ./unpaired_trim_reads/$i\_R1_unpair_trim.fastq.gz ./paired_trim_reads/$i\_R2_pair_trim.fastq.gz ./unpaired_trim_reads/$i\_R2_unpair_trim.fastq.gz -threads 10 -phred33 ILLUMINACLIP:/apps/eb/Trimmomatic/0.39-Java-1.8.0_144/adapters/NexteraPE-PE.fa:2:30:10:2:TRUE LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:100
done