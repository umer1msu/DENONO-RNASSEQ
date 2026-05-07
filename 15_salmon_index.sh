#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=salmon_index_full_set
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=128G
#SBATCH --time=02:00:00
#SBATCH --output=salmon_index_full_set.out
#SBATCH --error=salmon_index_full_set.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=END,FAIL

echo "🚀 Salmon indexing started on $(hostname) at $(date)"
set -euo pipefail

# Load conda environment
source ~/.bashrc
conda activate salmon_env

# Define paths to correct final files
TRANSCRIPTOME="/home/v83g834/Trinity_full_set.Trinity.fasta"
INDEX_DIR="/home/v83g834/Trinity_full_set/salmon_index_full_set"

# Ensure the output directory exists
mkdir -p "$INDEX_DIR"

# Run Salmon index with high resources
salmon index -t "$TRANSCRIPTOME" -i "$INDEX_DIR" -p 128

echo "✅ Salmon indexing completed at $(date)"
