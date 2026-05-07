#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=sort_reads
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=12:00:00
#SBATCH --output=sort_reads_output.out
#SBATCH --error=sort_reads_error.err
#SBATCH --mail-user=your_email@msu.edu  # Replace with your MSU email
#SBATCH --mail-type=ALL

# Activate conda environment
source ~/.bashrc
conda activate samtools_env

# Define paths
INDIR=~/cleanedfromhost_paired_unmapped_output
OUTDIR=~/sorted_paired_unmapped_output
mkdir -p $OUTDIR

echo "Running sorting of BAM files by read name..."

for bamfile in $INDIR/*_paired_unmapped.bam; do
    base=$(basename "$bamfile" _paired_unmapped.bam)
    echo "Processing $base..."
    samtools sort -@ 200 -n "$bamfile" -o "$OUTDIR/${base}_paired_unmapped_sorted.bam"
done

echo "Sorting completed."
