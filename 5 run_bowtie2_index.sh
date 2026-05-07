#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=bowtie2_index
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=250
#SBATCH --mem=800G
#SBATCH --time=24:00:00
#SBATCH --output=bowtie2_index_output.out
#SBATCH --error=bowtie2_index_error.err
#SBATCH --mail-user=your_email@msu.edu  # Replace with your MSU email
#SBATCH --mail-type=ALL

# Load Conda and activate your bowtie2 environment
source ~/.bashrc
conda activate bowtie2_env

# Define paths
GENOME_DIR=/home/v83g834/alfalfa_genome
GENOME_FILE=$GENOME_DIR/medsa.CADL_HM342.gnm1.rVNY.genome_main.fna
INDEX_DIR=$GENOME_DIR/index_files

# Run Bowtie2 index build
bowtie2-build --threads 250 $GENOME_FILE $INDEX_DIR/alfalfa_index
