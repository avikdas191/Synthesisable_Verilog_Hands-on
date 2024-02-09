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
		//SWitches input
			input wire	[9:0] SW
);

//Address Phase sampling registers - 5 registers in general, only three to use here
  reg rHSEL;
  //reg [31:0] rHADDR; // not used here, LED will be set after write to any address within selected 16 MB 
  reg [1:0] rHTRANS;
  reg rHWRITE;
  //reg [2:0] rHSIZE;	// not used here, we will use only the LSB of the HWDATA in all the cases
//Data Phase sampling register
  reg [7:0] rLED;
 
//Address Phase Sampling
  always @(posedge HCLK or negedge HRESETn)
  begin
	 if(!HRESETn)
	 begin		// RESET values 
		rHSEL		<= 1'b0 ;
		//rHADDR	<= // not used here
		rHTRANS	<= 2'b0 ;
		rHWRITE	<= 1'b0 ;
		//rHSIZE	<= // not used here
	 end
    else if(HREADY)
    begin		// ... set the five registers from the input wires
      rHSEL		<= HSEL ;
		//rHADDR	<= // not used here
		rHTRANS	<= HTRANS ;
		rHWRITE	<= HWRITE ;
		//rHSIZE	<= // not used here
    end
  end

//Data Phase sampling/data transfer
  always @(posedge HCLK or negedge HRESETn) begin
    if(!HRESETn)
      rLED <= 8'b_1111_1111 ;		// RESET values - all LEDs on
    else if ( rHSEL & rHTRANS[1] & rHWRITE ) // ... AND gate condition 
      rLED <= HWDATA[7:0] ;	// ... set the rLED to the LSB of HWDATA
  end

  
  // ASSIGN section: drive HREADYOUT, HRDATA, LED wires (three assign Verilog statements)
  //HREADYOUT Single cycle Write & Read. Zero Wait state operations
  assign HREADYOUT = 1'b1 ; //
// setting AHB-Lite Read Data 
  assign HRDATA = {22'b0,SW[9:0]} ; // return the full word with the 22 msb set to zero and 10 lsb set to SW
// drive the on board LEDs [7:0]  
  assign LED[7:0]= rLED ;

endmodule

