// vault.sol -- vault for holding a single kind of ERC20 tokens

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

pragma solidity ^0.4.13;

import "./multivault.sol";

contract DSVault is DSMultiVault {
    ERC20  public  token;

    function swap(ERC20 token_) public auth {
        token = token_;
    }

    function push(address dst, uint wad) public {
        push(token, dst, wad);
    }
    function pull(address src, uint wad) public {
        pull(token, src, wad);
    }

    function push(address dst) public {
        push(token, dst);
    }
    function pull(address src) public {
        pull(token, src);
    }

    function mint(uint wad) public {
        super.mint(DSToken(token), wad);
    }
    function burn(uint wad) public {
        super.burn(DSToken(token), wad);
    }

    function burn() public {
        burn(DSToken(token));
    }
}
