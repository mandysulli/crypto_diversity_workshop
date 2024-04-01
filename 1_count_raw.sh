#!/bin/bash
#SBATCH --job-name=count_raw
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=500mb
#SBATCH --time=2:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

#set directory 
cd /scratch/mandyh/crypto_diversity_test_04.01.2024/Raw_data

##loop through the samples and count the number of reads within each file
##zcat used for zipped files 

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
echo $(zcat $i\.1.fq.gz|wc -l)/4|bc
echo $(zcat $i\.2.fq.gz|wc -l)/4|bc
done