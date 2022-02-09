var Token = artifacts.require("./FelixCoin.sol");

module.exports = function(deployer) {

    deployer.deploy(Token,"0x3f1160506de1b9bD48a9328f98a16bD6bb3E497a","FelixCoin","FELX",24444);
};
