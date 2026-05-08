## Introduction

RNA sequencing (RNA-seq) provides a genome-wide view of transcript abundance and is widely used to investigate gene expression differences among populations, treatments, and biological conditions. In this study, RNA-seq data from alfalfa weevil samples were processed to support de novo transcriptome assembly and downstream transcript quantification.

This repository provides the scripts used for the RNA-seq data-processing workflow. The pipeline begins with read quality assessment using FastQC, followed by rRNA removal, adapter and quality trimming, and host-genome read filtering. Cleaned reads are then prepared for Trinity de novo transcriptome assembly, and transcript abundance is estimated using Salmon.

The overall goal of this workflow is to generate high-quality transcriptomic resources that can be used for downstream analyses such as differential gene expression, functional annotation, and investigation of molecular responses associated with insecticide resistance. The scripts are intended for execution on an HPC cluster using Slurm and Conda-based software environments.
# De novo RNA-seq Pipeline

This repository contains shell and Slurm job scripts used for RNA-seq read processing, host-read removal, de novo transcriptome assembly, and transcript quantification.

The workflow was designed for use on an HPC cluster with the Slurm job scheduler. The scripts include quality control, rRNA removal, read trimming, host-genome read filtering, FASTQ/BAM processing, Trinity transcriptome assembly, and Salmon transcript quantification.

## Pipeline Overview

The RNA-seq workflow includes the following major steps:

1. Run FastQC on raw RNA-seq reads
2. Remove rRNA reads using SortMeRNA
3. Trim adapters and low-quality bases using Trimmomatic
4. Run FastQC again on cleaned paired reads
5. Build a Bowtie2 index for the alfalfa genome
6. Align paired reads to the alfalfa genome using Bowtie2
7. Convert SAM files to BAM files using Samtools
8. Extract paired unmapped reads
9. Sort paired unmapped BAM files by read name
10. Convert sorted BAM files back to FASTQ format
11. Split cleaned paired FASTQ files into R1 and R2 reads
12. Count reads for quality-check summary
13. Clean read headers before Trinity assembly
14. Run Trinity de novo transcriptome assembly
15. Build Salmon transcriptome index
16. Run Salmon quantification for all samples

## Scripts

| Step | Script | Purpose |
|---|---|---|
| 1 | `1_run_fastqc_job.slurm` | Run FastQC quality control on raw RNA-seq reads |
| 2 | `2 sortmerna_job.sh` | Remove rRNA reads using SortMeRNA |
| 3 | `3 run_trimmomatic.slurm` | Trim adapters and low-quality reads using Trimmomatic |
| 4 | `4 run_fastqc_paired_fixed.sh` | Run FastQC on paired cleaned reads |
| 5 | `5 run_bowtie2_index.sh` | Build Bowtie2 index for the alfalfa genome |
| 6 | `6 run_bowtie2_alignment.sh` | Align paired reads to the alfalfa genome |
| 7 | `7 run_convert_sam_to_bam.sh` | Convert SAM alignment files to BAM files |
| 8 | `8 run_filter_paired_unmapped.sh` | Extract paired unmapped reads from BAM files |
| 9 | `9 run_sort_paired_unmapped_reads.sh` | Sort paired unmapped BAM files by read name |
| 10 | `10 run_bam_to_fq.sh` | Convert sorted BAM files back to FASTQ format |
| 11 | `11 run_split_paired_reads.sh` | Split cleaned paired FASTQ files into R1 and R2 files |
| 12 | `12 run_count_reads.sh` | Count reads in FASTQ files and generate a read-count summary |
| 13 | `13 clean_all_reads subset (14).sh` | Clean read headers for a subset of samples before Trinity |
| 13 | `13 clean_all_split_reads_fullset.sh` | Clean read headers for the full sample set before Trinity |
| 14 | `14 run_trinity_subset.sh` | Run Trinity assembly using a subset of samples |
| 14 | `14 run_trinity_full_set.sh` | Run Trinity assembly using the full sample set |
| 14 | `14_run_trinity_updated.sh` | Updated Trinity assembly script with output directed to `Trinity_updated` |
| 15 | `15_salmon_index.sh` | Build Salmon index from the Trinity transcriptome assembly |
| 15 | `15_salmon_quant_all.sh` | Run Salmon quantification for all samples |

## Software and Environments

The scripts use the following tools:

- FastQC
- SortMeRNA
- Trimmomatic
- Bowtie2
- Samtools
- Seqtk
- Trinity
- Salmon
- Conda environments
- Slurm workload manager

Each script activates the required Conda environment before running the analysis.

## Workflow Description

### 1. Quality Control

FastQC is used to check RNA-seq read quality before and after cleaning.

### 2. rRNA Removal

SortMeRNA is used to identify and remove ribosomal RNA reads. The script separates reads into rRNA and non-rRNA output files.

### 3. Read Trimming

Trimmomatic is used to remove adapters and low-quality bases from RNA-seq reads.

### 4. Host Genome Read Removal

Bowtie2 is used to align reads against the alfalfa genome. Reads that do not map to the host genome are retained for downstream de novo transcriptome assembly.

### 5. SAM/BAM Processing

Samtools is used to convert SAM files to BAM files, extract paired unmapped reads, sort BAM files by read name, and convert the final cleaned BAM files back to FASTQ format.

### 6. Paired-read Splitting and Read Counting

Seqtk is used to split cleaned paired FASTQ files into separate R1 and R2 files. A read-counting script is used to summarize the number of reads in each FASTQ file.

### 7. Read Header Cleaning

Before Trinity assembly, read headers are cleaned to remove `/1` and `/2` suffixes. Separate scripts are provided for a subset of samples and the full sample set.

### 8. De novo Transcriptome Assembly

Trinity is used for de novo transcriptome assembly. The repository includes scripts for both a subset assembly and a full-set assembly. The updated Trinity script writes output to a dedicated `Trinity_updated` directory.

### 9. Salmon Indexing and Quantification

Salmon is used for transcript-level quantification. First, a Salmon index is built from the Trinity transcriptome assembly. Then Salmon quantification is run for all RNA-seq samples.

## Sample Groups

The full dataset includes RNA-seq samples from multiple alfalfa weevil populations and treatment groups, including:

- Arizona resistant population
- Montana resistant population
- Wyoming resistant population
- Montana susceptible population
- Lambda-cyhalothrin treated samples
- Acetone control samples

## Important Notes

Raw sequencing files, FASTQ files, SAM files, BAM files, Trinity output files, and Salmon output folders are not included in this repository because they are too large for GitHub.

This repository is intended to store only pipeline scripts and documentation.

Before running the scripts, update the following fields as needed:

- Email address in `#SBATCH --mail-user`
- Input and output directory paths
- Conda environment names
- Genome/transcriptome file paths
- Slurm account and partition information

## Author

Muhammad Umer Masood
