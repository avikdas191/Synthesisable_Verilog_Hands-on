module AHB2LED(
	//AHBLITE INTERFACE	
		//Global Signals from the board
			input wire HCLK,
			input wire HRESETn,
		//Peripheral Select Signal (from DCD) - enables this peripheral
			input wire HSEL,			
		//HREADY system-wide signal (from MUX - can be used to pause operation of the peripheral)
			input wire HREADY,
		//host-to-peripherals signals
			input wire [31:0] HADDR,
			input wire [1:0] HTRANS,
			input wire HWRITE,
			input wire [2:0] HSIZE,
			input wire [31:0] HWDATA,
		//peripherals-to-MUX signals
			output wire HREADYOUT,
			output wire [31:0] HRDATA,
			
	//side band signals for the on board IOs
		//LED Output
			output wire [7:0] LED,
			output	[7:0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,		// SEG7, 6 pcs
		
		//SWitches input
			input wire	[9:0] SW
);

//Address Phase sampling registers - 5 registers in general, only three to use here
  reg rHSEL;
  reg [31:0] rHADDR; 
  reg [1:0] rHTRANS;
  reg rHWRITE;
  //reg [2:0] rHSIZE;	// not used here, we will use only the LSB of the HWDATA in all the cases
//Data Phase sampling register
  reg [7:0] rLED;
  
  reg [7:0] rHEX0;
  reg [7:0] rHEX1;
  reg [7:0] rHEX2;
  reg [7:0] rHEX3;
  reg [7:0] rHEX4;
  reg [7:0] rHEX5;
  reg [7:0] rHEX6;
  reg [7:0] rHEX7;
  
//Address Phase Sampling
  always @(posedge HCLK or negedge HRESETn)
  begin
	 if(!HRESETn)
	 begin		// RESET values 
		rHSEL		<= 1'b0 ;
		rHADDR	<= 32'b0;
		rHTRANS	<= 2'b0 ;
		rHWRITE	<= 1'b0 ;
		//rHSIZE	<= // not used here
	 end
    else if(HREADY)
    begin		// ... set the five registers from the input wires
      rHSEL		<= HSEL ;
		rHADDR	<= HADDR;
		rHTRANS	<= HTRANS ;
		rHWRITE	<= HWRITE ;
		//rHSIZE	<= // not used here
    end
  end

//Data Phase sampling/data transfer
  always @(posedge HCLK or negedge HRESETn) begin
    if(!HRESETn)
		begin
			rLED <= 8'hFF ;		// RESET values - all LEDs on
			rHEX0 <= 8'hFF;
			rHEX1 <= 8'hFF;
			rHEX2 <= 8'hFF;
			rHEX3 <= 8'hFF;
			rHEX4 <= 8'hFF;
			rHEX5 <= 8'hFF;
		end
    else if ( rHSEL & rHTRANS[1] & rHWRITE ) // ... AND gate condition
		case (rHADDR[2:0])
			0: rHEX0	<=	HWDATA[31:24];
			1: rHEX1	<=	HWDATA[31:24];
			2: rHEX2	<=	HWDATA[31:24];
			3: rHEX3	<=	HWDATA[31:24];
			4: rHEX4	<=	HWDATA[31:24];
			5: rHEX5	<=	HWDATA[31:24];
			6: rLED <= HWDATA[7:0];		// ... set the rLED to the LSB of HWDATA
		endcase
  end
  
  // ASSIGN section: drive HREADYOUT, HRDATA, LED wires (three assign Verilog statements)
  //HREADYOUT Single cycle Write & Read. Zero Wait state operations
  assign HREADYOUT = 1'b1 ; //
// setting AHB-Lite Read Data 
  assign HRDATA = {22'b0,SW} ;// return the full word with the 22 msb set to zero and 10 lsb set to SW
// drive the on board LEDs [7:0]  
  assign LED[7:0]= rLED ;
  assign HEX0[7:0] = rHEX0;
  assign HEX1[7:0] = rHEX1;
  assign HEX2[7:0] = rHEX2;
  assign HEX3[7:0] = rHEX3;
  assign HEX4[7:0] = rHEX4;
  assign HEX5[7:0] = rHEX5;
  
endmodule

