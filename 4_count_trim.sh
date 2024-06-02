#!/bin/bash
#SBATCH --job-name=count_trim
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --mem=2gb
#SBATCH --time=2:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@uga.edu

#set directory 
cd /scratch/mandyh/crypto_diversity_test_04.01.2024/paired_trim_reads

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
echo $(zcat $i\_R1_pair_trim.fastq.gz|wc -l)/4|bc
echo $(zcat $i\_R2_pair_trim.fastq.gz|wc -l)/4|bc
done