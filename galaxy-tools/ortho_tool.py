import sys

#sys.argv[1] : input file
#sys.argv[2] : output file

def main():
    with open(sys.argv[1]) as input_file:
       with open(sys.argv[2], "w") as output_file:
           input_file.readline()
           for line in input_file:
               line = line.strip().split("\t")
               if line[1]!= "":
                   ecoli_genes = line[1].split(",")
                   for gene in ecoli_genes:
                       genes = gene.split("|")
                       genename_species = genes[2].split("_")
                       output_file.write("%s\t%s\t%s\n" % (line[0], genename_species[0], genename_species[1]))

               if line[2] != "":
                   listeria_genes = line[2].split(",")
                   for gene in listeria_genes:
                       genes = gene.split("|")
                       print(genes)
                       genename_species = genes[2].split("_")
                       output_file.write("%s\t%s\t%s\n" % (line[0], genename_species[0], genename_species[1]))
if __name__ == '__main__':
    main()
