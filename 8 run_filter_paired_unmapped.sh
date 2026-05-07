#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=filter_reads
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=12:00:00
#SBATCH --output=filter_reads_output.out
#SBATCH --error=filter_reads_error.err
#SBATCH --mail-user=your_email@msu.edu   # Replace with your MSU email
#SBATCH --mail-type=ALL

# Activate conda environment
source ~/.bashrc
conda activate samtools_env

# Define paths
INDIR=~/bam_output
OUTDIR=~/cleanedfromhost_paired_unmapped_output
mkdir -p $OUTDIR

echo "Running extraction of paired unmapped reads..."

for bamfile in $INDIR/*_mapped_and_unmapped.bam; do
    base=$(basename "$bamfile" _mapped_and_unmapped.bam)
    echo "Processing $base..."
    samtools view -@ 200 -b -f 12 "$bamfile" > "$OUTDIR/${base}_paired_unmapped.bam"
done

echo "Filtering completed."
