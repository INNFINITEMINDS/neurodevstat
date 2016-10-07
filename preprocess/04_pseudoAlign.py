# run kallisto pseudo-alignment procedure over all couples of paired-end reads

def kallistoWrap(data_dir, fastq_dir, out_dir):
    """
    This is a utility wrapper for the Kallisto pseudo-alignment command line
    tool, to be used for iteratively performing alignments on paired-end RNA-seq
    reads from an arbitrary sample.

    Parameters
    ----------
    data_dir : string
               A string specifying the (local) directory where the RNA-seq data
               for this project are stored.
    fastq_dir : string
                A string specifying the subdirectory in `data_dir`, where the
                (gzipped) FASTQ files are stored.
    out_dir : string
              A string specifying the subdirectory in `data_dir` where generated
              output files are to be stored.
    """

    import os
    import sys
    import subprocess
    import numpy as np

    dir_data = os.path.abspath(os.getcwd() + "/data/" + str(data_dir))
    dir_fastq = dir_data + "/" + fastq_dir
    dir_out = dir_data + "/" + out_dir

    samples = [s[:10] for s in os.listdir(dir_fastq)]
    samples = list(np.unique(samples))

    for i in samples:
        pseudoalign = ("kallisto quant -i" + " " +
                       "./data/Homo_sapiens.GRCh38.rel79.idx -o" + " " +
                       str(dir_data) + "/" + str(out_dir) + "/" + str(i) + " " +
                       "-b 100" + " " + dir_fastq + "/" + str(i) + "_1.fastq.gz"
                       + " " + dir_fastq + "/" + str(i) + "_2.fastq.gz")
        subprocess.call(pseudoalign, shell = True)


if __name__ == '__main__':
    kallistoWrap(data_dir = 'data_Jaffe2015',
                 fastq_dir = 'gz',
                 out_dir = 'quantKallisto')
