#!/bin/bash
#SBATCH --job-name=coverage_samtools
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --mem=10gb
#SBATCH --time=4:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@uga.edu

#loading the software in the cluste
module load SAMtools/1.10-GCC-8.3.0

cd /scratch/mandyh/crypto_diversity_test_04.01.2024/sep_read_alignment_ref

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
C_three_large
C_twelve_large
"
i=1

for i in $SAMPLES
do
for x in {C_andersoni,C_baileyi,C_cuniculus,C_hominis,C_muris,C_parvum,C_tyzzeri,C_ubiquitum,C_viatorum,C_meleagridis,C_felis,C_canis,unmapped}
do
echo "$i\_$x"
samtools coverage $i\_$x\_sorted.bam
done
done