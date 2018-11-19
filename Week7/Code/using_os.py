#!/usr/bin/env python3
def main(argv=[]):
    """

    Using OS practical

    """


    __author__ = "Hannah O'Sullivan (h.osullivan18@imperial.ac.uk)"
    __appname__ = "Using os practical"
    __version__ = "0.0.1"
    __date__ = "November 2018"
    __license__ = "I do not have one"


    # Use the subprocess.os module to get a list of files and  directories
    # in your ubuntu home directory

    # Hint: look in subprocess.os and/or subprocess.os.path and/or
    # subprocess.os.walk for helpful functions

    import subprocess
    import re

    #################################

    # Get the user's home directory.
    home = subprocess.os.path.expanduser("~")

    # Use a for loop to walk through the home directory.
    def GetFiles():
        files = []
        for(dir, subdir, files) in subprocess.os.walk(home):
            files += [i for i in subdir if re.match(r"\w*", i) !=None]
            files += [i for i in files if re.match(r"\w*", i) !=None]
        return files
    files()
    len(files)
    print(files)

    # Get files and directories in your home/ that start with an
    # upper case 'C'
    def GetCFiles():
        cfiles = []
        for(dir, subdir, files) in subprocess.os.walk(home):
            cfiles += [i for i in subdir if re.match(r"^C\w*", i) !=None]
            cfiles += [i for i in files if re.match(r"^C\w*", i) !=None]
        return cfiles
    cfiles()
    len(cfiles)
    print(cfiles)

    #################################
    # Get files and directories in your home/ that start with either an
    # upper or lower case 'C'

    # Type your code here:

    def GetCcFiles():
        Ccfiles = []
        for(dir, subdir, files) in subprocess.os.walk(home):
            Ccfiles += [i for i in subdir if re.match(r"^[Cc]\w*", i) !=None]
            Ccfiles += [i for i in files if re.match(r"^[Cc]\w*", i) !=None]
        return Ccfiles
    Ccfiles()
    len(cfiles)
    print(cfiles)

    #################################
    # Get only directories in your home/ that start with either an upper or
    #~lower case 'C'

    # Type your code here:
    def GetCDirFiles():
        cdirffiles = []
        for(dir, subdir, files) in subprocess.os.walk(home):
            Dircfiles += [i for i in subdir if re.match(r"^[Cc]\w*", i) !=None]
        return cdirfiles
    cdirfiles()
    len(cdirfiles)
    print(cdirfiles)

if __name__== "__main__":
    import sys
    main(sys.argv)
