#!/bin/bash
#SBATCH --job-name=convert_to_bed
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --mem=10gb
#SBATCH --time=1:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=email@uga.edu

module load BEDOPS/2.4.41-foss-2021b
module load BEDTools/2.30.0-GCC-12.2.0

#set directory
cd /scratch/mandyh/crypto_diversity_test_04.01.2024/ref_genome_setup/ref_genomes

##Convert to bed
convert2bed --input=GFF <C_parvum_C.gff > C_parvum_C.bed