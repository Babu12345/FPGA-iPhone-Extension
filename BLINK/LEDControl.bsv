
package LEDControl;
    //LED project used for TinyFPGA and written in Bluespec !!!


interface BlinkControl;
    
    method Bit#(1) led(Bit#(1) val);

endinterface: BlinkControl   


(*synthesize*)
(*clock_prefix="CLK"*)
(*reset_prefix="RST"*)
(*doc="This is the module to control the built-in LED"*)
(*always_ready="led"*)

module mkLED(BlinkControl);

    method Bit#(1) led(Bit#(1) val) if(True);//Always active condition
        return val;
    endmethod: led

endmodule: mkLED


endpackage: LEDControl