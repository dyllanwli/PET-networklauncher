const fs = require('fs')
// var args = process.argv.slice(2)[0]
// const { exec } = require("child_process")
// read arguments after node file name

filepath = "../network.json"

// console.log(args)

let config = fs.readFileSync(filepath)
let config_data = JSON.parse(config)
var hyperledger_dir
console.log("Loading %s config >>>", filepath)





for ( var imageName in config_data['services']){
    // console.log(config_data['services'][imageName])
    console.log(imageName)
    for (var options in config_data['services'][imageName]){
    }
}

// exec the child process
// exec('ls ./', (err, stdout, stderr) => {
//     if (err){
//         console.log("[node running command error]")
//         console.log(`stderr: ${stderr}`)
//         return
//     }
//     hyperledger_dir = `${stdout}`
//     console.log("volumes shouled be added:", hyperledger_dir)
// })

// run command below to test the js
// export HOSTCONFIG_NETWORKMODE=test
// node json2yml.js network.json 2 3 0 0 2 couchdb 2



let result = JSON.stringify(config_data)
// fs.writeFileSync(filepath, result)