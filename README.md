﻿# execR

### Author: Roby Joehanes

## Description
This is a DNANexus app that allows execution of any R scripts without specifically constructing it according to DNANexus app convention.

## Basic Usage
You need to enter in the main R file or tar ball. In case of a tar ball (either `.tar.gz` or `.tar.bz2`), it will be extracted to
`/data` directory with its directory structure intact. It is assumed that your main R file will be `/data/main.R`, which will
be the entry point of your program. You can package several other R codes into the tar ball that you can later source in your main code.
Please be mindful of the directory structure of your tar ball.

Output file: After execution of your R file, you will be allowed to output ONLY ONE file and it MUST be named `/data/results`.
This `/data/results` will later be renamed to the desired file name as specified in the Output file box. If you need to output
multiple files, you MUST zip them (or tar-ball them) into one in an epilogue script, which will be discussed in a latter section.
The output file will be passed as `--output_file` parameter and its contents will always be `/data/results`. However, for future portability reasons, you should always refer to the `--output_file` parameter instead of referencing `/data/results` directly.

Input files: This app allows the specification of up to 10 input files. They are completely optional.
Input files will be passed as `--input_fileX` with X ranging from 1 to 10. All input files will be copied into `/data` directory.

Parameters: This app allows specification of parameters in a string. Multiple parameters are to be specified using a delimiter of your choice.
Example: `2;15000000;20000000;skato`
This would mean chromosome 2 region from 15000000 to 20000000, using method SKAT-O. The semantic is completely up to you.
Parameters will be passed as --param_str and will be enclosed by single quotes.

Debug parameter: This app allows specification of debug parameter of integer type. The number zero or less is usually assumed to mean
that debug is disabled. Positive numbers mean increasing debug verbosity level. You can interpret the debug number any way you want.
Debug parameter will be passed as --debug   

## Prologue and epilogue shell scripts
Occasionally you may need a prologue to pre-process your data files or to install required R packages (and their required libraries).
This app allows specification of prologue shell script. Please do remember that if you install any R packages or system libraries, they will be
completely erased right after the app exits. So, they will need to be reinstalled at every run. Note, however, execR contains many commonly used R analysis packages preinstalled. Chances are, all the packages you would need are already preinstalled. See the subsection below to see what packages are preinstalled in execR.

If you have multiple output files, you MUST zip them or tar ball them together into one file and you MUST name these files `/data/results`.
The epilogue shell script allows you to do this (or any closing work that requires shell). You do not need to uninstall any libraries since
they will be erased after the app exits.

Please be mindful that cloud infrastructure is relatively bare bones. So, you may not have all the "usual" or "standard" computing
libraries or programs come preinstalled.

 
## Helper utility

execR app has a utility script in `/data/utils.R` primarily for parameter parsing. To use in your R code, use the following:

```R
source("/data/utils.R");
args <- processArgs(commandArgs(trailingOnly=TRUE));
```

Variable args will be a named vector containing all the parameters (if specified), such as `args['param_str']`.

Please be mindful that your source tar ball does not overwrite utils.R utility. If you do, then this functionality will be absent.


## Installed R packages

For the available R packages in execR, check here:
https://hub.docker.com/r/robbyjo/r-mkl-bioconductor/


## Example script

Here is an example R script called `testme.R` that basically dumps the subject IDs and the SNP positions of a GDS file into a text file.

```R
source("/data/utils.R");
args <- processArgs(commandArgs(trailingOnly=TRUE));

suppressMessages(library(SeqArray));
suppressMessages(library(SeqVarTools));
suppressMessages(library(gdsfmt));

mdata <- seqOpen(args["input_file1"]);
ids <- seqGetData(mdata, "sample.id");
snps <- seqGetData(mdata, "position");

fileConn <- file(args["output_file"]);
xx <- c(paste("Num IDs =", length(ids)), paste("Num SNPs =", length(snps)));
xx <- c(xx, "====IDs====", ids, "====SNP locations====", as.character(snps));
writeLines(xx, fileConn);

close(fileConn);
cat("End of call!\n");
q("no");
```

The program is called with an example gds input file, and will save the output text file to `testme-output.txt`. Here is the running log

```
CPU: 3% (4 cores) * Memory: 518/15041MB * Storage: 1674GB free * Net: 0↓/0↑MBps
dxpy/0.231.0 (Linux-4.4.0-92-generic-x86_64-with-Ubuntu-14.04-trusty)
Downloading bundled file resources.tar.gz
>>> Unpacking resources.tar.gz to /
Installing apt packages dx-toolkit
Setting SSH public key
dxpy/0.231.0 (Linux-4.4.0-92-generic-x86_64-with-Ubuntu-14.04-trusty)
/usr/sbin/sshd already running.
bash running (job ID job-F6Xv138067K7PYG399VJb714)
Value of r_code: '{"$dnanexus_link": "file-F6XpQvj067KJ3FX506zvQ1GQ"}'
Value of output_file: 'testme-output.txt'
Real name of r_code file: testme.R
Value of param_str: '2;x;blahblah'
Value of debug: '1'
Value of input_file1: '{"$dnanexus_link": "file-F2X8gK80zk085pZ30JjF6y71"}'
Real name of input_file1: freeze4.chr21.pass.gtonly.minDP10.genotypes.gds
Waiting for all file transfers to complete...
R code is assumed in an R format, renaming to /data/main.R
===== Listing /data/ =====
/data/:
freeze4.chr21.pass.gtonly.minDP10.genotypes.gds
main.R
utils.R
===== Listing /data/ ends =====
The following script is going to be executed:
============================ Script begin ============================ 
#!/bin/bash
export MKL_NUM_THREADS=1
echo "pwd is:"
pwd
echo "Rscript /data/main.R --r_code=testme.R --output_file=/data/results --param_str='2;x;blahblah' --debug=1 --input_file1=/data/freeze4.chr21.pass.gtonly.minDP10.genotypes.gds"
echo "Running code"
/usr/bin/Rscript --vanilla /data/main.R --r_code=testme.R --output_file=/data/results --param_str='2;x;blahblah' --debug=1 --input_file1=/data/freeze4.chr21.pass.gtonly.minDP10.genotypes.gds
echo "Finished running main R code"
============================= Script end ============================= 
Image Repo	robbyjo/r-mkl-bioconductor
Image Tag	3.4.1
Image Size	3.5G
Image ID	a66466e6602cae1d487de81554b0da80b3ff4a49919ee446a02a3638300e4f59
Parent ID	d8483726b0f5ac411e89e57b98c5ed6b99f54ec2ea11a72525a0f3bac01b61d5
Last Updated	2017-07-19T18:44:03Z (41d 0h ago)
Default CMD	["/bin/bash"]
proot warning: can't sanitize binding "/var/run/dbus/system_bus_socket": No such file or directory
pwd is:
/
Rscript /data/exec.R --r_code=/data/testme.R --output_file=/data/results --param_str='2;x;blahblah' --debug=1 --input_file1=/data/freeze4.chr21.pass.gtonly.minDP10.genotypes.gds
Running code
This program is called with the following parameters:
   Parameter                                                 Value
      r_code                                        /data/testme.R
 output_file                                         /data/results
   param_str                                          2;x;blahblah
       debug                                                     1
 input_file1 /data/freeze4.chr21.pass.gtonly.minDP10.genotypes.gds
End of call!
Finished running main R code
Uploaded results: 'file-F6Xv2k0092VJ2z9g9qgvV7BX'
Moving results to testme-output.txt
``` 
