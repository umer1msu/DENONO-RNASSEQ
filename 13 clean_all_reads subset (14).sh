#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=clean_reads
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=clean_reads.out
#SBATCH --error=clean_reads.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=END,FAIL

# Create output directory
mkdir -p ~/trinity_input

# Sample list
SAMPLES=("LP1" "LP1A" "MA1" "MJA1" "W41" "WD1" "MJB1")

# Loop through samples and clean headers
for SAMPLE in "${SAMPLES[@]}"; do
    echo "Cleaning $SAMPLE.r1.fq and $SAMPLE.r2.fq..."

    # Clean r1 reads
    sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/${SAMPLE}.r1.fq > ~/trinity_input/${SAMPLE}.r1.fq

    # Clean r2 reads
    sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/${SAMPLE}.r2.fq > ~/trinity_input/${SAMPLE}.r2.fq
done

echo "✅ All files cleaned and moved to ~/trinity_input"
