# for ZYBO Z7

## References

- blkdevmmio - https://e-trees.jp/wp/?p=1289
- nicdevmmio - https://e-trees.jp/wp/?p=1339

## Pre-requirements

- Diglent ZYBO Z7-20
- Ubuntu 18.04
- Vivado 2021.2.1
- Petalinux 2021.2

## Building HW

To build blkdevmmio, execute as the following.

```
$ vivado -mode batch -source ./create_blkdevmmio.tcl
```

When building nicdevmmio, use `create_nicdevmmio.tcl` instead of `create_blkdevmmio.tcl`.

## Building Linux and Boot image

Follow [blkdevmmio](https://e-trees.jp/wp/?p=1289) and [nicdevmmio](https://e-trees.jp/wp/?p=1339), respectively.

