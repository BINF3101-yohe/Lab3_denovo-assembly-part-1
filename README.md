# Lab 2: De novo assembly part 1

# Outline

[Step 1: Intro](#step-1-intro)

[Step 2: Choose a genome](#step-2-choose-a-genome)

[LQ1](#lq1)

[LQ2](#lq2)

[Step 3: Download a genome](#step-3-download-a-genome)

[LQ3](#lq3)

[Step 4: Filter your fastq file](#step-4-filter-your-fastq-file)

[LQ4](#lq4)

[LQ5](#lq5)

[Step 5: Analyze your trimmed read quality](#step-5-analyze-your-trimmed-read-quality)

[LQ6](#lq6)

[Commands and Software](#commands-and-software)

&nbsp;
## Step 1: Intro

Over the past decade or so, Dr. LaBella (me!) has been a part of a large consortium that attempted to sequence all known species of budding yeasts. We will be analyzing the raw sequencing data generated as a part of this project. 

The genomes that are currently publically available were described in this paper: https://www.cell.com/cell/pdf/S0092-8674(18)31332-1.pdf 

&nbsp;
## Step 2: Choose a genome

You will need to choose one genome/species to analyze during the course of this project. There are almost 200 species to choose from! 

Go to this link and choose a species to work with this semester. Feel free to google the species to see what they are first! 

The species are listed under **Taxonomy** - See image below. 
List of Species: https://www.ncbi.nlm.nih.gov/bioproject?LinkName=sra_bioproject&from_uid=4951374 

<img src="https://github.com/BINF-3101/denovo-assembly-part-1/assets/47755288/53ec120d-3095-4204-b174-1d050091afb0" width="400">

Once you have chosen a genome **use this link to put your name next to your genome**

https://docs.google.com/spreadsheets/d/1Fvb5iW0VzAHfdC9qCPUcYTGsT4yJ4a4Wj8rn6pobHNc/edit?usp=sharing

### Step 2a: BioSample
To find the Sequence Read Archive (SRA) data you will click on the "BioSample" link

<img src="https://github.com/BINF-3101/denovo-assembly-part-1/assets/47755288/98482b42-7a09-4628-9406-9ad1923623f2" width="400">

### Step 2c: Click on SRA
At the bottom and right-hand side of the page you will see a link to the SRA. Click that link

<img src="https://github.com/BINF-3101/denovo-assembly-part-1/assets/47755288/d996ae5a-9874-4963-afaa-d34893e13ac3" width="400">

### Step 2d: Pick the genome

Some of the genomes we are using have been subsequently re-sequenced. To make sure we are all on the same page select genome 2. (Do not select the one starting with yHMP)

<img src="https://github.com/BINF-3101/denovo-assembly-part-1/assets/47755288/b2318a16-c292-4b0f-8e31-e8a2faf66faf" width="400">


### Step 2e: Find SRA Run identifier
In the table you will see 1 run listed. Under the Run you will see a link. This is the identifier you will use throughout the project. 

<img src="https://github.com/BINF-3101/denovo-assembly-part-1/assets/47755288/3440db16-5673-427f-8c59-57929617d8bc" width="400">

I have chosen to do the tutorial with SRR6475892 (_Blastobotrys americana_). This means **you cannot choose SRR6475892**. 
This also means **whenever you see SRR6475892 in the commands you will replace it with your own genome identifier**. 
&nbsp;
## LQ1
**What is the name of the species you chose?**
&nbsp;
## LQ2
**What is the SRA Run identifier of the species you chose?**
&nbsp;
## Step 3: Download a genome

### Before you begin

**Log into the cluster**

You will want to create a new folder to work in. I suggest creating a folder in your home directory (which is where you will be when you first log in)

Make the new directory

```bash
mkdir lab_2
```

Now move into the new directory **before you begin** by using the change directory (cd) command. 

```bash
cd lab_2
```


### Step 3a: Load the SRA Toolkit on the cluster

The SRA provides a set of tools to help us retrieve data from the SRA. You will need to load these tools in your terminal. 

```bash
module load sra-tools/
```



```bash
vdb-config --interactive
```

The screen will **go blue and change** looking like this
![image](https://github.com/BINF-3101/denovo-assembly-part-1/assets/47755288/470884c1-1580-4838-b837-c48131a62936)

**press the x key**

The window should close


In the future if you get the error below rerun the above command
```
This sra toolkit installation has not been configured.
Before continuing, please run: vdb-config --interactive
For more information, see https://www.ncbi.nlm.nih.gov/sra/docs/sra-cloud/
```

If this occurs type this command and try again
   
### Step 3b: Retrieve the SRA file

To obtain the sequencing data you will use the SRA identifier associated with your genome and the command ```prefetch```

```bash
prefetch SRR6475892
```

Once it is done, type ``ls`` to list the files and folders that were created

### Step 3c: Extract the fastq files

SRA data is saved in a file format called .sra that can be converted to a wide array of file types. We want to get the fastq files associated with the genome so we will use the ```fastq-dump``` command. 

```bash
cd SRR6475892/                        #enter the folder you downloaded
ls                                    #see what is in the folder
fastq-dump --split-e SRR6475892.sra   #We did paired-end sequencing so you will need to split them using this command
ls                                    #see the files you created
```

You can find out more about fastq files here: https://en.wikipedia.org/wiki/FASTQ_format

&nbsp;
## LQ3
**How many reads are there in your fastq file(s)? Report the number and the command.**
Hint: Take a look at your file using the ```head``` command. Is there anything specific about each sequence description? Can you use the ```grep``` command to count how many times you see that specific sequence descriptor?

&nbsp;
## Step 4: Filter your fastq file

The sequence file analyzed here has ~6.5 million reads. We know from class that these reads can vary in quality and that there are adapters used in the sequencing that need to be removed.

We will use a program called **trimmomatic** to remove the adaptors used in Illumina sequences and remove low-quality bases. You can read more about trimmomatic here: http://www.usadellab.org/cms/?page=trimmomatic

trimmomatic can take a few minutes to run so we will run it using our first **slurm script**. 

### Step 4a: Run trimmomatic
Follow these steps to run trimmomatic
&nbsp;
- Copy the slurm (trimmomatic.slurm) script to your working directory (it must be in the same directory as your files)
   ```bash
   cp /projects/class/binf3101_001/trimmomatic.slurm .
   ```
&nbsp;
- Edit the slurm script so that it will analyze the genome that you chose - you can use vi or nano

_Note when you look at the slurm script you will see SRR6475892_1.fastq SRR6475892_2.fastq... you will need to change the SRR to your SRR number_
&nbsp;  
- Submit the slurm script using the command ```sbatch trimmomatic.slurm```
&nbsp;  
- Check that your slurm script is running using the command ```squeue -u usrname```
&nbsp;
&nbsp;
&nbsp;
While the program is running let's look at the trimmomatic command we ran 
```java -jar /apps/pkg/trimmomatic/0.39/trimmomatic-0.39.jar PE -threads 4 SRR6475892_1.fastq SRR6475892_2.fastq SRR6475892_1_paired.fastq.gz SRR6475892_1_unpaired.fastq.gz SRR6475892_2_paired.fastq.gz SRR6475892_2_unpaired.fastq.gz ILLUMINACLIP:/apps/pkg/trimmomatic/0.39/adapters/TruSeq2-PE.fa:2:30:10 HEADCROP:15 TRAILING:30 SLIDINGWINDOW:4:15 MINLEN:36```

```java -jar /apps/pkg/trimmomatic/0.39/trimmomatic-0.39.jar``` This starts the process of running the java program trimmomatic

```PE``` This stands for Paired-End

```-threads 4``` This tells the program to use 4 threads to conduct the analysis. 

```SRR6475892_1.fastq SRR6475892_2.fastq``` These are our input files

```SRR6475892_1_unpaired.fastq.gz SRR6475892_2_paired.fastq.gz SRR6475892_2_unpaired.fastq.gz``` These are where our output files will be saved for our analysis. There are 4 output files: 2 for the 'paired' output where both reads survived the processing, and 2 for corresponding 'unpaired' output where a read survived, but the partner read did not

```ILLUMINACLIP:/apps/pkg/trimmomatic/0.39/adapters/TruSeq2-PE.fa:2:30:10``` This is the directory where the Illumina adaptors (repeated sequences) are stored. This tells trimmomatic what to look for and remove. 

```HEADCROP:15 TRAILING:30 SLIDINGWINDOW:4:15 MINLEN:36``` These are the settings to trim the sequences. Use the website http://www.usadellab.org/cms/?page=trimmomatic to learn more about these settings. 
&nbsp;
## LQ4
**How many bases did we cut off at the end of our reads?**

Once the pipeline is done running you will see the 4 output files appear in your directory. You will also see the slurm output from your run with the format ```slurm-0000.out```. This slurm output will have some metrics from your trimmomatic analysis - you can look at the file using ```cat slurm-0000.out```

&nbsp;
## LQ5
**What percent of your reads survived both the forward and reverse filtering?**
Hint: This will be in your slurm output file. 

&nbsp;
## Step 5: Analyze your trimmed read quality
To look at the quality of our sequencing data we will use a program called **fastqc**. We will run this on only our successfully paired reads. 

### Step 5a: Run fastqc

```bash
module load fastqc
fastqc SRR6475892_1_paired.fastq.gz SRR6475892_2_paired.fastq.gz
```
This will generate a number of files with the ```fastqc``` in the name. We are interested in looking at the html files which have a nice summary of the quality of our reads. 

### Step 5b: Analyze fastqc results

You will likely need to download the html files to look at them. Once you have them open you will be able to see the summary report for your paired reads. You **may not get all green check marks** for quality. That is ok! We could go back and re-run trimmomatic again, but these should be good enough to move foward. 

&nbsp;
## LQ6
**What are the scores you got for your genomes across the various statistics?**

&nbsp;
# Commands and Software
&nbsp;
##### sra tools
Command for downloading SRA data 
```bash
prefetch [SRA_ID]
```
 &nbsp;
 Command for splitting paired sequencing reads
```bash
fastq-dump --split-e [SRA_ID}.sra
```
Details here: https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump

&nbsp;

##### trimmomatic
Trimmomatic is run using java
```bash
java -jar /apps/pkg/trimmomatic/0.39/trimmomatic-0.39.jar [PE/SE] [options]
```
Details here: http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf

&nbsp;
##### FastQC
Fastqc will assess the quality of our reads
```bash
fastqc [reads_to_be_analyzed]
```
Details here: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/



