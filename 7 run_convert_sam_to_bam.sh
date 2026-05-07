#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=sam_to_bam
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=12:00:00
#SBATCH --output=sam_to_bam_output.out
#SBATCH --error=sam_to_bam_error.err
#SBATCH --mail-user=your_email@msu.edu   # Replace with your MSU email
#SBATCH --mail-type=ALL

# Activate samtools environment
source ~/.bashrc
conda activate samtools_env

# Define directories
INDIR=~/bowtie2_output
OUTDIR=~/bam_output
mkdir -p $OUTDIR

echo "Converting SAM files to BAM..."
for samfile in $INDIR/*.sam
do
    base=$(basename "$samfile" .sam)
    echo "Processing $base.sam"
    samtools view -@ 200 -bS "$samfile" > "$OUTDIR/${base}.bam"
done

echo "SAM to BAM conversion completed."
