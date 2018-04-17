#!/bin/bash
#
# bring up network 

# test case
#  --sysctl net.ipv6.conf.all.disable_ipv6=1 
docker run -it --rm --network fabric_ov --name alp0 alpine ash 
docker run -it --rm --network fabric_ov --name alp1 alpine ash 
docker run -it --rm --network fabric_ov --name alp2 alpine ash 
docker run -it --rm --network fabric_ov --name alp3 alpine ash 
# service test command
docker service create --network fabric_ov --replicas 1 --name ser1 --constraint "node.hostname==iZwz9gd8k08kdmtd4qg7rhZ" alpine sleep 1h
docker service create --network fabric_ov --replicas 1 --name ser2 --constraint "node.hostname==iZwz9gd8k08kdmtd4qg7riZ" alpine sleep 1h
docker service create --network fabric_ov --replicas 1 --name ser3 --constraint "node.hostname==blockchainmonion153" alpine sleep 1h
docker service create --network fabric_ov --replicas 1 --name ser4 --constraint "node.hostname==blockchainmaster151" alpine sleep 1h
#
# 
#  ATTEHTION
#  To deploy the network on worker node, you should create a serivce on worker node first, than create the network.
#  
# 


# on machine1
# rm -rf /tmp/*
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images | grep dev | awk '{print $3}')
yes | docker network prune
docker network create --attachable --driver overlay fabric_ov --subnet 10.10.0.0/24
# prune the network
# docker-compose -f machine-1.yml up -d
docker-compose -f machine-1.links.yml up -d
# docker-compose -f machine-1.1.yml up -d
# docker-compose -f machine-2.1.yml up -d
# docker-compose -f machine-1.151.yml up -d
# docker-compose -f machine-2.153.yml up -d



docker network disconnect nl_default ca0
docker network disconnect nl_default orderer0.example.com
docker network disconnect nl_default orderer1.example.com
docker network disconnect nl_default orderer2.example.com
docker network disconnect nl_default peer0.org1.example.com
docker network disconnect nl_default peer1.org1.example.com


docker network connect fabric_ov ca0
docker network connect fabric_ov orderer0.example.com
docker network connect fabric_ov orderer1.example.com
docker network connect fabric_ov orderer2.example.com
docker network connect fabric_ov peer0.org1.example.com
docker network connect fabric_ov peer1.org1.example.com
yes | docker network prune

# TX=/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/testorgschannel1.tx
# CERT_DIR=/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
# docker exec -it peer0.org1.example.com peer channel create -o orderer0.example.com:7050 -c testorgschannel1 -f $TX --tls true --cafile $CERT_DIR


# on machine2
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images | grep dev | awk '{print $3}')
yes | docker network prune
# docker-compose -f machine-2.yml up -d 
docker-compose -f machine-2.links.yml up -d 
docker network disconnect nl_default ca1
docker network disconnect nl_default peer0.org2.example.com
docker network disconnect nl_default peer1.org2.example.com

docker network connect fabric_ov ca1
docker network connect fabric_ov peer0.org2.example.com
docker network connect fabric_ov peer1.org2.example.com
yes | docker network prune
# docker exec -it peer0.org2.example.com peer channel create -o orderer0.example.com:7050 -c testorgschannel1 -f /opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/testorgschannel1.tx
