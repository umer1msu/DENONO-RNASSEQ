#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=bam_to_fq
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=12:00:00
#SBATCH --output=bam_to_fq_output.out
#SBATCH --error=bam_to_fq_error.err
#SBATCH --mail-user=your_email@msu.edu  # Replace with your MSU email
#SBATCH --mail-type=ALL

# Activate conda environment
source ~/.bashrc
conda activate samtools_env

# Define directories
INDIR=~/sorted_paired_unmapped_output
OUTDIR=~/clean_reads
mkdir -p $OUTDIR

echo "Running BAM to FASTQ conversion..."

for sorted_bam in $INDIR/*_paired_unmapped_sorted.bam; do
    base=$(basename "$sorted_bam" _paired_unmapped_sorted.bam)
    echo "Processing $base..."
    samtools bam2fq "$sorted_bam" > "$OUTDIR/${base}_clean_paired.fq"
done

echo "Conversion completed."
