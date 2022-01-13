// SPDX-License-Identifier: MIT

// Based on https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.5.1/test/examples/SimpleToken.test.js

const { expect } = require('chai');

// Import utilities from Test Helpers
const { BN, expectEvent, expectRevert, constants } = require('@openzeppelin/test-helpers');

// Load compiled artifacts
const NFT = artifacts.require("./NFT.sol");

// Start test block
contract('SelfCheckIn', function ([ creator, other ]) {


  beforeEach(async function () {
    this.token = await SimpleToken.new(creator, NAME, SYMBOL, TOTAL_SUPPLY, { from: creator });
    console.log(creator);
  });

  it('has Role', async function() {
    expect(await this.token.testingRole(creator)).to.be.equal(true);
  });

  it('retrieve returns a value previously stored', async function () {
    // Use large integer comparisons
    expect(await this.token.totalSupply()).to.be.bignumber.equal(TOTAL_SUPPLY);
  });

  it('has a name', async function () {
    expect(await this.token.name()).to.be.equal(NAME);
  });

  it('has a symbol', async function () {
    expect(await this.token.symbol()).to.be.equal(SYMBOL);
  });

  it('assigns the initial total supply to the creator', async function () {
    expect(await this.token.balanceOf(creator)).to.be.bignumber.equal(TOTAL_SUPPLY);
  });
});
