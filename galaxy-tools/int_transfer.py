
# coding: utf-8

# In[16]:

import sys, os

result = {}
second = {}

with open(sys.argv[1], 'r') as infile:
    for lines in infile:
        if lines[0] == "#":
            continue
        cells = lines.lower().strip().split('\t')
        if len(cells) != 3:
            continue
        if cells[0] not in result:
            result[cells[0]] = {}
        if cells[2] not in result[cells[0]]:
            result[cells[0]][cells[2]] = []
        result[cells[0]][cells[2]].append(cells[1])

for key, value in result.items():
    for ecoli in value[sys.argv[2]]:
        second[ecoli] == value[sys.argv[3]]
        
with open(sys.argv[4], 'r') as infile:
    for lines in infile:
        cells = lines.lower().strip().split('\t')
        if cells[0] not in second:
            continue
        if cells[1] not in second:
            continue
        for tf in second[cells[0]]:
            for genes in second[cells[1]]:
                print(tf + '\t' + genes)
        

