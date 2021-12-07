# VCU118

## Quickstart (`emp-fwk` 'null algo' instructions)
1. Login with X11 forwarding enabled
```
ssh -Y <username>@scully.physics.ucsd.edu
```
2. For many steps, root access is necessary. So set up the environment as follows:
```bash
sudo xauth add $(xauth -f /home/users/${USER}/.Xauthority list|tail -1)
sduo bash
source /home/users/woodson/setup_emp.sh
```
3. Program the FPGA. First launch `vivado_lab` (with root acess)
```bash
vivado_lab
```
Open the Hardware Manager > Open Target > Auto connect > Program device > Navigate to bit file in `/home/users/woodson/p2fwk-work/proj/vcu118_null_algo/package/src/vcu118_null_algo.bit` > Click OK. This will program the null algo bitfile. You can close the GUI now.
4. To run a test with random patterns, run
```bash
cd VCU118/scripts
source pcie_reconnect_xilinx.sh
source pattern_file_test.sh
```
Note the `connections.xml` has hardcoded the path to the null algo: `/home/users/woodson/p2fwk-work/proj/vcu118_null_algo`
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


## Rebuilding the firmware
First set up a working area on a machine for compiling firmware like `prp-gpu-1.t2.ucsd.edu`.
Note use the `/scratch/data/$USER` area instead of your home directory due to disk space constraints.
Then follow these instructions

1. Get added to `cms-tcds2-users` and `emp-fwk-users` CERN e-groups to view GitLab repositories.
2. To setup environment with Vivado 2019.1 and other software, do
```bash
source /scratch/data/setup_emp.sh
```
2. Make sure uHAL and ControlHub are installed. If not, follow instructions at https://ipbus.web.cern.ch/doc/user/html/software/install/yum.html
3. Make sure `ipbb` is installed and set up. If not, follow instructions at https://gitlab.cern.ch/p2-xware/firmware/emp-fwk
4. Setup the work area (using ssh instead of https)
```bash
ipbb init p2fwk-work
cd p2fwk-work
ipbb add git ssh://git@gitlab.cern.ch:7999/p2-xware/firmware/emp-fwk.git
ipbb add git ssh://git@gitlab.cern.ch:7999/ttc/legacy_ttc.git -b v2.1
ipbb add git ssh://git@gitlab.cern.ch:7999/cms-tcds/cms-tcds2-firmware.git -b v0_1_1
ipbb add git ssh://git@gitlab.cern.ch:7999/HPTD/tclink.git -r fda0bcf
ipbb add git git@github.com:ipbus/ipbus-firmware.git -b v1.9
```
4. Create the 'null algo' pass-through project
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

6. Copy `vcu118_null_algo` project folder to machine with FPGA (`scully.physics.ucsd.edu`) and follow the instructions above.
