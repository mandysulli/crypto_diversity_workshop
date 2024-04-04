# crypto_diversity_workshop
 
 Mandy,Imtiaj and Courtney reworking StrainSort Pipeline for Cryptosporidium.
 
 Data, java programs and scripts saved here:
 /work/tcglab/Crypto_MHS/crypto_diversity_test_04.01.2024
 
 # Setup Reference genomes
 Starting with masking the repeat regions in the reference genomes.
 
 First script - 1_repeat_scout.sh
 
 This script is looping through all of our reference genomes and finding the repeats for each genome
 
 Second script - 2_repeat_masker.sh
 
 This script uses the repeats found in the previous step and masks the given genome using those repeats.
 It "masks" the repeats by converting the ACGT's to N
 
 # Run StrainSort Curated
 
First script - 0_kallisto_index.sh
 
 This script indexes our reference genomes to create a reference databse
 We used the reference genomes that were not masked in this case

Second script - 1_count_raw.sh

This loops through the samples and counts the raw reads in the fastq files

Third script - 2_reformat_raw_read_counts.sh

This reformats the reads so that they can be pasted into an excel sheet
Uses a java program that was compiled with Java v13.0.2

Fourth script - 3_trim.sh

This script trims off the Nextera adapters and quality filters the reads.

Fifth script - 4_count_trim.sh

Script is set up the same as the script that counts the raw reads. 
We want to count the trimmed reads to be sure that we are not loosing a large number of reads in during trimming and quality filtering.

Sixth script - 5_reformat_trim_read_count

Seventh script - 6_kallisto_quant_psuedobam.sh

Eight script - 7_kallisto_rename.sh

Nineth script - 8_kallisto_move.sh

