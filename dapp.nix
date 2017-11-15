dapp: with dapp; solidityPackage {
  name = "ds-vault";
  deps = with dappsys; [ds-test ds-token];
  src = ./src;
}
