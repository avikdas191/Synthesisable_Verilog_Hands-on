//  This code was originally generated by Terasic System Builder
//  then amended by AK for brewity
`default_nettype none // disallow associting new names with wires
module DE10_Lite_top( 
// keep the ports declaration below and use these names in your design
	input 				ADC_CLK_10, MAX10_CLK1_50, MAX10_CLK2_50, 	// CLOCK
	output	[7:0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, 		// SEG7, 6 pcs
	input		[1:0]		KEY,	// inverted push buttons, 2 pcs				
	output	[9:0]		LEDR,	// red LEDs, 10 pcs
	input 	[9:0]		SW	// slide switches, 10 pcs
);

//  do_not_remove_code BEGIN
	wire [1:0] KEYn = ~KEY; // KEYn is 1 when the button is pressed, use it
	assign LEDR = SW;
	assign HEX5 = 8'b11111111 ;
	assign HEX4 = 8'b11111111 ;
	assign HEX3 = 8'b11111111 ;
// END of do_not_remove_code

// all_your_HDL_code BEGIN
	// declare three 4 bits wire below (one line)
//	wire [3:0] Dig3, Dig2, Dig1;
	
	//instantiate three SevSeg with the inputs to the digits and 
	//outputs to HEX2,HEX1,HEX0 below
	SevSeg SevSeg_1 ( .HEX_2_disp (rDig1), .segments (HEX0) );
	SevSeg SevSeg_2 ( .HEX_2_disp (rDig2), .segments (HEX1) );
	SevSeg SevSeg_3 ( .HEX_2_disp (rDig3), .segments (HEX2) );

	// convert the C code, given in the lab sheet, 
   //	into Verilog code below (three lines)		
//	assign Dig3 = rSW / 100; 
//	assign Dig2 = (rSW - Dig3*100) /10;
//	assign Dig1 = rSW - Dig3*100 - Dig2*10;
	
	reg [9:0] rSW;
	always @ (posedge KEYn[0]) begin
		rSW <= SW;
		rDig3 <= rSW / 100;
		rDig2 <= rTmp /10;
		rDig1 <= rTmp - rDig2*10;
		rTmp	<=	rSW - rDig3*100;
	end
	
	reg [3:0] rDig3, rDig2, rDig1;
	reg [6:0] rTmp;
	
// END of all_your_HDL_code

endmodule
