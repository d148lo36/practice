#!/bin/python3

import shutil   # For CopyFile
import os       # For GetFileSize and check if file exist
import sys      # For Command Line arguments

# purge_log.py  mylog.txt   10  5

if(len(sys.argv) < 4):  # if CL arguments < 4
    print("Missing arguments! Example: script.py  10  5")
    exit(1)

file_name = sys.argv[1]
limitsize = int(sys.argv[2])
logsnumber = int(sys.agrv[3])

if(os.path.isfile(file_name) == True):          # Check if logfile is exist
    logfile_size = os.stat(file_name).st_size   # Get filesize in bytes
    logfile_size = logfile_size / 1024          # Convert to kbytes

    if(logfile_size >= limitsize):
        if(logsnumber > 0):
            for currentFileNum in range(logsnumber, 1, -1):
                src = file_name + "_" + str(currentFileNum - 1)
                dst = file_name + "_" + str(currentFileNum)
                if(os.path.isfile(src) == True):
                    shutil.copyfile(src, dst)
                    print("Copied: " + src + " to " + dst)      # Debug
            shutil.copyfile(file_name, file_name + "_1")
            print("Copied: " + file_name + "    to " + file_name + "_1")
        myfile = open(file_name, 'w')
        myfile.close()

