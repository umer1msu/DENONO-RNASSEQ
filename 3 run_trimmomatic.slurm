#!/bin/bash

#SBATCH --account=priority-ryanthum
#SBATCH --job-name=Trimmomatic_analysis
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=250  # Max CPUs to use
#SBATCH --mem=800G           # Max memory to request
#SBATCH --time=24:00:00
#SBATCH --output=trimmomatic_output.out
#SBATCH --error=trimmomatic_error.err
#SBATCH --mail-user=your_email@msu.edu  # Replace with your MSU email
#SBATCH --mail-type=ALL

# Load necessary modules
module load java

# Define input and output directories
INPUT_DIR="/home/v83g834/sortmerna_filtered_reads"
OUTPUT_DIR="/home/v83g834/trimmomatic_output"
ADAPTERS="/home/v83g834/trimmomatic_output/TruSeq3-PE-2.fa"
TRIMMOMATIC_JAR="/home/v83g834/.conda/envs/trimmomatic_env/share/trimmomatic-0.39.jar"

# Ensure the adapters file has the correct permissions
chmod 777 $ADAPTERS

# Run Trimmomatic for all paired-end reads in the directory
for sample in $(ls $INPUT_DIR/*_R1_filtered.fq | sed 's/_R1_filtered.fq//'); do
    R1="${sample}_R1_filtered.fq"
    R2="${sample}_R2_filtered.fq"
    OUT_P1="${OUTPUT_DIR}/$(basename $sample)_R1_paired.fq"
    OUT_U1="${OUTPUT_DIR}/$(basename $sample)_R1_unpaired.fq"
    OUT_P2="${OUTPUT_DIR}/$(basename $sample)_R2_paired.fq"
    OUT_U2="${OUTPUT_DIR}/$(basename $sample)_R2_unpaired.fq"

    java -jar $TRIMMOMATIC_JAR PE -phred33 $R1 $R2         $OUT_P1 $OUT_U1         $OUT_P2 $OUT_U2         ILLUMINACLIP:$ADAPTERS:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done

echo "Trimmomatic processing completed."
