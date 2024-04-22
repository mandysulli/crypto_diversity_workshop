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

This script reformats the reads from the previous script so that they are easily pasted into an excel sheet

Seventh script - 6_kallisto_quant_pseudobam.sh

This script uses Kallisto to quantify the estimated number of reads per reference genome. This is how we will get our estimated abundance values.
It is also set up to give us a pseudobam file which is what we will use to separate the reads. 
Outputs files into folder by sample (which is really inconvenient) .

Eight script - 7_kallisto_rename.sh

This script renames the output files to have there sample name included. This way we can move them together into one folder.

Ninth script - 8_kallisto_move.sh

This is the script that moves them all together.
After this script you can export the abundance.tsv files out pf the cluster and use them with the R script provided to make estimated abundance figures (See below).





## Run R script
To visualize the estimated abundance of your samples you will need:
- The R markdown script provided: Kallisto_crypto_diversity_viz.Rmd
- The folder with the abundance tsv files. 
- A species key

Create a folder and put all of the things listed above in it. Then open the Kallisto_crypto_diversity_viz.Rmd file and follow the instructions within it.

