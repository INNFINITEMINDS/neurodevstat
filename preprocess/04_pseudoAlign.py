# run kallisto pseudo-alignment procedure over all couples of paired-end reads

def kallistoWrap(index, data_dir):
    """



    """
    import os
    import sys
    import subprocess

    for isample in samples:
        pseudoalign = ("kallisto quant -i")
        subprocess.call(pseudoalign, shell = True)



kallisto quant -i transcripts.idx -o output -b 100 <(gzcat reads_1.fastq.gz) <(gzcat reads_2.fastq.gz)
