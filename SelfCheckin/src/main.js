const Web3 = require('web3');
var fs = require('fs');

const web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));


var address = "0xE3C849E01b43053Ec15D0B0e6E7167408B310ff2";
var privateKey= "749b6ebedc9c4074ead84ad79a0f6799d68506b4a3c8ff3fffc2fb9cee5ab810";

var contractAddress= "0x21580ba1dEaAC9a30CC4644d0547578beE7A6C60";


web3.eth.accounts.privateKeyToAccount(privateKey);

var abi = JSON.parse(fs.readFileSync("abi.json"));

const contract= new web3.eth.Contract(abi, contractAddress);


contract.methods.authenticateUsers("0x35e42433DF14083348d972aa0f7788422Ac9E589", "").send({from: address, gas: 6721975}).then(function(receipt){
    console.log(receipt.events.Transfer.returnValues['tokenId'])
});
