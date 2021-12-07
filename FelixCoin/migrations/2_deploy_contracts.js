var Token = artifacts.require("./FelixCoin.sol");

module.exports = function(deployer) {
    deployer.deploy(Token,"0x638930301B4f35b4cDF6bEA6Ae27C3Fcf98A9d4B","FelixCoin","FELX",24444);
};