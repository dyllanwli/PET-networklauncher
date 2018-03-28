from __future__ import print_function
import sys
import yaml
from subprocess import check_output

arg = sys.argv[1:]
# golbel parameter
fileName = "docker-compose.yml"
path = arg[0]

def readYaml(fileName):
    with open("./{}".format(fileName), "r") as file:
        yamlFile = dict()
        for i in yaml.load_all(file):
            yamlFile = i
    return yamlFile


# def addParameter(Parameter):
    

def checkYaml(fileName, imageList):
    output = []
    check_image = False
    # use to check whether the line is under the image
    with open("./{}".format(fileName),"r") as file:
        for line in file.readlines():
            line = line.replace("\n","")
            output.append(line)
            if line != "":
                if line.strip() in imageList or check_image == True:
                    if line.strip() in imageList:
                        imageName = imageList.index(line.strip())
                    check_image = True
                    if line.find("volumes") > -1:
                        # you can set arguments to modify
                        print("Change {} arugments ... ".format(imageList[imageName]))
                        add_arg = "      - /data/hyperledger/{}/var/hyperledger/production".format(imageList[imageName])
                        output.append(add_arg)
                    if line.find("container_name:") > -1 :
                        check_image = False
            # print("en loops")
    return output
                    

def readContainer(yamlFile):
    imageList = []
    for i in yamlFile:
        for imageName in yamlFile[i]:
            if imageName.find("orderer") > -1 or imageName.find("peer") > -1:
                print("creating directory",imageName)
                imageList.append(imageName+":")
                # add : to suit the yaml file name
                if not path == "test":
                    check_output("mkdir {}/{}".format(path,imageName), shell=True)
    return imageList
                

def writeYaml(outputFileName, outputData):
    with open("./{}".format(outputFileName),"r+") as file:
        for i in outputData:
            file.write(i+"\n")
    print("File has been written...")

def main():
    yamlFile = readYaml(fileName)
    imageList = readContainer(yamlFile)
    output = checkYaml(fileName, imageList)
    writeYaml(fileName, output)



if __name__ == "__main__":
    main()
