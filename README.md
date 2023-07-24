# De novo assembly part 1

### Intro

### Choose a genome

#LQ - What is the name of the species you chose?
#LQ - What is the SRA identifier of the species you chose?

### Download a genome

1. Load the SRA Toolkit on the cluster

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
   
2. Retrieve the SRA file

To obtain the sequencing data you will use the SRA identifier associated with your genome and the command "prefetch"

```bash
prefetch SRR6475892
```

3. Extract the fastq files

SRA data is saved in a file format called .sra that can be converted to a wide array of file types. We want to get the fastq files associated with the genome so we will use the "fastq-dump" command. 

```bash
cd SRR6475892/               #enter the folder you downloaded
ls                           #see what is in the folder
fastq-dump SRR6475892.sra
ls                           #see the files you created
```

# LQ - How many reads are there in your fastq file?
Hint: Take a look at your file using the ```head``` command. Is there anything specific about each sequence description? Can you use the ```grep``` command to count how many times you see that specific sequence descriptor?


