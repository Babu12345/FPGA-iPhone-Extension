package UART;
import Blink::*;
//The first step is to have a method that can send data
//Instead of having a method that can set the send address, I can potentially just put that as a parameter of the module in-order to make sure that each module can only communicate with one other reciever. This can also be changed as needed.
//The third step is to have a method to recieve data. Or at least shine an LED when data just came in.
//The fourth step is to maybe have a method that can make the second and the third step work concurrently.

interface UART_Send;
    //The data transfer size is 8 bits




endinterface: UART_Send

interface UART_Rec;
    


endinterface: UART_Rec


module mkUART_Send(UART_Send);
    
endmodule: mkUART_Send

module mkUART_Rec(UART_Rec);
    


endmodule: mkUART_Rec



endpackage: UART