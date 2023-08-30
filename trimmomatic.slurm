#!/bin/bash 

#SBATCH --partition=Centaurus
#SBATCH --partition=Orion
#SBATCH --job-name=trimmomatic
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=6:00:00

echo "======================================================"
echo "Start Time  : $(date)"
echo "Submit Dir  : $SLURM_SUBMIT_DIR"
echo "Job ID/Name : $SLURM_JOBID : $SLURM_JOB_NAME"
echo "Node List   : $SLURM_JOB_NODELIST"
echo "Num Tasks   : $SLURM_NTASKS total [$SLURM_NNODES nodes @ $SLURM_CPUS_ON_NODE CPUs/node]"
echo "======================================================"
echo ""

module load trimmomatic

mkdir trimmomatic

java -jar /apps/pkg/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 4 SRR6475892_1.fastq SRR6475892_2.fastq SRR6475892_1_paired.fastq.gz SRR6475892_1_unpaired.fastq.gz SRR6475892_2_paired.fastq.gz SRR6475892_2_unpaired.fastq.gz ILLUMINACLIP:/apps/pkg/trimmomatic/0.39/adapters/TruSeq2-PE.fa:2:30:10 HEADCROP:15 TRAILING:30 SLIDINGWINDOW:4:15 MINLEN:36 



echo ""
echo "======================================================"
echo "End Time   : $(date)"
echo "======================================================"

