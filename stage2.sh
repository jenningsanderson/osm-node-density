#!/usr/bin/python3

import sys

inRoot = sys.argv[1]
base   = sys.argv[2]


print(inRoot, base)

for x in list(range(int(base)):
	print(x)
	os.system("node --max_old_space_size=32000 ./code/downscale.js {0} > {1}".format(inRoot+str(x)+".txt",inRoot+(str(x-1)+".txt")
