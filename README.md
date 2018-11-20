# FPGA iPHONE EXTENSION
FPGA interface to a cellphone and other peripherals through bluetooth and other peripherals

## Description
The purpose of this project is to create way for the TinyFPGA board to interface with my iPhone and my other STM32F405 Microcontrollers through a bluetooth module. This will allow a better way to communicate with the FPGA in order to better transfer data, get test information for practice programs, and to also optimize computations that are better suited for the parallel nature of the FPGA.
By using the TinyFPGA, I'm able program the board using APIO and TinyProg interfaces both of which are available on my MacBook Pro. The language that I'm using to program the FPGA board is the BlueSpec Hardware Description Language which allows my to parameterize different types and to use atomic rules in order to easen the burden of creating a parallel program. The Bluespec code is then synthesized to Verilog and from there I can upload it to the TinyFPGA board.  

## Goals
  * The first step is to test the TinyFPGA board using a simple Blink Program
  * The second step is to create a UART interface and test the communication protocol on my computer.
