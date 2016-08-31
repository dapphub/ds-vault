import "dapple/test.sol";
import "erc20/erc20.sol";
import "vault.sol";

contract DSVaultTest is Test {
    function testVault() {
        var token = new FakeToken();
        var vault1 = new DSVault();
        var vault2 = new DSVault();
        token.transfer(vault1, 100);
        assertEq(token.balances(vault1), 100);
        assertEq(token.balances(this), -100);
        vault1.transfer(ERC20(token), vault2, 20);
        assertEq(token.balances(vault1), 80);
        assertEq(token.balances(vault2), 20);
        vault1.transferFrom(ERC20(token), vault2, this, 5);
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
