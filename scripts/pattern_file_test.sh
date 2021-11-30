# Setup paths
cfile=connections.xml
fpga=vcu118

# Check info
empbutler -c $cfile do $fpga inspect 'info*'
empbutler -c $cfile do $fpga info

# Reset the firmware (just clears some registers)
empbutler -c $cfile do $fpga reset internal
# Configure the rx (receiver) buffers in 'PlayOnce' mode.
# The file PatternFile5Events.txt is written (over IPBus over PCIe) into buffers (memories) next to each receiver link.
empbutler -c $cfile do $fpga buffers rx PlayOnce --inject generate://random
# Configure the tx (transmit) buffer of link 0 to Capture. The algorithm only outputs to one link
empbutler -c $cfile do $fpga buffers tx Capture
empbutler -c $cfile do $fpga capture
#geany data/rx_summary.txt
#empbutler -c $cfile do $fpga buffers tx Capture -c 0-5
# Play the data from rx buffer, through algorithm, to tx buffer
#empbutler -c $cfile do $fpga capture --rx 0-110 --tx 0-5
