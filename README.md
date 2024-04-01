## crypto_diversity_workshop
 
 Mandy,Imtiaj and Courtney reworking StrainSort Pipeline for Cryptosporidium.
 
 Data, java programs and scripts saved here:
 /work/tcglab/Crypto_MHS/crypto_diversity_test_04.01.2024
 
 ## Setup Reference genomes
 Starting with masking the repeat regions in the reference genomes.
 
 First script - 1_repeat_scout.sh
 
 This script is looping through all of our reference genomes and finding the repeats for each genome
 
 Second script - 2_repeat_masker.sh
 
 This script uses the repeats found in the previous step and masks the given genome using those repeats.
 It "masks" the repeats by converting the ACGT's to N
 
 ## Run StrainSort Curated
 
#0_kallisto_index.sh
 
 This script indexes our reference genomes to create a reference databse
 We used the reference genomes that were not masked in this case


