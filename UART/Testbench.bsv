package Testbench;

import UART::*;  
import Clocks::*;

typedef enum {
    IDLE, SEND
} State deriving(Eq, Bits);

typedef enum {
    ON,OFF
} LED_State deriving(Eq, Bits);

interface PINS;
    //Must return the clocks of any output methods
    (*result="USBPU"*)
    method Bit#(1) usbpu();

    (*result="PIN_24"*)
    method Bit#(1) uart_tx();//tx(Board) -> rx(FTDI)

    (*result="PIN_22"*)
    method Bit#(1) led();
    
    /*
    //Not yet defined
    (*result="PIN_23"*)
    method Bit#(1) UART_rx();//rx(Board) -> tx(FTDI)
    */
    interface Clock  slow_clockUART;
    interface Clock  slow_clockLED;    

endinterface: PINS

(*synthesize*)
(*clock_prefix="CLK"*)
(*reset_prefix="RST"*)

module mkTb(PINS);
    Bit#(2) led_state={pack(ON),pack(OFF)};
    UART_Send tx <- mkTX(115200,16000000);
    ClockDividerIfc led_c1 <- mkClockDivider(16000000, reset_by noReset);
    Reg#(State) state1 <-mkReg(IDLE,reset_by noReset);
    Reg#(Bit#(1)) counter <-mkReg(0,clocked_by led_c1.slowClock,reset_by noReset);

    rule count(True);
        counter<=counter+1;//Wrapps around itself
    endrule: count

    rule sendSignal(state1==SEND);
        tx.data_store(8'h41);
        state1<=IDLE;
    endrule: sendSignal

    rule sendBuffer(state1==IDLE);
        tx.data_store(8'h42);
        state1<=SEND;
    endrule: sendBuffer

    method Bit#(1) uart_tx() = tx.data_send();
    method Bit#(1) usbpu() = 1'b0 ;
    method Bit#(1) led() = led_state[counter];

    interface slow_clockUART=tx.slow_clock;
    interface slow_clockLED= led_c1.slowClock;
endmodule: mkTb





endpackage: Testbench