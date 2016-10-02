def dump_data(codebook, outdir):
    """
    This script loads the codebook via Pandas and uses the subject IDs to
    download the zipped FastQ files for each SRA ID

    _Parameters:_
    codebook : string
               path to where the codebook is stored

    outdir: string
            path to the directory to which the FastQ files are downloaded
    """

    import os
    import getpass
    import subprocess
    import pandas as pd

    metadata = pd.read_csv((str(os.getcwd()) + '/' + str(outdir) + '/' +
                            str(codebook) + '.csv'))
    ids = metadata.drop([col for col in metadata if 'run'  not in col], 1)
    ids = pd.concat([ids.run_ID_1, ids.run_ID_2], 0)

    for id in ids.ravel():
        fetch_data = ('prefetch' + ' ' + id)
        subprocess.call(fetch_data, shell = True)

    for id in ids.ravel():
        data_dump = ('fastq-dump --outdir ' + os.path.abspath(os.getcwd() +
                     '/' + str(outdir)) + ' ' + '--gzip' + ' ' +
                     '~/ncbi/public/sra/' + id + '.rsa')
        subprocess.call(data_dump, shell = True)

if __name__ == '__main__':
    dump_data(codebook = 'codebook', outdir = 'data')
