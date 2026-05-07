#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=salmon_quant
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=600G
#SBATCH --time=24:00:00
#SBATCH --output=salmon_quant.out
#SBATCH --error=salmon_quant.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=END,FAIL

echo "🚀 Salmon quantification started on $(hostname) at $(date)"
set -euo pipefail

# Load conda and activate salmon environment
source ~/.bashrc
conda activate salmon_env

# Paths (updated)
INDEX_DIR="/home/v83g834/Trinity_full_set/salmon_index_full_set"
INPUT_DIR="/home/v83g834/trinity_input_all"
OUTPUT_BASE="/home/v83g834/salmon_quants_v2"

# Create output base directory
mkdir -p "$OUTPUT_BASE"

# List of sample names
samples=(
  LP1 LP1A LP2 LP2A LP3 LP3A LP4 LP4A LP5 LP5A
  MA1 MA2 MA3 MA4 MA5
  MJ3 MJ4 MJ5
  MJA1 MJA2 MJA3 MJA4
  MJB1 MJB2
  W41 W42 W43 W44 W45
  WD1 WD2 WD3 WD4 WD5
)

# Run Salmon quantification for each sample
for sample in "${samples[@]}"; do
  echo "🔬 Processing $sample"
  salmon quant -i "$INDEX_DIR" \
    -l A \
    -1 "$INPUT_DIR/${sample}.r1.fq" \
    -2 "$INPUT_DIR/${sample}.r2.fq" \
    -p 32 \
    --validateMappings \
    -o "$OUTPUT_BASE/${sample}_quant"
done

echo "✅ All samples processed with Salmon at $(date)"
