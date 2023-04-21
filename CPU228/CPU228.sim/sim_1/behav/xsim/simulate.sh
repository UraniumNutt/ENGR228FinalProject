#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
<<<<<<< HEAD
# Generated by Vivado on Tue Apr 18 16:42:58 CDT 2023
=======
# Generated by Vivado on Thu Apr 20 22:40:54 CDT 2023
>>>>>>> main
# SW Build 3671981 on Fri Oct 14 04:59:54 MDT 2022
#
# IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim RAMTestbench_behav -key {Behavioral:sim_1:Functional:RAMTestbench} -tclbatch RAMTestbench.tcl -log simulate.log"
xsim RAMTestbench_behav -key {Behavioral:sim_1:Functional:RAMTestbench} -tclbatch RAMTestbench.tcl -log simulate.log

