from __future__ import print_function
from collections import OrderedDict
import os
import yaml
import sys


def readYaml(fileName):
    with open("./{}".format(fileName), "r") as file:
        yamlFile = yaml.load_all(file)
        yamlD = OrderedDict()
        for l1 in yamlFile:
            for item in l1:
                print(item)
            yamlD = l1
    return yamlD


def addParameter(yamlD):
    output = yamlD
    for i in yamlD:
        print(i)
    return output


def writeYaml(writeObject, outputName):
    print("writing yaml file...")
    with open("./{}".format(outputName), "r") as output:
        for data in writeObject:
            print(data)
            # if type(writeObject[data]) == type(dict()):
            for i in writeObject[data]:
                print(i)
                if type(i) == type(dict()):
                    data = OrderedDict(i)
                    print(data)
            # yaml.dump(data, output, default_flow_style=False)
        print("File convert has done.")


def main():
    fileName = "./docker-compose.yml"
    outputName = fileName
    yamlD = readYaml(fileName)
    writeObject = addParameter(yamlD)
    writeYaml(writeObject, outputName)


if __name__ == "__main__":
    main()
