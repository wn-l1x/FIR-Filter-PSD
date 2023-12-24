# FIR_Filter Module
## Overview
This repository contains the VHDL implementation of an FIR (Finite Impulse Response) filter module. The FIR filter is a digital signal processing component that performs convolution on a sequence of input data with a set of predefined coefficients. This VHDL implementation includes entities for various subcomponents such as an Adder, Amplifier, and Sample Delay.

## File Structure
FIR_Filter.vhd: Entity and architecture declarations for the FIR_Filter module.
Adder.vhd: VHDL implementation of the Adder component.
Amplifier.vhd: VHDL implementation of the Amplifier component.
Sample_Delay.vhd: VHDL implementation of the Sample_Delay component.

## Architecture Description
The architecture rtl of the FIR_Filter module contains the following components:
#### Adder: Performs addition on an array of input signals.
#### Amplifier: Multiplies an input signal by a coefficient.
#### Sample_Delay: Delays input signals based on the specified order.

## Signal Declarations
#### state_list: Enumeration of states for the state machine.
#### state: Current state of the state machine.
#### order: Order of the FIR filter.
#### Various signals (s_delay_in, s_delay_out, s_coefficient_list, s_amp_in, s_amp_out, s_adder_in, s_adder_out) used for communication between components.

## State Machine
The architecture includes a state machine that controls the flow of data through the filter. States include FETCH_ORDER, FETCH_INPUT, FETCH_AMP, COUNT, ADD, and DONE.

## File Output
The architecture writes delay input and adder output values to separate text files (delay_in_values.txt and adder_out_values.txt, respectively) during the ADD state.

## How to Use
#### Instantiate the FIR_Filter module in your VHDL design.
#### Connect the clk and control_word ports appropriately.
#### Ensure proper instantiation and connection of subcomponents (Adder, Amplifier, Sample_Delay).

## Testbench
A testbench (FIR_Filter_tb.vhd) is provided to validate the functionality of the FIR filter. The testbench generates sample inputs and monitors the output. Simulate the design using your preferred VHDL simulator, such as ModelSim or GHDL, to verify correct behavior.

## Viewing Output
After simulation, the output data can be extracted and visualized using the provided Python program (plot.py)
