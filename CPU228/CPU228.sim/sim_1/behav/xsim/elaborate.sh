#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
# Generated by Vivado on Tue Apr 18 16:42:56 CDT 2023
=======
# Generated by Vivado on Thu Apr 20 22:40:52 CDT 2023
>>>>>>> main
=======
# Generated by Vivado on Thu Apr 20 22:40:52 CDT 2023
>>>>>>> f673ac051b546339314d49294f46a630547c13a5
=======
# Generated by Vivado on Thu Apr 20 22:40:52 CDT 2023
>>>>>>> origin
# SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
#
# IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot RAMTestbench_behav xil_defaultlib.RAMTestbench xil_defaultlib.glbl -log elaborate.log"
xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot RAMTestbench_behav xil_defaultlib.RAMTestbench xil_defaultlib.glbl -log elaborate.log

