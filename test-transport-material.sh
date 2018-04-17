#!/bin/bash

# transport crypto-config or channel file to other host

HOST1=39.108.167.205
HOST2=120.79.163.88

NL_DIR=/opt/go/src/github.com/hyperledger/fabric-test/tools/NL
CRYPTO_CONFIG_DIR=/opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools
# in this test, running create network on host1 and transport file to host2

echo "removing $HOST2 cryptogen"
ssh root@$HOST2 -i ~/.ssh/id_rsa "cd $CRYPTO_CONFIG_DIR; rm -rf cryptogen"
cd $CRYPTO_CONFIG_DIR
echo "transporting $CRYPTO_CONFIG_DIR to $HOST2"
cd /opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools
scp -i ~/.ssh/id_rsa -r cryptogen root@39.108.167.205:/opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools
scp -i ~/.ssh/id_rsa -r cryptogen root@120.79.163.88:/opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools
scp -i ~/.ssh/id_rsa -r root@39.108.167.205:/opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools/cryptogen ./
scp -i ~/.ssh/id_rsa -r root@172.16.50.151:/opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools/cryptogen ./