import "ds-auth/auth.sol";
import "erc20/erc20.sol";

contract DSVault is DSAuth {
    function transfer(
        ERC20 token, address dst, uint x
    ) auth returns (bool) {
        return token.transfer(dst, x);
    }

    function transferFrom(
        ERC20 token, address src, address dst, uint x
    ) auth returns (bool) {
        return token.transferFrom(src, dst, x);
    }
}
