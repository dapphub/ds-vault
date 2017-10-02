/// vault.t.sol -- tests for vault.sol and multivault.sol

// Copyright (C) 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.13;

import "ds-test/test.sol";
import "erc20/erc20.sol";

import "./multivault.sol";

contract DSMultiVaultTest is DSTest {
    function testVault() public {
        var token = new FakeToken();
        var vault1 = new DSMultiVault();
        var vault2 = new DSMultiVault();
        token.transfer(vault1, 100);
        assertEq(token.balances(vault1), 100);
        assertEq(token.balances(this), -100);
        vault1.push(ERC20(token), vault2, 20);
        assertEq(token.balances(vault1), 80);
        assertEq(token.balances(vault2), 20);
        vault1.pull(ERC20(token), vault2, 5);
        assertEq(token.balances(vault1), 85);
        assertEq(token.balances(vault2), 15);
    }
}

contract FakeToken {
    mapping (address => int) public balances;
    function transfer(address dst, uint x) public returns (bool) {
        this.transferFrom(msg.sender, dst, x);
        return true;
    }
    function transferFrom(address src, address dst, uint x)
        public
        returns (bool)
    {
        balances[src] -= int(x);
        balances[dst] += int(x);
        return true;
    }
}
