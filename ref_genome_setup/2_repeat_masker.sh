#!/bin/bash
#SBATCH --job-name=repeat_masker
#SBATCH --partition=highmem_p
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=12
#SBATCH --mem=5gb
#SBATCH --export=NONE
#SBATCH --time=4:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=mandyh@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load RepeatMasker/4.1.5-foss-2022a

cd /scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup

input='/scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes'

##When one genome at a time

set -ueo pipefail
SAMPLES="C_andersoni_2
C_baileyi
C_cuniculus
C_hominis_30976
C_hominis_UdeA
C_muris
C_parvum_C
C_parvum_NC
C_tyzzeri
C_ubiquitum
C_viatorium
GCA_001593445.1_CryMelUKMEL1-1.0_genomic
GCA_014529505.1_ASM1452950v1_genomic
GCA_027243985.1_ASM2724398v1_genomic
"
i=1

for i in $SAMPLES
do
echo $i
##Mask the repeats
RepeatMasker $input/$i\.fasta  -lib output_repeats_$i\.fas
done

##these commands are happening outside of the loop
cd /scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes

cat *.fasta.masked > 14_crypto_genomes.fasta.masked
mv 14_crypto_genomes.fasta.masked ..