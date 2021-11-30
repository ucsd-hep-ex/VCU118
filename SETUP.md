# VCU118

## General setup
1. Install and setup Vivado 2019.1 on a machine for compiling firmware (like `prp-gpu-1.t2.ucsd.edu`).
2. Install and setup Vivado Lab 2019.1 on a machine to be connected to the VCU118 via PCIe (like `scully.physics.ucsd.edu`).
3. Connect board according to [xtp449-vcu118-setup-c-2019-1.pdf](example_designs/xtp449-vcu118-setup-c-2019-1.pdf).

## Optional tests 
1. Built-in self-test (BIST): Read and follow the instructions in [xtp453-vcu118-quickstart.pdf](user_guides/xtp453-vcu118-quickstart.pdf) to complete the built-in self test (BIST).
2. Built-in test (BIT): Read and follow the instructions in [xtp439-vcu118-bit-c-2019-1.pdf](example_designs/xtp439-vcu118-bit-c-2019-1). Note this requires Windows (skip for now).
3. IBERT: Read and follow the instructions in [xtp440-vcu118-gt-ibert-c-2019-1.pdf](example_designs/xtp440-vcu118-gt-ibert-c-2019-1.pdf) to test transceivers. In particular, you'll need [rdf0388-vcu118-gt-ibert-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0388-vcu118-gt-ibert-c-2019-1.zip), which is easiest to get with `wget` (for some reason downloading in a browser fails consistently). See also https://blog.samtec.com/post/xilinx-blog-firefly-vcu118-fpga/.
4. IP integrator: Read and follow the instructions in [xtp441-vcu118-ipi-c-2019-1.pdf](example_designs/xtp441-vcu118-ipi-c-2019-1.pdf). In particular, you'll need [rdf0389-vcu118-ipi-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0389-vcu118-ipi-c-2019-1.zip).
5. MIG instructions: Read and follow instructions in [xtp442-vcu118-mig-c-2019-1.pdf](example_designs/xtp442-vcu118-mig-c-2019-1.pdf). In particular, you'll need [rdf0390-vcu118-mig-c-2019-1.zip](https://www.xilinx.com/support/documentation/boards_and_kits/vcu118/2019_1/rdf0390-vcu118-mig-c-2019-1.zip).

## Setup PCIe 
1. Install XDMA drivers (clone and follow instructions in: https://github.com/Xilinx/dma_ip_drivers/tree/master/XDMA/linux-kernel). For Centos8, we needed this patch: https://github.com/Xilinx/dma_ip_drivers/pull/114
1. Follow instructions in [xtp444-vcu118-pcie-c-2019-1.pdf](example_designs/xtp444-vcu118-pcie-c-2019-1.pdf). In particular, you'll need to build the PCIe firmware, 
2. Sioni nicely provided the pre-made Vivado project and bit file here: https://cernbox.cern.ch/index.php/s/YcgLBsVhCELekvc, which can be programmed on the FPGA with
```bash
vivado_lab -mode batch -source program_spi_vcu118.tcl
```
3. Now you should be able to see the FPGA over the PCIe
```bash
lspci -vv -d 10EE:
```

