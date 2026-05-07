#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=bowtie2_align
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=24:00:00
#SBATCH --output=bowtie2_align_output.out
#SBATCH --error=bowtie2_align_error.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=ALL

# Load Conda and activate bowtie2 environment
source ~/.bashrc
conda activate bowtie2_env

# Define input/output/index directories
READDIR="/home/v83g834/paired_reads"
OUTDIR="/home/v83g834/bowtie2_output"
INDEX="/home/v83g834/alfalfa_genome/index_files/alfalfa_index"

# Create output directory if not exists
mkdir -p $OUTDIR

# Align each R1/R2 pair
for R1 in ${READDIR}/*_R1_paired.fq
do
    # Extract sample prefix
    BASENAME=$(basename "$R1" _R1_paired.fq)
    R2="${READDIR}/${BASENAME}_R2_paired.fq"
    OUTSAM="${OUTDIR}/${BASENAME}_mapped_and_unmapped.sam"

    echo "Running Bowtie2 for $BASENAME"
    bowtie2 -x $INDEX -1 $R1 -2 $R2 -S $OUTSAM -p 200
done

echo "All alignments complete."
