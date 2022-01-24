var Nft = artifacts.require("./SelfCheckIn.sol");

module.exports = function(deployer) {
    deployer.deploy(Nft);
};
