# rename all pngs in current folder

import os
import sys

def rename():
    i = 0
    path = os.getcwd()
    for filename in os.listdir(path):
        if filename.startswith("m9k_m9k_"):
            # remove first 4 characters
            os.rename(filename, filename[4:])
            i = i + 1

rename()