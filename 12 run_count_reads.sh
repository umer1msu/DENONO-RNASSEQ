#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=count_reads
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=200
#SBATCH --mem=800G
#SBATCH --time=12:00:00
#SBATCH --output=run_count_reads.out
#SBATCH --error=run_count_reads.err
#SBATCH --mail-user=your_email@msu.edu   # Replace with your actual email
#SBATCH --mail-type=ALL

# Activate your environment if needed
source ~/.bashrc
# No specific conda environment needed for basic Linux commands

# Define input directory and output file
INPUT_DIR=~/split_clean_reads
OUTPUT_FILE=~/read_counts_summary.txt

# Clear existing output file if exists
rm -f "$OUTPUT_FILE"

echo "Counting reads from all .fq files in $INPUT_DIR..." > "$OUTPUT_FILE"
echo "Sample_Name    Read_Count" >> "$OUTPUT_FILE"

# Loop through all fq files and count reads (4 lines = 1 read)
for fq in "$INPUT_DIR"/*.fq; do
    [ -e "$fq" ] || continue  # Skip if no files found
    count=$(wc -l < "$fq")
    reads=$((count / 4))
    sample=$(basename "$fq")
    echo -e "${sample}	${reads}" >> "$OUTPUT_FILE"
done

echo "✅ Read counting complete. Results saved in: $OUTPUT_FILE"
