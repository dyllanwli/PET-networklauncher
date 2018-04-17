package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"

	"gopkg.in/yaml.v2"
)

var overlayNetwork = "hyperledger-ov"

func main() {
	var domain string
	var numOrgs, numPeer, numOrderer, numKafka, numZookeeper int

	flag.StringVar(&domain, "domain", "example.com", "default example.com")
	flag.IntVar(&numOrgs, "org", 2, "orgs default 2")
	flag.IntVar(&numPeer, "peer", 2, "peers default 2")
	flag.IntVar(&numOrderer, "orderer", 3, "orderer default 3")
	flag.IntVar(&numKafka, "kafka", 0, "kafka default 0")
	flag.IntVar(&numZookeeper, "zk", 0, "zookeeper default 0")

	flag.Parse()

	// Generate crypto-config.yaml
	crypto, err := GenCrypto(domain, numOrgs, numPeer, numOrderer)
	fmt.Println("Generating YAML file from crypto config....")
	cryptoYAML, err := yaml.Marshal(&crypto)
	check(err)

	// Generate configtx.yaml
	configtx, err := GenConfigtx(domain, numOrgs, numOrderer, numKafka)
	check(err)
	fmt.Println("Generating YAML file from configtx config....")
	configtxYAML, err := yaml.Marshal(&configtx)
	check(err)

	// Write files to $PWD
	pwd, err := filepath.Abs(filepath.Dir(os.Args[0]))
	check(err)
	err = ioutil.WriteFile("crypto-config.yaml", []byte(cryptoYAML), 0644)
	check(err)
	err = ioutil.WriteFile("configtx.yaml", []byte(configtxYAML), 0644)
	check(err)

	// Genearte docker composer file
	var composeOutput *DockerCompose
	var serviceList []string

	if numOrderer == 1 {
		serviceList = make([]string, 5)
		serviceList = []string{"orderer", "ca", "couchdb", "peer", "cli"}
	} else {
		serviceList = make([]string, 7)
		serviceList = []string{"zookeeper", "kafka", "orderer", "ca", "couchdb", "peer", "cli"}
	}

	for _, service := range serviceList {
		switch service {
		case "peer":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, numPeer, numOrgs)
			check(err)
		case "zookeeper":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, numZookeeper)
			check(err)
		case "kafka":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, numKafka)
			check(err)
		case "orderer":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, numOrderer)
			check(err)
		case "ca":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, numOrgs)
			check(err)
		case "couchdb":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, numPeer, numOrgs)
			check(err)
		case "cli":
			composeOutput, err = GenDockerCompose(service, domain, overlayNetwork, 1)
			check(err)
		default:
			panic("Service Name isn't specified!!!")
		}
		fmt.Println("Generating Docker Compose file for " + service + "....")
		composeYAML, err := yaml.Marshal(composeOutput)
		check(err)
		err = ioutil.WriteFile("docker-compose-"+service+".yaml", []byte(composeYAML), 0644)
		check(err)
	}

	fmt.Println("Output files are located on " + pwd)
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}
