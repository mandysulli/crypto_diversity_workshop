# crypto_diversity_workshop
 
 Mandy,Imtiaj and Courtney reworking StrainSort Pipeline for Cryptosporidium.
 
 Data, java programs and scripts saved here:
 /work/tcglab/Crypto_MHS/crypto_diversity_test_04.01.2024
 
 # Setup Reference genomes
We will use the whole genome, without masking the repeats.
 

 
 # Run StrainSort Curated
 
 ### First script - 0_kallisto_index.sh
 
 This script indexes our reference genomes to create a reference databse
 We used the reference genomes that were not masked in this case

 ### Second script - 1_count_raw.sh

This loops through the samples and counts the raw reads in the fastq files

 ### Third script - 2_reformat_raw_read_counts.sh

This reformats the reads so that they can be pasted into an excel sheet. You will want to use reformat_Read_Counts.class with Java version v13.0.2 if you can. This is the already compiled program.

Goes from this format:
sample_1
1,000
1,000
sample_2
1,000
1,000

to this format:
Sample	Read1 Counts	Read2 Counts
sample_1	1,000	1,000
sample_2	1,000	1,000

reformat_Read_Counts.java - is the non-compiled code. You can recompile this with any java version and then it will run with that Java version. Only recompile if you can not access Java v13.0.2 

 ### Fourth script - 3_trim.sh

This script trims off the Nextera adapters and quality filters the reads.

 ### Fifth script - 4_count_trim.sh

Script is set up the same as the script that counts the raw reads. 
We want to count the trimmed reads to be sure that we are not loosing a large number of reads in during trimming and quality filtering.

 ### Sixth script - 5_reformat_trim_read_count

This script reformats the reads from the previous script so that they are easily pasted into an excel sheet

 ### Seventh script - 6_kallisto_quant_pseudobam.sh

This script uses Kallisto to quantify the estimated number of reads per reference genome. This is how we will get our estimated abundance values.
It is also set up to give us a pseudobam file which is what we will use to separate the reads. 
Outputs files into folder by sample (which is really inconvenient) .

 ### Eight script - 7_kallisto_rename.sh

This script renames the output files to have there sample name included. This way we can move them together into one folder.

 ### Ninth script - 8_kallisto_move.sh

This is the script that moves them all together.

*After this script you can export the abundance.tsv files out pf the cluster and use them with the R script provided to make estimated abundance figures (See below).*

 ### Tenth script - 9_lineage_file_setup.sh

This script sets up the texts files that allow for species separation. 

You will need a strain_key.txt that has the headers of the reference sequences in the first column and the strain associated with that sequence in the second column. Other data can be present.

To execute this script:
make a directory that named lineage_files
move lineage_file_setup.class and the strain_key.txt into the folder
Then run the script.

The output should be text files with the species name form the second column as the files name. Each file will contain the the headers in the first column that are associated with that species.

Example:
file name - C_andersoni.txt
inside C_andersoni.txt:
lcl|C_andersoni-LRBS01000121.1
lcl|C_andersoni-LRBS01000027.1
lcl|C_andersoni-LRBS01000095.1
lcl|C_andersoni-LRBS01000131.1
lcl|C_andersoni-LRBS01000092.1
etc...

These will be used in next script. 

There should also be a All_strain_name.txt file that lists all the species that are present in the strain_key.txt. They will be in a line so that they can be used in the next script.

https://www.samformat.info/sam-format-flag

 ### Eleventh script - 10_kallisto_pseudobam_read_separation.sh
 
 This script separates the reads in the psuedobam files created by kallisto, using the species text files created in the previous step. 
 Use the list of species within the All_strain_name.txt in line 72 of this script. 
 
 ### Twelfth script - 

 # Run R script
To visualize the estimated abundance of your samples you will need:
- The R markdown script provided: Kallisto_crypto_diversity_viz.Rmd
- The folder with the abundance tsv files. 
- A species key - Kallisto_key.tsv

Create a folder and put all of the things listed above in it. Then open the Kallisto_crypto_diversity_viz.Rmd file and follow the instructions within it.

