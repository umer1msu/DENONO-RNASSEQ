#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=FastQC_paired
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=250
#SBATCH --mem=800G
#SBATCH --time=24:00:00
#SBATCH --output=fastqc_paired_output.out
#SBATCH --error=fastqc_paired_error.err
#SBATCH --mail-user=your_email@msu.edu    # Replace with your MSU email
#SBATCH --mail-type=ALL

# Load Conda and activate the environment
source ~/.bashrc
conda activate fastqc_env

# Define directories
INPUT_DIR=/home/v83g834/paired_reads
OUTPUT_DIR=/home/v83g834/fastqc_output_paired

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Run FastQC on all paired reads
fastqc -t 250 -o $OUTPUT_DIR $INPUT_DIR/*_paired.fq

echo "FastQC on paired reads complete."
