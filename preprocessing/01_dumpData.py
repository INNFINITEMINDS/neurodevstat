def dumpData(codebook, dump_target):
    """
    This script loads the codebook via Pandas and uses the subject IDs to
    download the zipped FastQ files for each subject

    _Parameters:_
    codebook : string
                path to where the codebook is stored

    dump_target : string
                    path to where the FastQ files should be downloaded to
    """

    import os
    import sys
    import subprocess
    import pandas as pd

    codebook = pd.read_csv("")
