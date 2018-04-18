# docker network create --subnet 10.10.0.0/24 --attachable --driver overlay fabric_ov

docker run -it -d --network="fabric_ov" \
--name="ca0" \
-e GODEBUG=netdns=go \
-e FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server \
-e FABRIC_CA_SERVER_CA_NAME=ca-org1 \
-e FABRIC_CA_SERVER_TLS_ENABLED=true \
-e FABRIC_CA_SERVER_TLS_CERTFILE=/etc/hyperledger/fabric-ca-server-config/ca.org1.example.com-cert.pem \
-e FABRIC_CA_SERVER_TLS_KEYFILE=/etc/hyperledger/fabric-ca-server-config/263a0a0a9008d7adcceea7d6f60e1763d59653e79123cb9b9932bc8eaaf2da82_sk \
-p 7054:7054 \
-v /opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools/cryptogen/crypto-config/peerOrganizations/org1.example.com/ca/:/etc/hyperledger/fabric-ca-server-config \
hyperledger/fabric-ca \
sh -c 'fabric-ca-server start --ca.certfile /etc/hyperledger/fabric-ca-server-config/ca.org1.example.com-cert.pem --ca.keyfile /etc/hyperledger/fabric-ca-server-config/263a0a0a9008d7adcceea7d6f60e1763d59653e79123cb9b9932bc8eaaf2da82_sk -b admin:adminpw -d'

docker run -it -d --network="fabric_ov" \
--name="orderer0.example.com" \
-e GODEBUG=netdns=go \
-e ORDERER_GENERAL_LOGLEVEL=DEBUG \
-e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0 \
-e ORDERER_GENERAL_GENESISMETHOD=file \
-e ORDERER_GENERAL_GENESISFILE=/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/orderer.block \
-e ORDERER_GENERAL_LOCALMSPID=OrdererOrg \
-e ORDERER_GENERAL_LOCALMSPDIR=/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp \
-e ORDERER_GENERAL_TLS_ENABLED=true \
-e ORDERER_GENERAL_TLS_PRIVATEKEY=/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls/server.key \
-e ORDERER_GENERAL_TLS_CERTIFICATE=/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls/server.crt \
-e ORDERER_GENERAL_TLS_ROOTCAS=[/opt/hyperledger/fabric/msp/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls/ca.crt] \
-w /opt/gopath/src/github.com/hyperledger/fabric \
-v /opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools/cryptogen/crypto-config:/opt/hyperledger/fabric/msp/crypto-config \
-p 5005:7050 \
hyperledger/fabric-orderer \
orderer 

docker run -it -d --network="fabric_ov" \
--name="peer0.org1.example.com" \
-e GODEBUG=netdns=go \
-e GOGC=200 \
-e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
-e CORE_LOGGING_LEVEL=DEBUG \
-e CORE_PEER_ENDORSER_ENABLED=true \
-e CORE_PEER_PROFILE_ENABLED=true \
-e CORE_PEER_GOSSIP_USELEADERELECTION=true \
-e CORE_PEER_GOSSIP_ORGLEADER=false \
-e CORE_PEER_ID=peer0.org1.example.com \
-e CORE_PEER_MSPCONFIGPATH=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp \
-e CORE_PEER_LOCALMSPID=PeerOrg1 \
-e CORE_PEER_ADDRESS=peer0.org1.example.com:7051 \
-e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org1.example.com:7051 \
-e CORE_PEER_TLS_ENABLED=true \
-e CORE_PEER_TLS_KEY_FILE=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key \
-e CORE_PEER_TLS_CERT_FILE=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt \
-v /var/run/:/host/var/run/ \
-v /opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools/cryptogen/crypto-config:/opt/hyperledger/fabric/msp/crypto-config \
-p 7061:7051 \
-p 6051:7053 \
--link orderer0.example.com:orderer0.example.com \
-w /opt/gopath/src/github.com/hyperledger/fabric/peer \
hyperledger/fabric-peer \
peer node start



docker run -it -d --network="fabric_ov" \
--name="peer1.org1.example.com" \
-e GODEBUG=netdns=go \
-e GOGC=200 \
-e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
-e CORE_LOGGING_LEVEL=DEBUG \
-e CORE_PEER_ENDORSER_ENABLED=true \
-e CORE_PEER_PROFILE_ENABLED=true \
-e CORE_PEER_GOSSIP_USELEADERELECTION=true \
-e CORE_PEER_GOSSIP_ORGLEADER=false \
-e CORE_PEER_ID=peer1.org1.example.com \
-e CORE_PEER_MSPCONFIGPATH=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp \
-e CORE_PEER_LOCALMSPID=PeerOrg1 \
-e CORE_PEER_ADDRESS=peer1.org1.example.com:7051 \
-e CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer1.org1.example.com:7051 \
-e CORE_PEER_TLS_ENABLED=true \
-e CORE_PEER_TLS_KEY_FILE=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key \
-e CORE_PEER_TLS_CERT_FILE=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/hyperledger/fabric/msp/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt \
-v /var/run/:/host/var/run/ \
-v /opt/go/src/github.com/hyperledger/fabric-test/fabric/common/tools/cryptogen/crypto-config:/opt/hyperledger/fabric/msp/crypto-config \
-p 7062:7051 \
-p 6052:7053 \
--link orderer0.example.com:orderer0.example.com \
--link peer0.org1.example.com:peer0.org1.example.com \
-w /opt/gopath/src/github.com/hyperledger/fabric/peer \
hyperledger/fabric-peer \
peer node start