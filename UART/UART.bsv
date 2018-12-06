package UART;
import Blink::*;
import FIFOF::*;
import Clocks::*;
//The third step is to have a method to recieve data. Or at least shine an LED when data just came in.
//The fourth step is to maybe have a method that can make the second and the third step work concurrently.


//Defines a BYTE data type which is only 8 bits
typedef Bit#(8) BYTE;

//The first step, to send data, is to be able to store data in a fifo like structure
interface UART_Send;
    //The data transfer size is 8 bits

    method Action  data_store(BYTE data);
    method Bit#(1) data_send();
    interface Clock slow_clock;
endinterface: UART_Send

interface UART_Rec;
    
endinterface: UART_Rec

//The send process will involve 2 parts -- 1 start bit and 8 data transfer bits.
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
        data_fifo.enq({2'b11,data});
    endmethod: data_store

    method Bit#(1) data_send();
        if(!data_fifo.notEmpty)begin
            return 1;
        end else begin
            let data= data_fifo.first;
            if(count==0)begin
                return 0;
            end 
            else begin
                return data[count-1];
            end
        end
    endmethod: data_send

    interface slow_clock = c1.slowClock;
endmodule: mkTX

module mkRX(UART_Rec);
    
endmodule: mkRX



endpackage: UART