#!/bin/bash
#SBATCH --job-name=Kallisto_quant_psuedobam
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=10gb
#SBATCH --export=NONE
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=mandyh@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load kallisto/0.48.0-gompi-2022a
module load SAMtools/1.14-GCC-11.2.0

#Set directory
cd /scratch/mandyh/crypto_diversity_test_04.01.2024
mkdir Kallisto_outputs

#define directory
input='/scratch/mandyh/crypto_diversity_test_04.01.2024/paired_trim_reads'
output='/scratch/mandyh/crypto_diversity_test_04.01.2024/Kallisto_outputs'

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
kallisto quant -t 6 -b 100 --pseudobam -i sequences.kallisto_idx -o $output/$i $input/$i\_R1_pair_trim.fastq.gz $input/$i\_R2_pair_trim.fastq.gz
done