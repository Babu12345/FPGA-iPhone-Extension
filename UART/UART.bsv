package UART;
import FIFOF::*;
import Clocks::*;
//The third step is to have a method to recieve data. Or at least shine an LED when data just came in.
//The fourth step is to maybe have a method that can make the second and the third step work concurrently.


//Defines a BYTE data type which is only 8 bits
typedef Bit#(8) BYTE;
typedef enum {
    READ,SEND,IDLE
} StateUART deriving(Eq, Bits);


//The first step, to send data, is to be able to store data in a fifo like structure
interface UART_Send;
    //The data transfer size is 8 bits
    method Action  data_store(BYTE data);
    method Bit#(1) data_send();
    interface Clock slow_clock;
endinterface: UART_Send

interface UART_Rec;
    //The data transfer size is 8 bits
    method Action data_input(Bit#(1) data_bit);
    method ActionValue#(Bit#(8)) output_data();
    interface Clock slow_clock;
endinterface: UART_Rec

//The send process will involve 2 parts -- 2 start bits and 8 data transfer bits.
//The line will be high idle 

(*synthesize*)
//(*always_ready="data_send"*)//Suggests that you always send a signal.
//UART transmitter 1 start bit, 8 data bits, 2 stop bits, no parity.
module mkTX#(UInt#(32) baud_rate,UInt#(32) clockSpeed)(UART_Send);
    
    UInt#(32) divisor = clockSpeed/baud_rate;//For clk=16MHZ and br=115200, dv=139

    ClockDividerIfc c1 <- mkClockDivider(139, reset_by noReset);

    Clock main_clk <-exposeCurrentClock;
    
    SyncFIFOIfc#(Bit#(TAdd#(SizeOf#(BYTE),2))) data_fifo <-mkSyncFIFO(4,main_clk,noReset,c1.slowClock, reset_by noReset);//Used to write from the main clock domain and to read from the other as is required in the UART module implementation

    Reg#(Bit#(4)) count <-mkReg(0,clocked_by c1.slowClock ,reset_by noReset);


    rule bitInteration(data_fifo.notEmpty);
        if(count!=10)begin
            count <= count+1;
        end
        else if(count==10)begin
            data_fifo.deq;
            count<=0;
        end
    endrule: bitInteration

    method Action data_store(BYTE data);
        data_fifo.enq({1'b1,1'b1,data});
    endmethod: data_store

    method Bit#(1) data_send();
        if(!data_fifo.notEmpty)begin
            return 1'b1;
        end else begin
            let data= data_fifo.first;
            if(count==0)begin
                 return 1'b0;
             end 
             else begin
                 return data[count-1];
             end
        end
    endmethod: data_send

    interface slow_clock = c1.slowClock;
endmodule: mkTX

(*synthesize*)
(*descending_urgency="data_input, iterate_data"*)
module mkRX#(UInt#(32) baud_rate, UInt#(32) clockSpeed)(UART_Rec);

    UInt#(32) divisor = clockSpeed/baud_rate;//For clk=16MHZ and br=115200, dv=139
    ClockDividerIfc c1 <- mkClockDivider(139, reset_by noReset);//The divisor here is 139.
    Clock main_clk <-exposeCurrentClock;

    SyncFIFOIfc#(BYTE) data_fifo <-mkSyncFIFO(4,c1.slowClock,noReset,main_clk, reset_by noReset);//Used to write from the slowClock and read from the main_clk of 16MHZ
    Reg#(Bit#(8)) data_out <-mkReg(0,clocked_by c1.slowClock, reset_by noReset);
    Reg#(Bit#(4)) count <- mkReg(0, clocked_by c1.slowClock, reset_by noReset);
    Reg#(StateUART) state1 <-mkReg(IDLE, clocked_by c1.slowClock,reset_by noReset);

    rule iterate_data(state1==READ);
        if(count!=8)begin
            count<=count+1;
        end
        if(count==8)begin
            state1<=IDLE;
            count<=0;
            if(data_fifo.notFull)begin
                data_fifo.enq(data_out);
            end
        end
    endrule: iterate_data

    method Action data_input(Bit#(1) data_bit);//Should be connected in the testbench to the Reciever of the UART module
        Bit#(8) temp_data=data_out;
        if(data_bit==1 && count==0)begin//IDLE State
            noAction;
        end
        if(data_bit==0)begin//Start Bit == READ state
            state1<=READ;
        end
        if(state1==READ)begin
            temp_data[count]=data_bit;
            data_out<=temp_data;
        end
    endmethod: data_input

    method ActionValue#(BYTE) output_data() if(data_fifo.notEmpty);
        
        data_fifo.deq;
        return data_fifo.first;
    endmethod: output_data

    interface slow_clock=c1.slowClock;
endmodule: mkRX



endpackage: UART
