#!/bin/bash

# transport crypto-config or channel file to other host

HOST1=39.108.167.205
HOST2=120.79.163.88


CRYPTO_CONFIG_DIR=/opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools
# in this test, running create network on host1 and transport file to host2

echo "removing $HOST2 cryptogen"
ssh root@$HOST2 -i ~/.ssh/id_rsa "cd $CRYPTO_CONFIG_DIR; rm -rf cryptogen"
cd $CRYPTO_CONFIG_DIR
echo "transporting file to $HOST2"
scp -i ~/.ssh/id_rsa -r cryptogen root@${HOST2}:$CRYPTO_CONFIG_DIR