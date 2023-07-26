# De novo assembly part 1

### Intro

### Choose a genome

I have chosen to do the tutorial with SRR6475892. This means **you cannot choose SRR6475892**. 
This also means whenever you see SRR6475892 in the commands you will replace it with your own genome identifier. 

## LQ
**What is the name of the species you chose?**
## LQ
**What is the SRA identifier of the species you chose?**

### Download a genome

#### 1. Load the SRA Toolkit on the cluster

The SRA provides a set of tools to help us retrieve data from the SRA. You will need to load these tools in your terminal. 

```bash
module load sra-tools/
```

You may get an error that says
```
This sra toolkit installation has not been configured.
Before continuing, please run: vdb-config --interactive
For more information, see https://www.ncbi.nlm.nih.gov/sra/docs/sra-cloud/
```

If this occurs type this command and try again

```bash
vdb-config --restore-defaults
```
   
#### 2. Retrieve the SRA file

To obtain the sequencing data you will use the SRA identifier associated with your genome and the command ```prefetch```

```bash
prefetch SRR6475892
```

#### 3. Extract the fastq files

SRA data is saved in a file format called .sra that can be converted to a wide array of file types. We want to get the fastq files associated with the genome so we will use the ```fastq-dump``` command. 

```bash
cd SRR6475892/                        #enter the folder you downloaded
ls                                    #see what is in the folder
fastq-dump --split-e SRR6475892.sra   #We did paired-end sequencing so you will need to split them using this command
ls                                    #see the files you created
```

## LQ
**How many reads are there in your fastq file(s)? Report the number and the command.**
Hint: Take a look at your file using the ```head``` command. Is there anything specific about each sequence description? Can you use the ```grep``` command to count how many times you see that specific sequence descriptor?


#### 4. Filter your fastq file

The sequence file analyzed here has ~6.5 million reads. We know from class that these reads can vary in quality and that there are adapters used in the sequencing that need to be removed.

We will use a program called **trimmomatic** to remove the adaptors used in Illumina sequences and remove low-quality bases. You can read more about trimmomatic here: http://www.usadellab.org/cms/?page=trimmomatic

trimmomatic can take a few minutes to run so we will run it using our first **slurm script**. 

Follow these steps to run trimmomatic
- Upload or copy the slurm (trimmomatic.slurm) script to your working directory (it must be in the same directory as your files)
- Edit the slurm script so that it will analyze the genome that you chose
- Submit the slurm script using the command ```sbatch trimmomatic.slurm``
- Check that your slurm script is running using the command ```squeue -u usrname```

While the program is running let's look at the trimmomatic command we ran 
```java -jar /apps/pkg/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 4 SRR6475892_1.fastq SRR6475892_2.fastq SRR6475892_1_paired.fastq.gz SRR6475892_1_unpaired.fastq.gz SRR6475892_2_paired.fastq.gz SRR6475892_2_unpaired.fastq.gz ILLUMINACLIP:/apps/pkg/trimmomatic/0.39/adapters/TruSeq2-PE.fa:2:30:10 HEADCROP:15 TRAILING:30 SLIDINGWINDOW:4:15 MINLEN:36```

```java -jar /apps/pkg/trimmomatic/0.39/trimmomatic-0.39.jar``` This starts the process of running the java program trimmomatic

```PE``` This stands for Paired-End

```-threads 4``` This tells the program to use 4 threads to conduct the analysis. 

```SRR6475892_1.fastq SRR6475892_2.fastq``` These are our input files

```SRR6475892_1_unpaired.fastq.gz SRR6475892_2_paired.fastq.gz SRR6475892_2_unpaired.fastq.gz``` These are where our output files will be saved for our analysis. There are 4 output files: 2 for the 'paired' output where both reads survived the processing, and 2 for corresponding 'unpaired' output where a read survived, but the partner read did not

```ILLUMINACLIP:/apps/pkg/trimmomatic/0.39/adapters/TruSeq2-PE.fa:2:30:10``` This is the directory where the Illumina adaptors (repeated sequences) are stored. This tells trimmomatic what to look for and remove. 

```HEADCROP:15 TRAILING:30 SLIDINGWINDOW:4:15 MINLEN:36``` These are the settings to trim the sequences. Use the website http://www.usadellab.org/cms/?page=trimmomatic to learn more about these settings. 

## LQ
**How many bases did we cut off at the end of our reads?**

Once the pipeline is done running you will see the 4 output files appear in your directory. 

#### 5. Generate a report for your assembly 
To look at the quality of our sequencing data we will use a program called **fastqc**



