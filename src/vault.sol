/// vault.sol -- vault for holding a single kind of ERC20 tokens

// Copyright (C) 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

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
