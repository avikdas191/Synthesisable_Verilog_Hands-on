module SevSeg(
	input  wire [3:0] HEX_disp,
	output wire [7:0] segments
);

	reg [7:0] r_7LED; // for an LHS of the procedural block
	always @(*) begin // procedural block to use case

		case ( HEX_disp )
			// value – either bit slice or bit concatenation
			4'b0000: r_7LED = 8'b_1_100_0000;	// for 0
			4'b0001: r_7LED = 8'b_1_111_1001;	// for 1
			4'b0010: r_7LED = 8'b_1_010_0100;	// for 2
			4'b0011: r_7LED = 8'b_1_011_0000;	// for 3 
			4'b0100: r_7LED = 8'b_1_001_1001;	// for 4 
			4'b0101: r_7LED = 8'b_1_001_0010;	// for 5 
			4'b0110: r_7LED = 8'b_1_000_0010;	// for 6 
			4'b0111: r_7LED = 8'b_1_111_1000;	// for 7 
			4'b1000: r_7LED = 8'b_1_000_0000;	// for 8 
			4'b1001: r_7LED = 8'b_1_001_0000;	// for 9 
			4'b1010: r_7LED = 8'b_0_000_1000;	// for A 
			4'b1011: r_7LED = 8'b_0_000_0011;	// for B 
			4'b1100: r_7LED = 8'b_0_100_0110;	// for C 
			4'b1101: r_7LED = 8'b_0_010_0001;	// for D 
			4'b1110: r_7LED = 8'b_0_000_0110;	// for E 
			4'b1111: r_7LED = 8'b_0_000_1110;	// for F 
			default: r_7LED = 8'b_1_111_1111;	// blank

		endcase
	end
	assign segments = r_7LED; // to drive the output port

endmodule 