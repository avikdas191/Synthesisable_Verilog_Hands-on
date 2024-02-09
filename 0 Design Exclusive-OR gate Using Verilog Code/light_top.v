module light_top (x1, x2, f);
//module light_top (x1, f);

	input x1, x2;
//	input x1;
	
	output f;
	
//	assign f = (x1 & ~x2)|(~x1 & x2);
	assign f = x1 | x2;
	
endmodule