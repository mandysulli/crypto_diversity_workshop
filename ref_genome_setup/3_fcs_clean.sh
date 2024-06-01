#!/bin/bash
#SBATCH --job-name=fcs-clean
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=4gb
#SBATCH --time=4:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

module load ncbi-FCS/0.5.0-GCCcore-11.3.0

#Set directory to execute script
cd /scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/ref_genome_setup

cat ./outputdir/cleaned_sequences/14_crypto_genomes_no_mask.fasta | python $EBROOTNCBIMINFCS/fcs.py clean genome --action-report ./gx_out/14_crypto_genomes_no_mask.5806.fcs_gx_report.txt --output 14_crypto_genomes_clean.fasta --contam-fasta-out 14_crypto_genomes_contam.fasta