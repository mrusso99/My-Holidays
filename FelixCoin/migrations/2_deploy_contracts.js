var Token = artifacts.require("./FelixCoin.sol");

module.exports = function(deployer) {
    deployer.deploy(Token,"0xbb052D09319ACCd7C65A8cAae95fCe00d63e7eF5","FelixCoin","FELX",24444);
};