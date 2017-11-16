<h2>DSVault
  <small class="text-muted">
    <a href="https://github.com/dapphub/ds-vault"><span class="fa fa-github"></span></a>
  </small>
</h2>

_DSAuth-protected ERC20 token vault_
  
A vault is useful any time you need to segregate token holdings into several 
distinct buckets, or when you want to set up a shared account, perhaps owned by
a [ds-multisig](https://dapp.tools/dappsys/ds-multisig).

A `DSMultiVault` is able to hold any number of different ERC20 tokens.

A `DSVault` is bound to a single token. It is useful as a handle on the token 
that the system can pass around without also needing to transfer the tokens 
themselves, or passing a Multivault/Token pair.

Vaults are protected by [ds-auth](https://dapp.tools/dappsys/ds-auth.html) 
which means they support sophisticated access control out of the box.

Whoever owns or controls a `DSVault` can tell it to perform token operations, 
such as transferring X amount of token Y to account Z, or even(provided the 
vault has the necessary approval) transferring X amount of token Y from account 
W to account Z.

Anyone is free to make deposits to a vault by simply transferring tokens 
directly into it using the a transfer function. The owner of a vault can also 
ask the vault to perform the transfer.

Vaults are very staightforward to understand and think about, and can be a 
useful building block in many different kinds of applications.
