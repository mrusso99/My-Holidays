const FelixCoin = artifacts.require("FelixCoin");

module.exports = function(deployer) {
  deployer.deploy(FelixCoin);
};
