from __future__ import print_function
import os
import sys


# print(arg)
yml = []
target = ""
with open("./docker-compose.yml",'r') as file:
    for line in file.readlines():
        line = line.replace("\n","")
        yml.append(line)
        if line.find("environment") > -1:
            env = "      - GOGC=1000"
            yml.append(env)
            print("adding environment",env)
        

with open("./docker-compose.yml",'r+') as file:
    for l in yml:
        file.write(l+"\n")