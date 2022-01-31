var Token = artifacts.require("./FelixCoin.sol");

module.exports = function(deployer) {
    deployer.deploy(Token,"0x87c81230BA0f714cB638168DF5227db3437468c8","FelixCoin","FELX",24444);
};
