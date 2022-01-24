var Token = artifacts.require("./FelixCoin.sol");

module.exports = function(deployer) {
    deployer.deploy(Token,"0x5e2160E27916321F966795EfF63cE80be34894ba","FelixCoin","FELX",24444);
};