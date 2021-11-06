# VCU118

## General setup
1. Install and setup Vivado 2019.1 on a machine for compiling firmware (like `prp-gpu-1.t2.ucsd.edu`).
2. Install and setup Vivado Lab 2019.1 on a machine to be connected to the VCU118 via PCIe (like `scully.physics.ucsd.edu`).
3. Connect board according to [xtp449-vcu118-setup-c-2019-1.pdf](example_designs/xtp449-vcu118-setup-c-2019-1.pdf).

## Optional tests 
### Built-in self-test (BIST) instructions
1. Read and follow the instructions in [xtp453-vcu118-quickstart.pdf](user_guides/xtp453-vcu118-quickstart.pdf) to complete the built-in self test (BIST).

### Built-in test (BIT) instructions
1. Read and follow the instructions in [xtp439-vcu118-bit-c-2019-1.pdf](example_designs/xtp439-vcu118-bit-c-2019-1). Note this requires Windows (skip for now).

### IBERT test instructions
1. Read and follow the instructions in [xtp440-vcu118-gt-ibert-c-2019-1.pdf](example_designs/xtp440-vcu118-gt-ibert-c-2019-1.pdf) to test transceivers. In particular, you'll need [rdf0388-vcu118-gt-ibert-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0388-vcu118-gt-ibert-c-2019-1.zip), which is easiest to get with `wget` (for some reason downloading in a browser fails consistently). See also https://blog.samtec.com/post/xilinx-blog-firefly-vcu118-fpga/.

### IP integrator instructions
1. Read and follow the instructions in [xtp441-vcu118-ipi-c-2019-1.pdf](example_designs/xtp441-vcu118-ipi-c-2019-1.pdf). In particular, you'll need [rdf0389-vcu118-ipi-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0389-vcu118-ipi-c-2019-1.zip).

### MIG instructions
1. Read and follow instructions in [xtp442-vcu118-mig-c-2019-1.pdf](example_designs/xtp442-vcu118-mig-c-2019-1.pdf). In particular, you'll need [rdf0390-vcu118-mig-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0390-vcu118-mig-c-2019-1.zip).

## Setup PCIe 
1. Follow instructions in [xtp444-vcu118-pcie-c-2019-1.pdf](example_designs/xtp444-vcu118-pcie-c-2019-1.pdf). In particular, you'll need to build the PCIe firmware, 
2. Sioni nicely provided the pre-made Vivado project and bit file here: https://cernbox.cern.ch/index.php/s/YcgLBsVhCELekvc, which can be programmed on the FPGA with
```bash
vivado_lab -mode batch -source program_spi_vcu118.tcl
```
3. Now you should be able to see the FPGA over the PCIe
```bash
lspci -vv -d 10EE:
```

## `emp-fwk` 'null algo' instructions
1. Get added to `cms-tcds2-users` and `emp-fwk-users` e-groups to view GitLab repositories.
2. Install uHAL and ControlHub. Follow instructions at https://ipbus.web.cern.ch/doc/user/html/software/install/yum.html
and initialize
```bash
export PATH=/opt/cactus/bin/uhal/tools:$PATH LD_LIBRARY_PATH=/opt/cactus/lib:$LD_LIBRARY_PATH
```
3. Follow instructions at https://gitlab.cern.ch/p2-xware/firmware/emp-fwk
In particular, install ipbb a
```bash
curl -L https://github.com/ipbus/ipbb/archive/dev/2021j.tar.gz | tar xvz
source ipbb-dev-2021j/env.sh
```
and setup the work area (using ssh instead of https)
```bash
ipbb init p2fwk-work
cd p2fwk-work
ipbb add git ssh://git@gitlab.cern.ch:7999/p2-xware/firmware/emp-fwk.git
ipbb add git ssh://git@gitlab.cern.ch:7999/ttc/legacy_ttc.git -b v2.1
ipbb add git ssh://git@gitlab.cern.ch:7999/cms-tcds/cms-tcds2-firmware.git -b v0_1_1
ipbb add git ssh://git@gitlab.cern.ch:7999/HPTD/tclink.git -r fda0bcf
ipbb add git git@github.com:ipbus/ipbus-firmware.git -b v1.9
```
4. Then create the 'null algo' pass-through project
```bash
ipbb proj create vivado vcu118_null_algo emp-fwk:projects/examples/vcu118 top.dep
cd proj/vcu118_null_algo
```
5. Setup, build and package the bitfile
Note: For the following commands, you need to ensure that can find & use the `gen_ipbus_addr_decode` script (i.e. needs uHAL added to your PATH from previous step). Run the following IPBB commands:
```bash
ipbb ipbus gendecoders
ipbb vivado generate-project
ipbb vivado synth -j4 impl -j4
ipbb vivado package
```
You can check resources with:
```bash
ipbb vivado resource-usage
```
|  Instance  |      Module      |  Total LUTs  |  Logic LUTs  |   LUTRAMs   |    SRLs    |      FFs     |   RAMB36   |   RAMB18  |   URAM   | DSP48 Blocks |
|------------|------------------|--------------|--------------|-------------|------------|--------------|------------|-----------|----------|--------------|
| top        |            (top) | 26326(2.23%) | 24163(2.04%) | 1754(0.30%) | 409(0.07%) | 75827(3.21%) | 112(5.19%) | 64(1.48%) | 0(0.00%) |     0(0.00%) |
|   (top)    |            (top) |     1(0.01%) |     1(0.01%) |    0(0.00%) |   0(0.00%) |     0(0.00%) |   0(0.00%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |
|   ctrl     |         emp_ctrl |     1(0.01%) |     1(0.01%) |    0(0.00%) |   0(0.00%) |    32(0.01%) |   0(0.00%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |
|   datapath |     emp_datapath | 12606(1.07%) | 12220(1.03%) |    0(0.00%) | 386(0.07%) | 18553(0.78%) |  16(0.74%) | 64(1.48%) | 0(0.00%) |     0(0.00%) |
|   fabric   | ipbus_fabric_sel |    66(0.01%) |    66(0.01%) |    0(0.00%) |   0(0.00%) |     0(0.00%) |   0(0.00%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |
|   info     |         emp_info |   306(0.03%) |   306(0.03%) |    0(0.00%) |   0(0.00%) |   268(0.01%) |   0(0.00%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |
|   infra    |   emp_infra_pcie | 12703(1.07%) | 10934(0.92%) | 1754(0.30%) |  15(0.01%) | 15977(0.68%) |  95(4.40%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |
|   payload  |      emp_payload |     0(0.00%) |     0(0.00%) |    0(0.00%) |   0(0.00%) | 40200(1.70%) |   0(0.00%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |
|   ttc      |          emp_ttc |   645(0.05%) |   637(0.05%) |    0(0.00%) |   8(0.01%) |   797(0.03%) |   1(0.05%) |  0(0.00%) | 0(0.00%) |     0(0.00%) |

6. Copy `vcu118_null_algo` project folder to machine with FPGA and launch `vivado_lab`. Open the Hardware Manager > Open Target > Auto connect > Program device > Navigate to bit file in `proj/vcu118_null_algo/package/src/vcu118_null_algo.bit` > Click OK. This will program the null algo bitfile. You can close it now.
```bash
/home/xilinx/Vivado_Lab/2019.1/settings64.sh
vivado_lab
```
7. Make sure empbutler is setup (https://gitlab.cern.ch/p2-xware/software/emp-toolbox)
```bash
export LD_LIBRARY_PATH=/opt/cactus/lib:$LD_LIBRARY_PATH
export PATH=/opt/cactus/bin/emp:$PATH
source emp-toolbox/src/env.sh
empbutler --help
```
8. To run a test with random patterns, run
```bash
cd VCU118/scripts
source pcie_reconnect_xilinx.sh
source pattern_file_test.sh /path/to/vcu118_null_algo
```
This will make random input patterns stored in `data/tx_summary.txt` that look like:
```
Board vcu118
 Quad/Chan :        q12c0              q12c1              q12c2              q12c3              q13c0              q13c1              q13c2              q13c3      
      Link :         048                049                050                051                052                053                054                055       
Frame 0000 : 1v52cb7d855e064be0 1v4110c67d227b8316 1v90f149cf7d07f5bd 1v67dcaf0dbd99ab9b 1vfd46cb80a95284de 1v8a60605fdb034e46 1vf346088bc7c1a0d9 1v9aec8d093d6d61b2
Frame 0001 : 1vbe8630b89986a91f 1v8480517b5638775a 1v073fc954c12e177b 1ve01dfa16b2ceee1c 1vc21d97a4c5d215cc 1v7583524d41763ec0 1vb5e20e3fa98999c9 1v2fd1513a31a46764
Frame 0002 : 1v651a45ea4b323269 1v4d15daf9e6fefb00 1vebf5eb47870dd274 1vf4111a0b319e0266 1vaa5c63c14b99e2de 1vab7c6692ae4b3447 1v437f638e0885c4d0 1vd61e110f8b8ed2dd
Frame 0003 : 1v9382bf9065e908c6 1v9776a602d9b56da8 1v0754060c8cb0c07b 1vfc954fd017e7a179 1vb590f6b549003960 1va15c4606b9a7651e 1va574fd93b968aff2 1v8666879246b68a9f
```
The output should look like:
```
Board vcu118
 Quad/Chan :        q12c0              q12c1              q12c2              q12c3              q13c0              q13c1              q13c2              q13c3      
      Link :         048                049                050                051                052                053                054                055       
Frame 0000 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0001 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0002 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0003 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0004 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0005 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0006 : 0v52cb7d855e064be0 0v4110c67d227b8316 0v90f149cf7d07f5bd 0v67dcaf0dbd99ab9b 0vfd46cb80a95284de 0v8a60605fdb034e46 0vf346088bc7c1a0d9 0v9aec8d093d6d61b2
Frame 0007 : 1v52cb7d855e064be0 1v4110c67d227b8316 1v90f149cf7d07f5bd 1v67dcaf0dbd99ab9b 1vfd46cb80a95284de 1v8a60605fdb034e46 1vf346088bc7c1a0d9 1v9aec8d093d6d61b2
Frame 0008 : 1vbe8630b89986a91f 1v8480517b5638775a 1v073fc954c12e177b 1ve01dfa16b2ceee1c 1vc21d97a4c5d215cc 1v7583524d41763ec0 1vb5e20e3fa98999c9 1v2fd1513a31a46764
Frame 0009 : 1v651a45ea4b323269 1v4d15daf9e6fefb00 1vebf5eb47870dd274 1vf4111a0b319e0266 1vaa5c63c14b99e2de 1vab7c6692ae4b3447 1v437f638e0885c4d0 1vd61e110f8b8ed2dd
Frame 0010 : 1v9382bf9065e908c6 1v9776a602d9b56da8 1v0754060c8cb0c07b 1vfc954fd017e7a179 1vb590f6b549003960 1va15c4606b9a7651e 1va574fd93b968aff2 1v8666879246b68a9f
```
Note the first 7 frames have a data valid bit (first bit) equal to 0 meaning its not valid data. After that, the valid bit is always 1 and you can see the output matches the input.


## Correlator layer 2 jet algo instructions
1. See https://github.com/thesps/GlobalCorrelator/tree/layer2-interleaving/emp_examples/Layer2/standalones/firmware
