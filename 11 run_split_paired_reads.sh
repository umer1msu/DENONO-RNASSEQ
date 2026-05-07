#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=split_reads
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=12:00:00
#SBATCH --output=split_reads_output.out
#SBATCH --error=split_reads_error.err
#SBATCH --mail-user=your_email@msu.edu  # Replace this
#SBATCH --mail-type=ALL

# Activate environment with seqtk
source ~/.bashrc
conda activate seqtk_env

# Input/output directories
INPUT_DIR=~/clean_reads
OUTPUT_DIR=~/split_clean_reads

mkdir -p "$OUTPUT_DIR"

echo "Starting seqtk split for paired-end reads..."

# Loop through all clean_paired.fq files
for fq_file in "$INPUT_DIR"/*_clean_paired.fq; do
    base=$(basename "$fq_file" _clean_paired.fq)
    sample_out="$OUTPUT_DIR/${base}_split"
    mkdir -p "$sample_out"

    echo "Processing $base..."

    # Run seqtk to extract R1 and R2
    seqtk seq -1 "$fq_file" > "$sample_out/${base}.r1.fq"
    seqtk seq -2 "$fq_file" > "$sample_out/${base}.r2.fq"
done

echo "All files processed."
