# rename all pngs in current folder

import os
import sys

def rename():
    i = 0
    path = os.getcwd()
    for filename in os.listdir(path):
        if filename.endswith(".png"):
            os.rename(filename, "m9k_" + str(i) + ".png")
            i = i + 1

rename()