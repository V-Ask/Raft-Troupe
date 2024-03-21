import re
import sys

if len(sys.argv) < 2:
    print("Needs file to build")
    exit(1)

src = open(sys.argv[1], 'r')
dest = open("build/" + sys.argv[1][:-4] + "_dest.trp", 'w')

for line in src.readlines():
    dest.write(line)
    match = re.search('(?<=\#IMPORT ).*\.trp', line)
    if match is None:
        continue

    with open(match.group(0), 'r') as f:
        for l in f.readlines():
            dest.write(l)

src.close()
dest.close()
