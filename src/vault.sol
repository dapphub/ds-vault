/*
   Copyright 2016 Nexus Development, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

pragma solidity ^0.4.8;

import "ds-token/token.sol";

contract DSVault is DSAuth {
    ERC20  public  token;

    function swap(ERC20 token_) auth {
        token = token_;
    }

    function push(address dst, uint x) auth returns (bool) {
        return token.transfer(dst, x);
    }
    function pull(address src, uint x) auth returns (bool) {
        return token.transferFrom(src, this, x);
    }

    function mint(uint x) auth returns (bool) {
        return DSToken(token).mint(x);
    }
    function burn(uint x) auth returns (bool) {
        return DSToken(token).burn(x);
    }
}



