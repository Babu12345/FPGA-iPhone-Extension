package Testbench;
import StmtFSM::*;
import LEDControl::*;
import Clocks::*;


interface PINS;
    //Must return the clocks of any output methods
    
    (*result="LED"*)//Only testing the pin to see if there is enough voltage to turn on the external.
    method Bit#(1) led();
    (*result="USBPU"*)
    method Bit#(1) usbpu();
    /* //Not yet defined 
    (*result="PIN_22"*)
    method Bit#(1) UART_tx();
    (*result="PIN_23"*)
    method Bit#(1) UART_rx();
    */
    interface Clock slow_clock;
endinterface: PINS

(*synthesize*)
(*clock_prefix="CLK"*)
(*reset_prefix="RST"*)
(*doc="Define BSV_POSITIVE_RESET if there is no reset pin in order to prevent the program from resetting"*)

module mkTB(PINS);
    //You want a period of .1 seconds or 10 HZ for the LED. Therefore the divider= 16MZ/10HZ
    ClockDividerIfc c1 <- mkClockDivider(1600000, reset_by noReset);
    BlinkControl led1 <-mkLED(reset_by noReset);
    Reg#(Bit#(5)) counter <-mkReg(0,clocked_by c1.slowClock,reset_by noReset);

    Bit#(32) blink_pattern=32'b0101010001110111011100010101;//SOS LED display

    rule interate(True);
        counter <= counter+1;
    endrule: interate

    /*
    Pin Mapping
    This section is to map the pins from the modules into the pins to the top level testbench module
    //List also returns the interfaces of the clocks used that are not in the clock family
    */
    method Bit#(1) led()= led1.led(blink_pattern[counter]);
    method Bit#(1) usbpu() = 1'b0 ;
    interface slow_clock = c1.slowClock;
endmodule: mkTB





endpackage: Testbench