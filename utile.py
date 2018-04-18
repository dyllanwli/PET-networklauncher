from __future__ import print_function
import sys
import os

def replace_ca(fileName,marks,token):
    result = []
    with open("./{}".format(fileName),"r") as file:
        for line in file.readlines():
            # print(line)
            for mark in marks:
                if line.find(mark) > -1:
                    token_index = line.rfind("/") + 1
                    line = line[:token_index] + token + "\n"
                    print(line)
            result.append(line)
    with open("./{}".format(fileName),"w") as file:
        for i in result:
            file.write(i)


dir = "./docker-compose.yml"
for i in os.listdir(dir):
    if i.endswith(".yml"):
        fileName = i
token = "0000"
marks = ["FABRIC_CA_SERVER_TLS_KEYFILE","--ca.certfile"]
replace_ca(fileName,marks,token)