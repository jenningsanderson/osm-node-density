#!/usr/bin/python3

import sys, os


try:
    inRoot = sys.argv[1]
    base   = sys.argv[2]
except:
    print("Error, need both the input root (fullpath) and the max zoom")
    exit(1)

print(inRoot, base)

for x in list(reversed(range(int(base)+1)))[:-1]:
	print("Running for: {0} -> {1}".format(x,x-1))
	os.system("node --max_old_space_size=32000 ./code/downscale.js {0} > {1}".format(
        inRoot+str(x)+".txt", inRoot+str(x-1)+".txt"))
