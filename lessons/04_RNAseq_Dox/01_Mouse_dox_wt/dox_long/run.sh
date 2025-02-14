#!/bin/bash
#SBATCH -p short
#SBATCH --job-name=dox_timecourse_long
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=mili7948@colorado.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=6gb
#SBATCH --time=10:00:00
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err

pwd; hostname; date
echo "Here we go You've requested $SLURM_CPUS_ON_NODE core."

NXF_SINGULARITY_CACHEDIR=/scratch/Shares/rinn/ZM/singularity_cache
export NXF_SINGULARITY_CACHEDIR

module load openjdk/21.0.1

module load singularity/3.1.1

nextflow run nf-core/rnaseq -r 3.14.0 \
-resume \
-profile singularity \
--input /scratch/Shares/rinnclass/MASTER_CLASS/STUDENTS/mili7948/MASTER_CLASS/lessons/04_RNAseq_Dox/01_Mouse_dox_wt/dox_long/samplesheet.csv \
--outdir /scratch/Shares/rinnclass/MASTER_CLASS/STUDENTS/mili7948/MASTER_CLASS/lessons/04_RNAseq_Dox/01_Mouse_dox_wt/dox_long/nextflow_results_dox_long/ \
--reads /scratch/Shares/rinnclass/MASTER_CLASS/DATA/mouse_wt_long_timecourse/*{_1,_2}.fastq.gz \
--fasta /scratch/Shares/rinnclass/MASTER_CLASS/GENOMES/M25/GRCm38.p6.genome.fa \
--gtf /scratch/Shares/rinnclass/MASTER_CLASS/GENOMES/M25/gencode.vM25.annotation.gtf \
--pseudo_aligner salmon \
--gencode \
--email mili7948@colorado.edu \
-c nextflow.config

date
