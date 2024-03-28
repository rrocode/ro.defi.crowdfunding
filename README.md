## ro.defi.crowdfunding

**Very simple solidity based contract for funding**

**Install chainlink on local**

```shell
$ [%user%]/.foundry/bin/forge install smartcontractkit/chainlink-brownie-contracts@0.8.0 --no-commit
```

**Build**

```shell
$ [%user%]/.foundry/bin/forge build
```

**Run tests**

```shell
$ [%user%]/.foundry/bin/forge test
```

```shell
$ [%user%]/.foundry/bin/forge test --match-test [testname] -vvv
```

**Deploy**

```shell
$ [%user%]/.foundry/bin/forge script script/DeployFundMe.s.sol
```
