#!/bin/bash

## Lines starting with #SBATCH are read by Slurm.



#SBATCH --account=priority-ryanthum   # Account for job submission

#SBATCH --job-name=sortmerna_analysis # Job name

#SBATCH --partition=priority          # Use the priority partition

#SBATCH --nodes=1                     # Number of nodes

#SBATCH --ntasks-per-node=1           # One task per node

#SBATCH --cpus-per-task=80            # Number of CPUs to allocate

#SBATCH --mem=200G                    # Allocate 200GB memory

#SBATCH --time=96:00:00               # Maximum job run time (96 hours)

#SBATCH --output=sortmerna_output.out # Standard output log

#SBATCH --error=sortmerna_error.err   # Error log

#SBATCH --mail-user=your_email@msu.edu  # Set your email for job notifications

#SBATCH --mail-type=ALL               # Receive email on job begin, end, fail



# Load the required modules if necessary (only if using modules)

# module load conda



# Activate Conda environment

source ~/.bashrc

conda activate sortmerna_env



# Define paths

DATABASE_PATH=~/sortmerna_db/smr_v4.3_default_db.fasta

READS_DIR=~/RNA_read_all

BASE_OUTPUT_DIR=~/sortmerna_output



# Ensure output directory exists

mkdir -p $BASE_OUTPUT_DIR



# Loop through all FASTQ files in the directory

for file in $READS_DIR/*.fq; do

    base_name=$(basename "$file" .fq)  # Extract filename without extension

    WORKDIR="$BASE_OUTPUT_DIR/$base_name"

    mkdir -p $WORKDIR  # Create a unique directory for each file



    echo "Processing: $file"

    echo "Working Directory: $WORKDIR"



    sortmerna --ref $DATABASE_PATH \

              --reads $file \

              --aligned $WORKDIR/${base_name}_rRNA.fq \

              --other $WORKDIR/${base_name}_non_rRNA.fq \

              --workdir $WORKDIR \

              --fastx --threads 80



    echo "Completed: $file"

done



echo "SortMeRNA job completed for all files!"
