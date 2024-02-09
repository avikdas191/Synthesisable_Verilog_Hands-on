module AHB2LED(
	//AHBLITE INTERFACE	
		//Global Signals from the board
			input wire HCLK,
			input wire HRESETn,
		//Slave Select Signal (from DCD)
			input wire HSEL,			
		//HREADY system-wide signal (from MUX)
			input wire HREADY,
		//master-to-slaves signals
			input wire [31:0] HADDR,
			input wire [1:0] HTRANS,
			input wire HWRITE,
			input wire [2:0] HSIZE,
			input wire [31:0] HWDATA,
		//slave-to-MUX signals
			output wire HREADYOUT,
			output wire [31:0] HRDATA,
			
	//on board IOs
		//LED Output
			output wire [7:0] LED,
		//SWitches input
			input wire	[9:0] SW
);

//Address Phase sampling registers - 5 register in general, only three to use here
  reg rHSEL;
  //reg [31:0] rHADDR; // not used, LED will be set after write to any selected 16 MB addess
  reg [1:0] rHTRANS;
  reg rHWRITE;
  //reg [2:0] rHSIZE;	// not used, we will use the LSB in all the cases
//Data Phase sampling register
  reg [7:0] rLED;
 
//Address Phase Sampling
  always @(posedge HCLK or negedge HRESETn)
  begin
	 if(!HRESETn)
	 begin		// RESET values 
		rHSEL		<= 1'b0;
		//rHADDR	<= 32'h0; // not used
		rHTRANS	<= 2'b00;
		rHWRITE	<= 1'b0;
		//rHSIZE	<= 3'b000; // not used
	 end
    else if(HREADY)
    begin		// ... set the five registers from the input wires
		_?_
		_?_
		_?_
    end
  end

//Data Phase sampling/data transfer
  always @(posedge HCLK or negedge HRESETn) begin
    if(!HRESETn)
      rLED <= 8'hFF;		// RESET values - all LEDs on
    else if ( _?_ ) // ... AND gate condition 
      rLED <= _?_ ;	// ... set the rLED
  end

  
  // ASSIGN section: drive HREADYOUT, HRDATA, LED wires (three assign Verilog statements)
  //HREADYOUT Single cycle Write & Read. Zero Wait state operations
  assign HREADYOUT = _?_; //
// setting AHB-Lite Read Data 
  assign HRDATA = _?_ ; // return the full word with the 22 msb set to zero
// drive on board LEDs  
  assign LED[7:0]= _?_;

endmodule

