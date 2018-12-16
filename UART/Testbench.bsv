package Testbench;

import UART::*;  
import Clocks::*;
//Make sure to have the initial blocks on.

typedef enum {
    ON,OFF
} LED_State deriving(Eq, Bits);


typedef enum {
    READ,SEND,IDLE
} StateTb deriving(Eq, Bits);

interface PINS;
    //Must return the clocks of any output methods
    (*result="USBPU"*)
    method Bit#(1) usbpu();

    (*result="PIN_24"*)
    method Bit#(1) uart_tx();//tx(Board) -> rx(FTDI)

    (*result="PIN_22"*)
    method Bit#(1) led();
    
    (*result="PIN_23"*)
    method Action uart_rx(Bit#(1) data_bit);//rx(Board) -> tx(FTDI)
    
    interface Clock  slow_clockUART_TX;
    interface Clock  slow_clockLED;
    interface Clock slow_clockUART_RX;    

endinterface: PINS

(*synthesize*)
(*clock_prefix="CLK"*)
(*reset_prefix="RST"*)

module mkTb(PINS);
    Bit#(2) led_state={pack(ON),pack(OFF)};
    UART_Send tx <- mkTX(115200,16000000);
    UART_Rec rx <- mkRX(115200,16000000);
    ClockDividerIfc led_c1 <- mkClockDivider(16000000, reset_by noReset);
    Reg#(Bit#(3)) state1 <-mkReg(0,reset_by noReset);
    Reg#(Bit#(1)) counter <-mkReg(0,clocked_by led_c1.slowClock,reset_by noReset);

    rule count(True);
        counter<=counter+1;//Wrapps around itself
    endrule: count

    rule sendSignal1(state1==0);
        tx.data_store(8'h42);//B
        state1<=1;
    endrule: sendSignal1

    rule sendSignal2(state1==1);
        tx.data_store(8'h41);//A
        state1<=2;
    endrule: sendSignal2

    rule sendSignal3(state1==2);
        tx.data_store(8'h42);//B
        state1<=3;
    endrule: sendSignal3

    rule sendSignal4(state1==3);
        tx.data_store(8'h55);//U
        state1<=4;
    endrule: sendSignal4

    rule sendSignal5(state1==4);
        tx.data_store(8'h20);//SPACE
        state1<=0;
    endrule: sendSignal5

    //rule readSignal(state1==2);
    //    $display("The data that was read was %c",rx.output_data);
    //endrule: readSigna

    method Action uart_rx(Bit#(1) data_in);
        rx.data_input(data_in);
    endmethod: uart_rx

    method Bit#(1) uart_tx() = tx.data_send();
    method Bit#(1) usbpu() = 1'b0 ;
    method Bit#(1) led() = led_state[counter];

    interface slow_clockUART_TX=tx.slow_clock;
    interface slow_clockUART_RX=rx.slow_clock;

    interface slow_clockLED= led_c1.slowClock;
endmodule: mkTb





endpackage: Testbench