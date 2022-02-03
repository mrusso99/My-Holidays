var Token = artifacts.require("./FelixCoin.sol");

module.exports = function(deployer) {
    deployer.deploy(Token,"0x8c3ed7E69003f06532032C7A9EE1deB8173A85ef","FelixCoin","FELX",24444);
};