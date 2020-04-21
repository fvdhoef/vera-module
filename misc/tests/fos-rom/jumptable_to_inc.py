#!/usr/bin/env python3

with open('jumptable.s', 'r') as f:
    lines = f.readlines()

labels = []
longest_label = 0

for line in lines:
    line = line.strip()
    if line.startswith('jmp'):
        lbl = line.split()[1]
        longest_label = max(longest_label, len(lbl))
        if len(lbl) > longest_label:
            longest_label = len(lbl)
        labels.append(lbl)

fmt = '{:' + str(longest_label) + 's} = ${:04X}\n'

with open('jumptable.inc', 'w') as f:
    addr = 0xFF00

    for lbl in labels:
        f.write(fmt.format(lbl, addr))
        addr = addr + 3
