pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/PlazaToken.sol";

contract TestPlaza {

  function testInitialBalanceUsingDeployedContract() public {
    PlazaToken plaza = PlazaToken(DeployedAddresses.PlazaToken());

    uint expected = 0;

    Assert.equal(plaza.balanceOf(tx.origin), expected, "Owner should have 0 PLAZA initially");
  }

  function testInitialBalanceWithNewPlaza() public {
    PlazaToken plaza = new PlazaToken();

    uint expected = 0;

    Assert.equal(plaza.balanceOf(tx.origin), expected, "Owner should have 0 PLAZA initially");
  }

}
