// vault.t.sol -- tests for vault.sol and multivault.sol

// Copyright (C) 2017  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity >0.4.23;

import "ds-test/test.sol";
import "erc20/erc20.sol";

import "./multivault.sol";

contract DSMultiVaultTest is DSTest {
    function testVault() public {
        FakeToken token = new FakeToken();
        address vault1 = address(new DSMultiVault());
        address vault2 = address(new DSMultiVault());

        token.transfer(address(vault1), 100);
        assertEq(token.balances(address(vault1)), 100);
        assertEq(token.balances(address(this)), -100);
        DSMultiVault(vault1).push(ERC20(address(token)), address(vault2), 20);
        assertEq(token.balances(vault1), 80);
        assertEq(token.balances(vault2), 20);
        DSMultiVault(vault1).pull(ERC20(address(token)), address(vault2), 5);
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
