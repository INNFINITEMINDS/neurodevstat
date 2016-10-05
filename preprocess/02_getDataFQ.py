def dataFQ_Jaffe(link, local):
    """
    This is a simple utility function intended for downloading a zipped directory
    of gzipped FASTQ data from the Jaffe et al. 2014 paper in Nature Neuroscience,
    which are made available via Dropbox for the ease of reproducing this project.
    
    Parameters
    ----------
    link : string
           A string giving the Dropbox URL where the data directory is located.
    local : string
            A string providing the name to be given to the directory when
            downloading.
    """

    import os
    import subprocess

    data_dir = os.path.abspath(str(os.getcwd()) + '/data')

    pull_data= ('curl' + ' ' + '-L' + ' ' + '-o' + data_dir + '/' + str(local) +
                '.zip' + ' ' + str(link))
    unzip_data = ('unzip' + ' ' + data_dir + '/' + str(local) + '.zip' + ' ' +
                  '-d' + data_dir + '/' + str(local))
    
    subprocess.call(pull_data, shell = True)
    subprocess.call(unzip_data, shell = True)

if __name__ == '__main__':
    dataFQ_Jaffe(link = '',
                 local = 'dataJaffe_2014')
