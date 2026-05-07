#!/bin/bash

#SBATCH --account=priority-ryanthum

#SBATCH --job-name=FastQC_analysis

#SBATCH --partition=priority

#SBATCH --nodes=1

#SBATCH --ntasks-per-node=1

#SBATCH --cpus-per-task=250         # Max CPUs to use

#SBATCH --mem=800G                  # Max memory to request

#SBATCH --time=24:00:00

#SBATCH --output=fastqc_output.out

#SBATCH --error=fastqc_error.err

#SBATCH --mail-user=your_email@msu.edu   # <- Replace with your MSU email

#SBATCH --mail-type=ALL



# Load Conda and activate your FastQC environment

source ~/.bashrc

conda activate fastqc_env



# Define data locations

DATADIR="/home/v83g834/RNA_read_all"

OUTDIR="$DATADIR/FastQC_results"



# Create output directory if it doesn't exist

mkdir -p $OUTDIR



# Detect available resources

AVAILABLE_CPUS=$(grep -c ^processor /proc/cpuinfo)

AVAILABLE_MEM=$(free -g | awk '/Mem:/ {print $2}')



# Use the lesser of requested or available resources

if [[ $AVAILABLE_CPUS -lt 250 ]]; then

    CPUS_TO_USE=$AVAILABLE_CPUS

else

    CPUS_TO_USE=250

fi



if [[ $AVAILABLE_MEM -lt 800 ]]; then

    MEM_TO_USE="${AVAILABLE_MEM}G"

else

    MEM_TO_USE="800G"

fi



echo "Using $CPUS_TO_USE CPUs and $MEM_TO_USE memory for FastQC"

echo "Processing files in: $DATADIR"



# Run FastQC on all .fq files

fastqc -t $CPUS_TO_USE $DATADIR/*.fq --outdir=$OUTDIR



echo "FastQC analysis completed."
