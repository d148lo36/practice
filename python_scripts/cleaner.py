#!/bin/python3

import os, time
from queue import Empty

DAYS = 5        # Maximal age of file to stay, older will be deleted
FOLDERS = [
    "/home/user/exaple_folder_1",
    "/home/user/exaple_folder_2",
    "/home/user/exaple_folder_3"
]
TOTAL_DELETED_SIZE = 0      # Total deleted size of all files
TOTAL_DELETED_FILE = 0      # Total deleted files
TOTAL_DELETED_DIRS = 0      # Total deleted empty folders

nowTime = time.time()   # Get current time in second
ageTime = nowTime - 60 * 60 * 24 * DAYS # Time minus DAYS in second

def delete_old_files(folder):
    """Delete files older than x DAYS"""
    global TOTAL_DELETED_FILE
    global TOTAL_DELETED_SIZE
    for path, dirs, files in os.walk(folder):
        for file in files:
            fileName = os.path.join(path, file)     # get full PATH to file
            fileTime = os.path.getmtime(fileName)   # getmtime modification file
            if fileTime < ageTime:
                sizeFile = os.path.getsize(fileName)
                TOTAL_DELETED_SIZE += sizeFile      # Count SUM of all free space
                TOTAL_DELETED_FILE += 1             # Count number of deleted files
                print("Deleting file: " + str(fileName))    # Worked faster without this line
                os.remove(fileName)                 # Delete file

def delete_empty_dir(folder):
    global TOTAL_DELETED_DIRS
    empty_folders_in_this_run = 0
    for path, dirs, files in os.walk(folder):
        if (not dirs) and (not files):
            TOTAL_DELETED_DIRS += 1
            empty_folders_in_this_run += 1
            print("Deleting empty dir: " + str(path))
            os.rmdir(path)
    if empty_folders_in_this_run > 0:
        delete_empty_dir(folder)

#=======================MAIN===============================
starttime = time.asctime()

for folder in FOLDERS:
    delete_old_files(folder)    # Delete old files
    delete_empty_dir(folder)    # Delete empty folders

finishtime = time.asctime()

print("------------------------------------------------------------------")
print("Start time: " + str(starttime))
print("Total deleted size: " + str(int(TOTAL_DELETED_SIZE / 1024 / 1024)) + "MB")    # Print total deleted size in MB
print("Total deleted files: " + str(TOTAL_DELETED_FILE))
print("Total deleted empty folders: " + str(TOTAL_DELETED_DIRS))
print("Finish time: " + str(finishtime))
print("------------------------------------------------------------------")