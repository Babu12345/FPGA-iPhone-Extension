package Testbench;
import StmtFSM::*;
import LEDControl::*;

interface PINS;
    (*result="LED"*)
    method Bit#(1) led();
    (*result="USBPU"*)
    method Bit#(1) usbpu();

endinterface: PINS

(*synthesize*)
(*clock_prefix="CLK"*)
(*reset_prefix="RST"*)
(*doc="Define BSV_POSITIVE_RESET if there is no reset pin in order to prevent the program from resetting"*)
module mkTB(PINS);
    LEDControl led1 <-mkLED;
    Reg#(Bit#(26)) counter <-mkReg(0);
    Bit#(32) blink_pattern=32'b0101010001110111011100010101;//SOS LED display

    rule interate(True);
        counter <= counter+1;
    endrule: interate




    /*
    Pin Mapping
    This section is to map the pins from the modules into the pins to the top level testbench module
    */
    method Bit#(1) led()= led1.led(blink_pattern[counter[25:21]]);
    method Bit#(1) usbpu() = 1'b0 ;

endmodule: mkTB





endpackage: Testbench