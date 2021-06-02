# VCU118

## General setup
1. Install and set up Vivado 2019.1.
1. Connect board according to [xtp449-vcu118-setup-c-2019-1.pdf](example_designs/xtp449-vcu118-setup-c-2019-1.pdf).

## Built-in self-test (BIST) instructions
1. Read and follow the instructions in [xtp453-vcu118-quickstart.pdf](user_guides/xtp453-vcu118-quickstart.pdf) to complete the built-in self test (BIST).

## Built-in test (BIT) instructions
1. Read and follow the instructions in [xtp439-vcu118-bit-c-2019-1.pdf](example_designs/xtp439-vcu118-bit-c-2019-1). Note this requires Windows (skip for now).

## IBERT test instructions
1. Read and follow the instructions in [xtp440-vcu118-gt-ibert-c-2019-1.pdf](example_designs/xtp440-vcu118-gt-ibert-c-2019-1.pdf) to test transceivers. In particular, you'll need [rdf0388-vcu118-gt-ibert-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0388-vcu118-gt-ibert-c-2019-1.zip), which is easiest to get with `wget` (for some reason downloading in a browser fails consistently). See also https://blog.samtec.com/post/xilinx-blog-firefly-vcu118-fpga/.

## IP integrator instructions
1. Read and follow the instructions in [xtp441-vcu118-ipi-c-2019-1.pdf](example_designs/xtp441-vcu118-ipi-c-2019-1.pdf). In particular, you'll need [rdf0389-vcu118-ipi-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0389-vcu118-ipi-c-2019-1.zip).

## MIG instructions
1 Read and follow instructions in [xtp442-vcu118-mig-c-2019-1.pdf](example_designs/xtp442-vcu118-mig-c-2019-1.pdf). In particular, you'll need [rdf0390-vcu118-mig-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0390-vcu118-mig-c-2019-1.zip).

## `emp-fwk` 'null algo' instructions
1. Get added to `cms-tcds2-users` and `emp-fwk-users` e-groups to view GitLab repositories.
1. Install uHAL and ControlHub. Follow instructions at https://ipbus.web.cern.ch/doc/user/html/software/install/yum.html
and initialize
```bash
export PATH=/opt/cactus/bin/uhal/tools:$PATH LD_LIBRARY_PATH=/opt/cactus/lib:$LD_LIBRARY_PATH
```
1. Follow instructions at https://gitlab.cern.ch/p2-xware/firmware/emp-fwk
In particular, setup the work area
```bash
ipbb init p2fwk-work
cd p2fwk-work
ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git
ipbb add git https://gitlab.cern.ch/ttc/legacy_ttc.git -b v2.1
ipbb add git https://:@gitlab.cern.ch:8443/cms-tcds/cms-tcds2-firmware.git -b v0_1_1
ipbb add git https://gitlab.cern.ch/HPTD/tclink.git -r fda0bcf
ipbb add git https://github.com/ipbus/ipbus-firmware -b v1.9
```
Then create the 'null algo' pass-through project
```bash
ipbb proj create vivado vcu118_null_algo emp-fwk:projects/examples/vcu118 top.dep
cd proj/vcu118_null_algo
```

## Correlator layer 2 jet algo instructions
1. See https://github.com/thesps/GlobalCorrelator/tree/layer2-interleaving/emp_examples/Layer2/standalones/firmware
