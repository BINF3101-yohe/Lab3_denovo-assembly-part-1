# De novo assembly part 1

### Intro

### Choose a genome

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

We will use a program called **trimmomatic** to remove the adaptors used in Illumina sequences and remove low-quality bases. 


#### 5. Generate a report for your assembly 
To look at the quality of our sequencing data we will use a program called **fastqc**



