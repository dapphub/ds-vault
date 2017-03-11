/// vault.t.sol -- tests for vault.sol and multivault.sol

// Copyright (C) 2016, 2017  Nexus Development, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-test/test.sol";
import "erc20/erc20.sol";

import "./multivault.sol";

contract DSMultiVaultTest is DSTest {
    function testVault() {
        var token = new FakeToken();
        var vault1 = new DSMultiVault();
        var vault2 = new DSMultiVault();
        token.transfer(vault1, 100);
        assertEq(token.balances(vault1), 100);
        assertEq(token.balances(this), -100);
        vault1.doTransfer(ERC20(token), vault2, 20);
        assertEq(token.balances(vault1), 80);
        assertEq(token.balances(vault2), 20);
        vault1.doTransferFrom(ERC20(token), vault2, this, 5);
        assertEq(token.balances(vault1), 80);
        assertEq(token.balances(vault2), 15);
        assertEq(token.balances(this), -95);
    }
}

contract FakeToken {
    mapping (address => int) public balances;
    function transfer(address dst, uint x) returns (bool) {
        this.transferFrom(msg.sender, dst, x);
    }
    function transferFrom(address src, address dst, uint x) returns (bool) {
        balances[src] -= int(x);
        balances[dst] += int(x);
    }
}
