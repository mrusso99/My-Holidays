pragma solidity >=0.4.25 <0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/FelixCoin.sol";

contract TestFelixCoin {

  function testInitialBalanceUsingDeployedContract() public {
    FelixCoin meta = FelixCoin(DeployedAddresses.MetaCoin());

    uint expected = 10000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }

  function testInitialBalanceWithNewMetaCoin() public {
    FelixCoin felix = new FelixCoin();

    uint expected = 10000;

    Assert.equal(felix.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }

}
