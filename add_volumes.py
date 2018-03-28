from __future__ import print_function
import sys
import yaml
from subprocess import check_output

arg = sys.argv[1:]
# golbel parameter
fileName = "./docker-compose.yml"
path = arg[0]

def readYaml(fileName):
    with open("./{}".format(fileName), "r") as file:
        yamlFile = dict()
        for i in yaml.load_all(file):
            yamlFile = i
    return yamlFile

def readContainer(yamlFile):
    for i in yamlFile:
        for imageName in yamlFile[i]:
            if imageName.find("orderer") > -1 or imageName.find("peer") > -1:
                print("creating directory",imageName)
                check_output("mkdir {}/{}".format(path,imageName), shell=True)
                

def main():
    yamlFile = readYaml(fileName)
    readContainer(yamlFile)


if __name__ == "__main__":
    main()
