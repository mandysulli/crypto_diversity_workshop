#!/bin/bash
#SBATCH --job-name=fcs-adapter
#SBATCH --partition=iob_p
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5gb
#SBATCH --time=4:00:00
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mandyh@uga.edu

module load ncbi-FCS/0.5.0-GCCcore-11.3.0

#Set directory to execute script
cd /scratch/mandyh/Crypto/crypto_diveristy_analysis_march2024/ref_genome_setup

mkdir outputdir
run_fcsadaptor.sh --fasta-input 14_crypto_genomes_no_mask.fasta --output-dir ./outputdir --euk --container-engine singularity --image $EBROOTNCBIMINFCS/fcs-adaptor.sif