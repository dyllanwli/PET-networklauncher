const fs = require('fs')
var args = process.argv.slice(2)[0]
const { exec } = require("child_process")
// read arguments after node file name

filepath = "./network.json"
console.log(args)

let config = fs.readFileSync(filepath)
let config_data = JSON.parse(config)
var hyperledger_dir
console.log("changing volumes config...")


exec('ls ./', (err, stdout, stderr) => {
    if (err){
        console.log("[node running command error]")
        console.log(`stderr: ${stderr}`)
        return
    }
    hyperledger_dir = `${stdout}`
    console.log("volumes shouled be added:", hyperledger_dir)
})

for ( var imageName in config_data['services']){
    if(imageName == "peer" || imageName == "orderer")
        console.log("changing ", imageName, "...")
        
}
// console.log("changing " + args[1] + " to " + args[2])
// args_list = args[1].split(".")
// if (args_list.length > 1) {
//     if (args_list.length > 2){
//         config_data[args_list[0]][args_list[1]][args_list[2]] = args[2]
//     } else {
//         config_data[args_list[0]][args_list[1]] = args[2]
//     }
// } else {
//     if(config_data[args[1]] == undefined | config_data[args[1]] == "" | config_data[args[1]] == []){
//         console.log("config parameter is undefined or length less than 1. creating one...")
//     }
//     config_data[args[1]] = args[2]
// }



let result = JSON.stringify(config_data)
// fs.writeFileSync(filepath, result);