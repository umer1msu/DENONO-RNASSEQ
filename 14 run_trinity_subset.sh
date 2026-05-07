#!/bin/bash
#SBATCH --account=priority-ryanthum
#SBATCH --job-name=trinity_full
#SBATCH --partition=priority
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=600G
#SBATCH --time=48:00:00
#SBATCH --output=trinity_full.out
#SBATCH --error=trinity_full.err
#SBATCH --mail-user=your_email@msu.edu
#SBATCH --mail-type=END,FAIL

echo "🧬 Trinity job started on $(hostname) at $(date)"
set -euo pipefail

# Load environment
source ~/.bashrc
conda activate trinity_env

# Run Trinity using cleaned and validated sample names
Trinity \
  --seqType fq \
  --left /home/v83g834/trinity_input/LP1.r1.fq,\
/home/v83g834/trinity_input/LP1A.r1.fq,\
/home/v83g834/trinity_input/MA1.r1.fq,\
/home/v83g834/trinity_input/MJA1.r1.fq,\
/home/v83g834/trinity_input/W41.r1.fq,\
/home/v83g834/trinity_input/WD1.r1.fq,\
/home/v83g834/trinity_input/MJB1.r1.fq \
  --right /home/v83g834/trinity_input/LP1.r2.fq,\
/home/v83g834/trinity_input/LP1A.r2.fq,\
/home/v83g834/trinity_input/MA1.r2.fq,\
/home/v83g834/trinity_input/MJA1.r2.fq,\
/home/v83g834/trinity_input/W41.r2.fq,\
/home/v83g834/trinity_input/WD1.r2.fq,\
/home/v83g834/trinity_input/MJB1.r2.fq \
  --CPU 64 \
  --max_memory 600G \
  --SS_lib_type RF \
  --output trinity_out_dir

echo "✅ Trinity job finished on $(hostname) at $(date)"