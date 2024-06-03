#!/bin/bash
#SBATCH --job-name=sep_reads_mapping_ref
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=10gb
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=mandyh@email.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load BBMap/39.01-GCC-11.3.0
module load Java/11.0.16
module load SAMtools/1.10-GCC-8.3.0

cd /scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024

mkdir sep_read_alignment_ref

#define directory
ref='/scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/ref_genome_setup/ref_genomes'
input='/scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/species_specific_reads_fastq'
output='/scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/sep_read_alignment_ref'

### Get the strain used for x from the "All_strain_names.txt" file created by lineage_file_stepup.class
### add unmapped to end

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
echo $i_$x
bbmap.sh in1=$input/$i\_$x\_R1.fastq in2=$input/$i\_$x\_R2.fastq out=$output/$i\_$x\.sam ref=$ref/C_parvum_C.fasta
samtools view -b $output/$i\_$x\.sam | samtools sort > $output/$i\_$x\_sorted.bam
done
done