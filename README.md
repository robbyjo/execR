# execR

###Author: Roby Joehanes

##Description
This is a DNANexus app that allows execution of any R scripts without specifically constructing it according to DNANexus app convention.

##Basic Usage
You need to enter in the main R file or tar ball. In case of a tar ball (either .tar.gz or .tar.bz2), it will be extracted to
/data directory with its directory structure intact. It is assumed that your main R file will be /data/main.R, which will
be the entry point of your program. You can package several other R codes into the tar ball that you can later source in your main code.
Please be mindful of the directory structure of your tar ball.

Output file: After execution of your R file, you will be allowed to output ONLY ONE file and it MUST be named /data/results.
This /data/results will later be renamed to the desired file name as specified in the Output file box. If you need to output
multiple files, you MUST zip them (or tar-ball them) into one in an epilogue script, which will be discussed in a latter section.
The output file will be passed as --output_file parameter and its contents will always be /data/results

Input files: This app allows the specification of up to 10 input files. They are completely optional.
Input files will be passed as --input_fileX with X ranging from 1 to 10.

Parameters: This app allows specification of parameters in a string. Multiple parameters are to be specified using a delimiter of your choice.
Example: 2;15000000;20000000;skato
This would mean chromosome 2 region from 15000000 to 20000000, using method SKAT-O. The semantic is completely up to you.
Parameters will be passed as --param_str

Debug parameter: This app allows specification of debug parameter of integer type. The number zero or less is usually assumed to mean
that debug is disabled. Positive numbers mean increasing debug verbosity level. You can interpret the debug number any way you want.
Debug parameter will be passed as --debug   

##Prologue and epilogue shell scripts
Occasionally you may need a prologue to pre-process your data files or installing required R packages (and their required libraries).
This app allows specification of prologue shell script. Please do remember that if you install any R packages or system libraries, they will be
completely erased right after the app exits. So, they will need to be reinstalled in every run.

If you have multiple output files, you MUST zip them or tar ball them together into one file and you MUST name these files /data/results.
The epilogue shell script allows you to do this (or any closing work that requires shell). You do not need to uninstall any libraries since
they will be erased after the app exits.

Please be mindful that cloud infrastructure is relatively bare bones. So, you may not have all the "usual" or "standard" computing
libraries or programs come preinstalled.

 