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
	
// END of do_not_remove_code

// all_your_HDL_code BEGIN
	// blank out the unused displays - comment the one YOU need to use (here HEX3)
		assign HEX5 = 8'b_1111_1111;
		assign HEX4 = 8'b_1111_1111;
		assign HEX2 = 8'b_1111_1111;
		//assign HEX3 = 8'b_1111_1111;
		assign HEX1 = 8'b_1111_1111;
		assign HEX0 = 8'b_1111_1111;
		
		assign HEX3 = { 2 {SW[9:6]} }; // test pattern used to get the solution

	// declare a temporary 8 bits register to use within the always block, e.g. r_7LED
	
	// 1. write a definition of the asynchronous procedural block (2 lines)
	// 	2. then insert the case statement inside the procedural block as appropriate (2 lines)
	// 		3. then insert 16 case lines to drive the display for all the possible HEX digits inside the case statement
	//			(make sure that the decimal point (segment 7) is ON when the displayed value exceeds 9)
	// 		4. add the default line inside the case statement (blank out the display)

		
	// assign your display to be driven from the temporary register, e.g. assign HEX3 = r_7LED;
	
// END of all_your_HDL_code

endmodule
