#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=clean_all_reads
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=400G
#SBATCH --time=08:00:00
#SBATCH --output=clean_all_reads.out
#SBATCH --error=clean_all_reads.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=END,FAIL

mkdir -p ~/trinity_input_all

echo "🚀 Starting cleaning for all 34 samples..."

sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP1A.r1.fq > ~/trinity_input_all/LP1A.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP1A.r2.fq > ~/trinity_input_all/LP1A.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP1.r1.fq > ~/trinity_input_all/LP1.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP1.r2.fq > ~/trinity_input_all/LP1.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP2A.r1.fq > ~/trinity_input_all/LP2A.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP2A.r2.fq > ~/trinity_input_all/LP2A.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP2.r1.fq > ~/trinity_input_all/LP2.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP2.r2.fq > ~/trinity_input_all/LP2.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP3A.r1.fq > ~/trinity_input_all/LP3A.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP3A.r2.fq > ~/trinity_input_all/LP3A.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP3.r1.fq > ~/trinity_input_all/LP3.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP3.r2.fq > ~/trinity_input_all/LP3.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP4A.r1.fq > ~/trinity_input_all/LP4A.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP4A.r2.fq > ~/trinity_input_all/LP4A.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP4.r1.fq > ~/trinity_input_all/LP4.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP4.r2.fq > ~/trinity_input_all/LP4.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP5A.r1.fq > ~/trinity_input_all/LP5A.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP5A.r2.fq > ~/trinity_input_all/LP5A.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP5.r1.fq > ~/trinity_input_all/LP5.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/LP5.r2.fq > ~/trinity_input_all/LP5.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA1.r1.fq > ~/trinity_input_all/MA1.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA1.r2.fq > ~/trinity_input_all/MA1.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA2.r1.fq > ~/trinity_input_all/MA2.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA2.r2.fq > ~/trinity_input_all/MA2.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA3.r1.fq > ~/trinity_input_all/MA3.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA3.r2.fq > ~/trinity_input_all/MA3.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA4.r1.fq > ~/trinity_input_all/MA4.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA4.r2.fq > ~/trinity_input_all/MA4.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA5.r1.fq > ~/trinity_input_all/MA5.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MA5.r2.fq > ~/trinity_input_all/MA5.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJ3.r1.fq > ~/trinity_input_all/MJ3.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJ3.r2.fq > ~/trinity_input_all/MJ3.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJ4.r1.fq > ~/trinity_input_all/MJ4.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJ4.r2.fq > ~/trinity_input_all/MJ4.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJ5.r1.fq > ~/trinity_input_all/MJ5.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJ5.r2.fq > ~/trinity_input_all/MJ5.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA1.r1.fq > ~/trinity_input_all/MJA1.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA1.r2.fq > ~/trinity_input_all/MJA1.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA2.r1.fq > ~/trinity_input_all/MJA2.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA2.r2.fq > ~/trinity_input_all/MJA2.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA3.r1.fq > ~/trinity_input_all/MJA3.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA3.r2.fq > ~/trinity_input_all/MJA3.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA4.r1.fq > ~/trinity_input_all/MJA4.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJA4.r2.fq > ~/trinity_input_all/MJA4.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJB1.r1.fq > ~/trinity_input_all/MJB1.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJB1.r2.fq > ~/trinity_input_all/MJB1.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJB2.r1.fq > ~/trinity_input_all/MJB2.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/MJB2.r2.fq > ~/trinity_input_all/MJB2.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W41.r1.fq > ~/trinity_input_all/W41.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W41.r2.fq > ~/trinity_input_all/W41.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W42.r1.fq > ~/trinity_input_all/W42.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W42.r2.fq > ~/trinity_input_all/W42.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W43.r1.fq > ~/trinity_input_all/W43.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W43.r2.fq > ~/trinity_input_all/W43.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W44.r1.fq > ~/trinity_input_all/W44.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W44.r2.fq > ~/trinity_input_all/W44.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W45.r1.fq > ~/trinity_input_all/W45.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/W45.r2.fq > ~/trinity_input_all/W45.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD1.r1.fq > ~/trinity_input_all/WD1.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD1.r2.fq > ~/trinity_input_all/WD1.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD2.r1.fq > ~/trinity_input_all/WD2.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD2.r2.fq > ~/trinity_input_all/WD2.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD3.r1.fq > ~/trinity_input_all/WD3.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD3.r2.fq > ~/trinity_input_all/WD3.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD4.r1.fq > ~/trinity_input_all/WD4.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD4.r2.fq > ~/trinity_input_all/WD4.r2.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD5.r1.fq > ~/trinity_input_all/WD5.r1.fq
sed -E 's/\/[12]$//' /home/v83g834/split_clean_reads/WD5.r2.fq > ~/trinity_input_all/WD5.r2.fq

echo "✅ Finished cleaning all reads."
