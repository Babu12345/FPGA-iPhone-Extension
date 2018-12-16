//
// Generated by Bluespec Compiler, version 2016.07.beta1 (build 34806, 2016-07-05)
//
// On Thu Dec 13 00:48:59 UTC 2018
//
//
// Ports:
// Name                         I/O  size props
// RDY_data_input                 O     1 const
// output_data                    O     8
// RDY_output_data                O     1
// CLK_slow_clock                 O     1 clock
// CLK_GATE_slow_clock            O     1 const
// baud_rate                      I    32 unused
// clockSpeed                     I    32 unused
// CLK                            I     1 clock
// RST_N                          I     1 unused
// data_input_data_bit            I     1
// EN_data_input                  I     1
// EN_output_data                 I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkRX(baud_rate,
	    clockSpeed,
	    CLK,
	    RST_N,

	    data_input_data_bit,
	    EN_data_input,
	    RDY_data_input,

	    EN_output_data,
	    output_data,
	    RDY_output_data,

	    CLK_slow_clock,
	    CLK_GATE_slow_clock);
  input  [31 : 0] baud_rate;
  input  [31 : 0] clockSpeed;
  input  CLK;
  input  RST_N;

  // action method data_input
  input  data_input_data_bit;
  input  EN_data_input;
  output RDY_data_input;

  // actionvalue method output_data
  input  EN_output_data;
  output [7 : 0] output_data;
  output RDY_output_data;

  // oscillator and gates for output clock CLK_slow_clock
  output CLK_slow_clock;
  output CLK_GATE_slow_clock;

  // signals for module outputs
  wire [7 : 0] output_data;
  wire CLK_GATE_slow_clock, CLK_slow_clock, RDY_data_input, RDY_output_data;

  // register count
  reg [3 : 0] count;
  wire [3 : 0] count$D_IN;
  wire count$EN;

  // register data_out
  reg [7 : 0] data_out;
  wire [7 : 0] data_out$D_IN;
  wire data_out$EN;

  // register state1
  reg [1 : 0] state1;
  wire [1 : 0] state1$D_IN;
  wire state1$EN;

  // ports of submodule c1
  wire c1$CLK_OUT;

  // ports of submodule data_fifo
  wire [7 : 0] data_fifo$dD_OUT, data_fifo$sD_IN;
  wire data_fifo$dDEQ, data_fifo$dEMPTY_N, data_fifo$sENQ, data_fifo$sFULL_N;

  // rule scheduling signals
  wire WILL_FIRE_RL_iterate_data;

  // inputs to muxes for submodule ports
  wire MUX_state1$write_1__SEL_1;

  // remaining internal signals
  wire [7 : 0] x__h721, y__h764;
  wire [3 : 0] x__h368;

  // oscillator and gates for output clock CLK_slow_clock
  assign CLK_slow_clock = c1$CLK_OUT ;
  assign CLK_GATE_slow_clock = 1'b1 ;

  // action method data_input
  assign RDY_data_input = 1'd1 ;

  // actionvalue method output_data
  assign output_data = data_fifo$dD_OUT ;
  assign RDY_output_data = data_fifo$dEMPTY_N ;

  // submodule c1
  ClockDiv #(.width(32'd8),
	     .lower(32'd58),
	     .upper(32'd196),
	     .offset(32'd0)) c1(.CLK_IN(CLK),
				.RST(!`BSV_RESET_VALUE),
				.PREEDGE(),
				.CLK_OUT(c1$CLK_OUT));

  // submodule data_fifo
  SyncFIFO #(.dataWidth(32'd8),
	     .depth(32'd4),
	     .indxWidth(32'd2)) data_fifo(.sCLK(c1$CLK_OUT),
					  .dCLK(CLK),
					  .sRST(!`BSV_RESET_VALUE),
					  .sD_IN(data_fifo$sD_IN),
					  .sENQ(data_fifo$sENQ),
					  .dDEQ(data_fifo$dDEQ),
					  .sFULL_N(data_fifo$sFULL_N),
					  .dEMPTY_N(data_fifo$dEMPTY_N),
					  .dD_OUT(data_fifo$dD_OUT));

  // rule RL_iterate_data
  assign WILL_FIRE_RL_iterate_data =
	     data_fifo$sFULL_N && state1 == 2'd0 && !EN_data_input ;

  // inputs to muxes for submodule ports
  assign MUX_state1$write_1__SEL_1 =
	     WILL_FIRE_RL_iterate_data && count == 4'd8 ;

  // register count
  assign count$D_IN = (count == 4'd8) ? 4'd0 : x__h368 ;
  assign count$EN = WILL_FIRE_RL_iterate_data ;

  // register data_out
  assign data_out$D_IN =
	     data_input_data_bit ? data_out | x__h721 : data_out & y__h764 ;
  assign data_out$EN = EN_data_input && state1 == 2'd0 ;

  // register state1
  assign state1$D_IN = MUX_state1$write_1__SEL_1 ? 2'd2 : 2'd0 ;
  assign state1$EN =
	     WILL_FIRE_RL_iterate_data && count == 4'd8 ||
	     EN_data_input && !data_input_data_bit ;

  // submodule data_fifo
  assign data_fifo$sD_IN = data_out ;
  assign data_fifo$sENQ =
	     WILL_FIRE_RL_iterate_data && count == 4'd8 && data_fifo$sFULL_N ;
  assign data_fifo$dDEQ = EN_output_data ;

  // remaining internal signals
  assign x__h368 = count + 4'd1 ;
  assign x__h721 = 8'd1 << count ;
  assign y__h764 = ~x__h721 ;

  // handling of inlined registers

  always@(posedge c1$CLK_OUT)
  begin
    if (!`BSV_RESET_VALUE == `BSV_RESET_VALUE)
      begin
        count <= `BSV_ASSIGNMENT_DELAY 4'd0;
	data_out <= `BSV_ASSIGNMENT_DELAY 8'd0;
	state1 <= `BSV_ASSIGNMENT_DELAY 2'd2;
      end
    else
      begin
        if (count$EN) count <= `BSV_ASSIGNMENT_DELAY count$D_IN;
	if (data_out$EN) data_out <= `BSV_ASSIGNMENT_DELAY data_out$D_IN;
	if (state1$EN) state1 <= `BSV_ASSIGNMENT_DELAY state1$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    count = 4'hA;
    data_out = 8'hAA;
    state1 = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkRX
