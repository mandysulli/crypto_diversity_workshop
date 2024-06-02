#!/bin/bash
#SBATCH --job-name=Kallisto_psuedobam_read_separation
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=10gb
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=email@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL

##This can take a fair amount of memory and time

module load SAMtools/1.14-GCC-11.2.0

#Set directory
cd /scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024

##Create directories
mkdir species_specific_reads_alignments
mkdir species_specific_reads_fastq

#define directory
input='/scratch/mandyh/crypto_diversity_test_04.01.2024/Kallisto_outputs_no_mask/Kallisto_diversity_no_mask_test_pseudobam'
output='/scratch/mandyh/crypto_diversity_test_04.01.2024/species_specific_reads_alignments'
output2='/scratch/mandyh/crypto_diversity_test_04.01.2024/species_specific_reads_fastq'
lineage='/scratch/mandyh/crypto_diversity_test_04.01.2024/lineage_files'

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
echo $i
##converting to pseudobam to sam to work with
## all reads still together here
samtools sort $input/$i\_pseudoalignments.bam > $input/$i\_pseudoalignments_sorted.bam
samtools index $input/$i\_pseudoalignments_sorted.bam
samtools view -h $input/$i\_pseudoalignments_sorted.bam > $input/$i\_pseudoalignments.sam
grep "@" $input/$i\_pseudoalignments.sam > $output/sam_headers_$i\.txt

### only grab mapped reads where both R1 and R2 map - need paired for spades to work
cat $input/$i\_pseudoalignments.sam | grep -v "^@" | awk 'BEGIN{FS="\t";OFS="\t"}{if($2=='83'||$2=='99'||$2=='147'||$2=='163') print $0}' > $output/incomplete_$i\_mapped_reads.sam
### grab unmapped reads
cat $input/$i\_pseudoalignments.sam | grep -v "^@" | awk 'BEGIN{FS="\t";OFS="\t"}{if($2=='77'||$2=='141') print $0}' > $output/incomplete_$i\_unmapped_reads.sam
cat $output/sam_headers_$i\.txt $output/incomplete_$i\_unmapped_reads.sam > $output/$i\_unmapped_reads.sam
samtools view -S -b $output/$i\_unmapped_reads.sam > $output/$i\_unmapped_reads.bam
samtools fastq $output/$i\_unmapped_reads.bam -1 $output2/$i\_unmapped_R1.fastq -2 $output2/$i\_unmapped_R2.fastq

### Pulling out lineage from mapped reads by sample
### Get the strains used for x from the "All_strain_names.txt" file created by lineage_file_stepup.class
for x in {C_andersoni,C_baileyi,C_cuniculus,C_hominis,C_muris,C_parvum,C_tyzzeri,C_ubiquitum,C_viatorum,C_meleagridis,C_felis,C_canis}
do
grep -f $lineage/$x\.txt $output/incomplete_$i\_mapped_reads.sam > $output/incomplete_$i\_$x\_reads.sam
cat $output/sam_headers_$i\.txt $output/incomplete_$i\_$x\_reads.sam > $output/$i\_$x\_reads.sam
samtools view -S -b $output/$i\_$x\_reads.sam > $output/$i\_$x\_reads.bam
echo "$x"
samtools fastq $output/$i\_$x\_reads.bam -1 $output2/$i\_$x\_R1.fastq -2 $output2/$i\_$x\_R2.fastq
done
done