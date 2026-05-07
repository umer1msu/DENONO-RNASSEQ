#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=trinity_full
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=800G
#SBATCH --time=72:00:00
#SBATCH --output=trinity_full.out
#SBATCH --error=trinity_full.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=END,FAIL

echo "🧬 Trinity job started on $(hostname) at $(date)"
set -euo pipefail

# Load environment
source ~/.bashrc
conda activate trinity_env

# Run Trinity with cleaned full dataset
Trinity --seqType fq \
--left /home/v83g834/trinity_input_all/LP1.r1.fq,\
/home/v83g834/trinity_input_all/LP1A.r1.fq,\
/home/v83g834/trinity_input_all/LP2.r1.fq,\
/home/v83g834/trinity_input_all/LP2A.r1.fq,\
/home/v83g834/trinity_input_all/LP3.r1.fq,\
/home/v83g834/trinity_input_all/LP3A.r1.fq,\
/home/v83g834/trinity_input_all/LP4.r1.fq,\
/home/v83g834/trinity_input_all/LP4A.r1.fq,\
/home/v83g834/trinity_input_all/LP5.r1.fq,\
/home/v83g834/trinity_input_all/LP5A.r1.fq,\
/home/v83g834/trinity_input_all/MA1.r1.fq,\
/home/v83g834/trinity_input_all/MA2.r1.fq,\
/home/v83g834/trinity_input_all/MA3.r1.fq,\
/home/v83g834/trinity_input_all/MA4.r1.fq,\
/home/v83g834/trinity_input_all/MA5.r1.fq,\
/home/v83g834/trinity_input_all/MJ3.r1.fq,\
/home/v83g834/trinity_input_all/MJ4.r1.fq,\
/home/v83g834/trinity_input_all/MJ5.r1.fq,\
/home/v83g834/trinity_input_all/MJA1.r1.fq,\
/home/v83g834/trinity_input_all/MJA2.r1.fq,\
/home/v83g834/trinity_input_all/MJA3.r1.fq,\
/home/v83g834/trinity_input_all/MJA4.r1.fq,\
/home/v83g834/trinity_input_all/MJB1.r1.fq,\
/home/v83g834/trinity_input_all/MJB2.r1.fq,\
/home/v83g834/trinity_input_all/W41.r1.fq,\
/home/v83g834/trinity_input_all/W42.r1.fq,\
/home/v83g834/trinity_input_all/W43.r1.fq,\
/home/v83g834/trinity_input_all/W44.r1.fq,\
/home/v83g834/trinity_input_all/W45.r1.fq,\
/home/v83g834/trinity_input_all/WD1.r1.fq,\
/home/v83g834/trinity_input_all/WD2.r1.fq,\
/home/v83g834/trinity_input_all/WD3.r1.fq,\
/home/v83g834/trinity_input_all/WD4.r1.fq,\
/home/v83g834/trinity_input_all/WD5.r1.fq \
--right /home/v83g834/trinity_input_all/LP1.r2.fq,\
/home/v83g834/trinity_input_all/LP1A.r2.fq,\
/home/v83g834/trinity_input_all/LP2.r2.fq,\
/home/v83g834/trinity_input_all/LP2A.r2.fq,\
/home/v83g834/trinity_input_all/LP3.r2.fq,\
/home/v83g834/trinity_input_all/LP3A.r2.fq,\
/home/v83g834/trinity_input_all/LP4.r2.fq,\
/home/v83g834/trinity_input_all/LP4A.r2.fq,\
/home/v83g834/trinity_input_all/LP5.r2.fq,\
/home/v83g834/trinity_input_all/LP5A.r2.fq,\
/home/v83g834/trinity_input_all/MA1.r2.fq,\
/home/v83g834/trinity_input_all/MA2.r2.fq,\
/home/v83g834/trinity_input_all/MA3.r2.fq,\
/home/v83g834/trinity_input_all/MA4.r2.fq,\
/home/v83g834/trinity_input_all/MA5.r2.fq,\
/home/v83g834/trinity_input_all/MJ3.r2.fq,\
/home/v83g834/trinity_input_all/MJ4.r2.fq,\
/home/v83g834/trinity_input_all/MJ5.r2.fq,\
/home/v83g834/trinity_input_all/MJA1.r2.fq,\
/home/v83g834/trinity_input_all/MJA2.r2.fq,\
/home/v83g834/trinity_input_all/MJA3.r2.fq,\
/home/v83g834/trinity_input_all/MJA4.r2.fq,\
/home/v83g834/trinity_input_all/MJB1.r2.fq,\
/home/v83g834/trinity_input_all/MJB2.r2.fq,\
/home/v83g834/trinity_input_all/W41.r2.fq,\
/home/v83g834/trinity_input_all/W42.r2.fq,\
/home/v83g834/trinity_input_all/W43.r2.fq,\
/home/v83g834/trinity_input_all/W44.r2.fq,\
/home/v83g834/trinity_input_all/W45.r2.fq,\
/home/v83g834/trinity_input_all/WD1.r2.fq,\
/home/v83g834/trinity_input_all/WD2.r2.fq,\
/home/v83g834/trinity_input_all/WD3.r2.fq,\
/home/v83g834/trinity_input_all/WD4.r2.fq,\
/home/v83g834/trinity_input_all/WD5.r2.fq \
--SS_lib_type RF \
--max_memory 800G \
--CPU 128 \
--output Trinity_full_set