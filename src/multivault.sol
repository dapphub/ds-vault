/// multivault.sol -- vault for holding different kinds of ERC20 tokens

// Copyright (C) 2016, 2017  Nexus Development, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-auth/auth.sol";
import "ds-token/token.sol";

contract DSMultiVault is DSAuth {
    function push(ERC20 token, address dst, uint wad) auth {
        assert(token.transfer(dst, wad));
    }
    function pull(ERC20 token, address src, uint wad) auth {
        assert(token.transferFrom(src, this, wad));
    }

    function push(ERC20 token, address dst) {
        push(token, dst, token.balanceOf(this));
    }
    function pull(ERC20 token, address src) {
        pull(token, src, token.balanceOf(src));
    }

    function mint(DSToken token, uint wad) auth {
        token.mint(wad);
    }
    function burn(DSToken token, uint wad) auth {
        token.burn(wad);
    }

    function assert(bool x) {
        if (!x) throw;
    }
}
