// multivault.sol -- vault for holding different kinds of ERC20 tokens

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

import "ds-auth/auth.sol";
import "ds-token/token.sol";

contract DSMultiVault is DSAuth {
    function push(ERC20 token, address dst, uint wad) public auth {
        require(token.transfer(dst, wad), "ds-vault-token-transfer-failed");
    }
    function pull(ERC20 token, address src, uint wad) public auth {
        require(token.transferFrom(src, address(this), wad), "ds-vault-token-transfer-failed");
    }

    function push(ERC20 token, address dst) public {
        push(token, dst, token.balanceOf(address(this)));
    }
    function pull(ERC20 token, address src) public {
        pull(token, src, token.balanceOf(src));
    }

    function mint(DSToken token, uint wad) public auth {
        token.mint(wad);
    }
    function burn(DSToken token, uint wad) public auth {
        token.burn(wad);
    }
    function mint(DSToken token, address guy, uint wad) public auth {
        token.mint(guy, wad);
    }
    function burn(DSToken token, address guy, uint wad) public auth {
        token.burn(guy, wad);
    }

    function burn(DSToken token) public auth {
        token.burn(token.balanceOf(address(this)));
    }
}
