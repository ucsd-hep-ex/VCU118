#!/bin/bash
# --------------------------------------------------------------------
#
# This script is for management of FPGAs with PCIe connection to a PC.
# any firmware upload will break the PCIe link between FPGA and host,
# and this script re-establishes the link afterwards by removing the
# FPGA device from the PCI tree temporarily and then triggering a scan
# for new devices.
#
# Kristian Harder and Henry Franks, July 2017
#
# version 1.1
#
# 
# Added device ids (7021 and 8031) to remove pci devices invidually and support two
# devices. Temp fix. Solution required to deal with multiple devices-- Raghu
#---------------------------------------------------------------------

# check if there is a Xilinx FPGA connected to PCIe and get its device ID
echo "Checking for Xilinx device in PCIe tree..."
devID1=$(/sbin/lspci -d 10ee:9031 | cut -c 1-7)
if [ "$devID1" != "" ]; then
  echo "Found Xilinx device" $devID
else
  echo "No Xilinx device found."
fi

# disconnect the FPGA from the PCI device tree if it is present
if [ "$devID1" != "" ]; then
  echo "Disconnecting Xilinx FPGA from PCIe..."
  echo 1 > /sys/bus/pci/devices/0000:$devID1/remove
  result=$?
  if [ $result != 0 ]; then
    echo "Unable to disconnect device. Abort."
    exit 2
  fi
fi

# rescan PCI devices
echo "Rescanning PCIe devices..."
echo 1 > /sys/bus/pci/rescan
result=$?
if [ $result != 0 ]; then
  echo "Unable to rescan bus. Abort."
  exit 3
fi

echo "Done."
