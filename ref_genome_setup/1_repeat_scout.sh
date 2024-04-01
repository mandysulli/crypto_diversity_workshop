#!/bin/bash
#SBATCH --job-name=repeat_scout
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2gb
#SBATCH --export=NONE
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=mandyh@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load RepeatScout/1.0.6-GCC-11.3.0
module load Perl/5.34.1-GCCcore-11.3.0

cd /scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup

input='/scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/ref_genome_setup/ref_genomes'

##Can only use one genome at a time, so I used our best genome

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
## builds a freq table 0 can be larger
build_lmer_table -sequence $input/$i\.fasta -freq output_lmer_$i\.frequency

## make fasta file with all kinds of repeats 
RepeatScout -sequence $input/$i\.fasta -output output_repeats_$i\.fas  -freq output_lmer_$i\.frequency

done