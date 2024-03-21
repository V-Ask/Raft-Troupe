#! /bin/python3.11
import re
import sys

if len(sys.argv) < 2:
    print("Needs file to build")
    exit(1)

src = open(sys.argv[1], 'r')
dest = open("build/" + sys.argv[1][:-4] + "_dest.trp", 'w')

print("Building:" + sys.argv[1])

for line in src.readlines():
    dest.write(line)
    match = re.search('(?<=\#IMPORT ).*\.trp', line)
    if match is None:
        continue

    with open(match.group(0), 'r') as f:
        print("Importing: " + match.group(0))
        for li in f.readlines():
            dest.write(li)

    dest.write("(* END OF " + match.group(0) + " *)\n")

src.close()
dest.close()
