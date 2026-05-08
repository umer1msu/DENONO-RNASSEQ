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

- ## Downstream RNA-seq Analysis Workflow

After read cleaning, Trinity assembly, and Salmon quantification, the downstream RNA-seq analysis was performed in a logical order. This section describes the purpose of each downstream script and how each step connects to the next part of the analysis.

### Step 1. Activate the R Environment

Before running the downstream R scripts, the Conda R environment was activated on the HPC cluster.

File:
how to active my R Env and launch R.txt

Purpose:
This file shows the commands used to activate the R environment for downstream RNA-seq analysis.

Commands:
source ~/.bashrc
conda activate salmon_r_env
R

### Step 2. Generate Trinity Gene-to-Transcript Mapping File

Trinity produces transcript-level assemblies. Before Salmon transcript-level results can be summarized at the gene level, a transcript-to-gene mapping file is required.

File:
R Script.txt

Purpose:
This script generates the Trinity gene-to-transcript map and converts it into the tx2gene format required by tximport.

Main outputs:
Trinity_filtered_500bp.gene_trans_map
Trinity_filtered_500bp_tx2gene.txt

Logical step:
Trinity transcriptome FASTA
        ↓
Trinity gene-transcript map
        ↓
tx2gene file for tximport

### Step 3. Import Salmon Quantification and Create Gene-Level Matrices

Salmon produces transcript-level quantification files. These files are imported into R and summarized at the gene level using tximport.

Files:
17.txt
R Script 6-18-2025.txt
R Script.txt

Purpose:
These scripts import Salmon quant.sf files and generate gene-level expression matrices.

Main outputs:
GeneLevel_Counts.csv
GeneLevel_TPM.csv
GeneLength.csv
salmon_merged_counts.csv
salmon_merged_tpm.csv
salmon_transcript_lengths.csv

Logical step:
Salmon quant.sf files
        ↓
tximport
        ↓
Gene-level counts, TPM, and length matrices

### Step 4. Run Gene-Level Differential Expression Analysis

After generating gene-level count matrices, DESeq2 was used to identify differentially expressed genes among treatment and population groups.

Files:
17.txt
R Script 6-18-2025.txt

Purpose:
These scripts run DESeq2 comparisons using gene-level counts and sample metadata.

Main comparisons:
ART_vs_ARC
MRT_vs_MRC
WRT_vs_WRC
MRC_vs_MSC

Main outputs:
DESeq2_results_ART_vs_ARC.csv
DESeq2_results_MRT_vs_MRC.csv
DESeq2_results_WRT_vs_WRC.csv
DESeq2_results_MRC_vs_MSC.csv
normalized_counts_*.csv
dds_*.RData
summary_*.txt

Logical step:
GeneLevel_Counts.csv + sample metadata
        ↓
DESeq2
        ↓
Differential expression result tables

### Step 5. Perform PCA and Sample Clustering

Principal component analysis was used to check sample clustering patterns and evaluate whether samples group by population, treatment, region, or resistance status.

File:
PCS_VST.txt

Purpose:
This file contains multiple PCA approaches for visualizing sample-level expression patterns.

PCA approaches included:
VST-based PCA
log2(TPM + 1)-based PCA
rlog-based PCA
PCA using all filtered genes
PCA using top 1000 variable genes
PCA using top 2000 variable genes
3D PCA

Main outputs:
PCA_scores_VST.tsv
PCA_scores_TPM_log2.tsv
PCA_scores_rlog.tsv
PCA_VST_allSamples_GroupCondition.png
PCA_TPM_allSamples_GroupCondition.png
PCA_rlog_allSamples_GroupCondition.png

Logical step:
Gene-level counts or TPM
        ↓
Transformation using VST, rlog, or log2(TPM + 1)
        ↓
PCA plots
        ↓
Sample clustering interpretation

### Step 6. Identify Candidate Resistance-Related Genes

After DESeq2 analysis, annotation files were used to identify genes belonging to resistance-related gene families.

Files:
How_to_candidate_Genes_R.txt
How_to_candidate_Genes_R2.txt
R script to filter genes.txt

Purpose:
These scripts use Trinotate and Pfam annotation files to identify candidate resistance-related genes.

Input files:
trinotate_annotation_report.tsv
pfam.domtblout
All_DEG_WRT_vs_WRC.csv
All_DEG_WRC_vs_MSC.csv
All_DEG_MRC_vs_MRT.csv
All_DEG_MRC_vs_MSC.csv
All_DEG_ART_vs_ARC.csv

Gene families searched:
P450
GST
Esterase
ABC transporter
UGT
Target-site sodium channel/Nav
Cuticular protein
Muscle structural genes
Electron transport genes

Main outputs:
BROAD_Resistance_Gene_Survey.csv
Final_Resistome_Precision_v3.csv
Final_Resistome_GENE_LEVEL.csv

Logical step:
Trinotate + Pfam annotations
        ↓
Resistance keyword and Pfam search
        ↓
Candidate resistance gene table
        ↓
DESeq2 results mapped onto candidate genes

### Step 7. Filter Significant Candidate Genes

After generating candidate gene tables, significant candidate genes were filtered using adjusted p-value and fold-change thresholds.

Files:
Filtering_the_survey.txt
R script to filter genes.txt

Purpose:
These scripts keep genes that are significant in at least one comparison.

Filtering threshold:
padj < 0.05
|log2FoldChange| >= log2(1.5)

This is equivalent to:
Adjusted p-value < 0.05
Fold change >= 1.5

Main outputs:
Filtered_Candidates_FC1.5.csv
Filtered_Active_Genes_v3.csv
Final_Resistome_GENE_LEVEL.csv

Logical step:
Candidate resistance gene table
        ↓
Apply padj and fold-change threshold
        ↓
Filtered active resistance-related genes

### Step 8. Create Sankey/Alluvial Plot for Regulatory Patterns

The final filtered candidate gene table was used to visualize how resistance-related gene families were distributed across comparisons and expression directions.

File:
sankey code.txt

Purpose:
This script creates a Sankey/alluvial plot showing the relationship among gene family, comparison, expression direction, and regulatory fate.

The plot summarizes:
Gene family
Comparison
Upregulated or downregulated direction
Regulatory fate

Regulatory fate categories:
Unique Induc Up
Unique Induc Down
Unique Const Up
Unique Const Down
Shared Induc
Shared Const
Cross-Shared

Main input:
Final_Resistome_MERGED_ALL.csv

Main output:
Sankey/alluvial plot of resistance-related gene expression patterns

Logical step:
Filtered candidate resistance genes
        ↓
Classify by family, comparison, and expression direction
        ↓
Assign regulatory fate
        ↓
Generate Sankey/alluvial plot

## Complete Logical Workflow

1. Activate R environment
        ↓
2. Generate Trinity gene-to-transcript map
        ↓
3. Import Salmon quantification with tximport
        ↓
4. Create gene-level counts, TPM, and length matrices
        ↓
5. Run DESeq2 differential expression analysis
        ↓
6. Perform PCA and sample clustering
        ↓
7. Mine candidate resistance-related genes using Trinotate and Pfam
        ↓
8. Filter significant candidate genes using padj and log2FC thresholds
        ↓
9. Visualize resistance-gene patterns using Sankey/alluvial plots

## Short Workflow Summary

The downstream RNA-seq workflow begins by importing Salmon transcript-level quantification into R using tximport. The transcript-level results are summarized into gene-level count, TPM, and length matrices. Gene-level differential expression analysis is then performed using DESeq2. PCA is used to evaluate sample clustering and expression patterns. Candidate resistance-related genes are identified using Trinotate and Pfam annotations, filtered using adjusted p-value and fold-change thresholds, and visualized using Sankey/alluvial plots to summarize gene-family-specific regulatory patterns across comparisons.

## Author

Muhammad Umer Masood
