from __future__ import print_function
from collections import OrderedDict
import os
import yaml
import sys


def readYaml(fileName):
    with open("./{}".format(fileName), "w") as file:
        yamlFile = yaml.load_all(file)
        yamlD = OrderedDict()
        for i in yamlFile:
            yamlD = i
    return yamlD


def addParameter(yamlD):
    output = yamlD
    for i in yamlD:
        print(i)
    return output


def writeYaml(writeObject, outputName):
    with open("./{}".format(outputName), "w") as output:
        yaml.dump(writeObject, output, default_flow_style=False)
        print("File convert has done.")


def main():
    fileName = "./docker-compose.yml"
    outputName = fileName
    yamlD = readYaml(fileName)
    writeObject = addParameter(yamlD)
    writeYaml(writeObject, outputName)


if __name__ == "__main__":
    main()
