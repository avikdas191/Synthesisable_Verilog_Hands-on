//////////////////////////////////////////////////////////////////////////////////
//END USER LICENCE AGREEMENT                                                    //
//                                                                              //
//Copyright (c) 2012, ARM All rights reserved.                                  //
//                                                                              //
//THIS END USER LICENCE AGREEMENT (LICENCE) IS A LEGAL AGREEMENT BETWEEN      //
//YOU AND ARM LIMITED ("ARM") FOR THE USE OF THE SOFTWARE EXAMPLE ACCOMPANYING  //
//THIS LICENCE. ARM IS ONLY WILLING TO LICENSE THE SOFTWARE EXAMPLE TO YOU ON   //
//CONDITION THAT YOU ACCEPT ALL OF THE TERMS IN THIS LICENCE. BY INSTALLING OR  //
//OTHERWISE USING OR COPYING THE SOFTWARE EXAMPLE YOU INDICATE THAT YOU AGREE   //
//TO BE BOUND BY ALL OF THE TERMS OF THIS LICENCE. IF YOU DO NOT AGREE TO THE   //
//TERMS OF THIS LICENCE, ARM IS UNWILLING TO LICENSE THE SOFTWARE EXAMPLE TO    //
//YOU AND YOU MAY NOT INSTALL, USE OR COPY THE SOFTWARE EXAMPLE.                //
//                                                                              //
//ARM hereby grants to you, subject to the terms and conditions of this Licence,//
//a non-exclusive, worldwide, non-transferable, copyright licence only to       //
//redistribute and use in source and binary forms, with or without modification,//
//for academic purposes provided the following conditions are met:              //
//a) Redistributions of source code must retain the above copyright notice, this//
//list of conditions and the following disclaimer.                              //
//b) Redistributions in binary form must reproduce the above copyright notice,  //
//this list of conditions and the following disclaimer in the documentation     //
//and/or other materials provided with the distribution.                        //
//                                                                              //
//THIS SOFTWARE EXAMPLE IS PROVIDED BY THE COPYRIGHT HOLDER "AS IS" AND ARM     //
//EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING     //
//WITHOUT LIMITATION WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR //
//PURPOSE, WITH RESPECT TO THIS SOFTWARE EXAMPLE. IN NO EVENT SHALL ARM BE LIABLE/
//FOR ANY DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, OR CONSEQUENTIAL DAMAGES OF ANY/
//KIND WHATSOEVER WITH RESPECT TO THE SOFTWARE EXAMPLE. ARM SHALL NOT BE LIABLE //
//FOR ANY CLAIMS, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, //
//TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE    //
//EXAMPLE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE EXAMPLE. FOR THE AVOIDANCE/
// OF DOUBT, NO PATENT LICENSES ARE BEING LICENSED UNDER THIS LICENSE AGREEMENT.//
//////////////////////////////////////////////////////////////////////////////////

module AHBLITE_SYS(
	//Global signals
	//////////// CLOCK //////////
	input 		          	ADC_CLK_10,
	input 		          	MAX10_CLK1_50,
	input 		          	MAX10_CLK2_50,
	input		wire	[1:0]		KEY, 
	//on board LEDs
	// output 	wire	[8:0] 	LEDG, // DE2-115 only
	output 	wire	[9:0]	LEDR,  		// DE2-115 [17:0]
	//on board SWitches
	input		wire	[9:0]	SW				// DE2-115 [17:0]	
);


//AHB-LITE 13 wires for the CPU - to be connected to the modules' ports using .*
	//Global Signals
	wire 				HCLK;
	wire 				HRESETn;
	//Address, Control & Write Data Signals
	wire [31:0]		HADDR;
	wire [31:0]		HWDATA;
	wire 				HWRITE;
	wire [1:0] 		HTRANS;
	wire [2:0] 		HBURST;		// output not wired
	wire 				HMASTLOCK;  // output not wired
	wire [3:0] 		HPROT;		// output not wired
	wire [2:0] 		HSIZE;
	//Transfer Response & Read Data Signals
	wire [31:0] 	HRDATA;
	wire 				HRESP;
	wire 				HREADY;
	
//CM0-DS Sideband signals
wire 				LOCKUP;
wire 				TXEV;			// output not wired
wire 				SLEEPING;	// output not wired
wire [15:0]		IRQ;			

//wires for the peripherals	
//SELECT SIGNALS
wire [3:0] 		MUX_SEL;
wire 				HSEL_MEM;
wire 				HSEL_LED;
wire				HSEL_NOMAP;
//DATA from the peripherals
wire [31:0] 	HRDATA_MEM;
wire [31:0] 	HRDATA_LED;
//HREADYOUT from the peripherals
wire 				HREADYOUT_MEM;
wire 				HREADYOUT_LED;


// behavioural code section - wiring up some input ports with constants

//SYSTEM GENERATES NO ERROR RESPONSE (HRESP)
assign 	HRESP = 1'b0;	// HARD FAULT interrupt - we do not use it

// using DE10-Lite on board resources
// use of on board push buttons
assign 	HRESETn = KEY[0];	// Press KEY[0] to RESET
assign 	IRQ = {15'b0000_0000_0000_0000, ~KEY[1]};  // Press KEY[1] to request the INT0 interrupt
			//first 15 CM0-DS Interrupt ReQuests (IRQs) are not used  

// use of the on board LEDs
assign 	LEDR[9] = LOCKUP;					// HREADY is low => CPU waits and asserts LOCKUP
assign 	LEDR[8] = 1'b0;					// unused LED off	
// LEDR[7:0] are wired to the LED port of the AHB2LED module


//#! Altera specific clock buffer - connects on board oscillator to the FPGA's clock tree
ALTCLKCTRL BUFF_CLK(
	.inclk	 	(MAX10_CLK1_50),
	.outclk		(HCLK)
);

//CM0-DS: instantiation and wiring
CORTEXM0DS u_cortexm0ds (
//AHB-LITE wires 					// wire all the 13 ports as appropriate - now wired by SystemVerilog .*
	//Global Signals
	//.HCLK        (HCLK),
	//.HRESETn     (HRESETn), 
	//Address, Control & Write Data	
	//.HADDR       (HADDR[31:0]),
	//.HBURST      (HBURST[2:0]),
	//.HMASTLOCK   (HMASTLOCK),
	//.HPROT       (HPROT[3:0]),
	//.HSIZE       (HSIZE[2:0]),
	//.HTRANS      (HTRANS[1:0]),
	//.HWDATA      (HWDATA[31:0]),
	//.HWRITE      (HWRITE),
	//Transfer Response & Read Data	
	//.HRDATA      (HRDATA[31:0]),			
	//.HREADY      (HREADY),					
	//.HRESP       (HRESP),
	.*,       // SystemVerilog shortcut - here replaces 13 lines above

//CM0 Sideband Signals - wire 4 input ports as appropriate and leave 3 unused output ports not connected !!!
	.NMI         ( 1'b0 ),			
	.IRQ         ( IRQ ),
	.TXEV        (  ),				
	.RXEV        ( 1'b0 ),
	.LOCKUP      ( LOCKUP ),
	.SYSRESETREQ (  ),
	.SLEEPING    (  )
);

//Address Decoder 

AHBDCD uAHBDCD (			// wire all the marked 5 ports as appropriate !!!
	//AHBLITE input signal
	.HADDR( HADDR ),	// wire as appropriate
	 
	.HSEL_S0( HSEL_MEM ), 	// wire as appropriate
	.HSEL_S1( HSEL_LED ),	// wire as appropriate
	.HSEL_S2(),				// leave these output ports not connected
	.HSEL_S3(),
	.HSEL_S4(),
	.HSEL_S5(),
	.HSEL_S6(),
	.HSEL_S7(),
	.HSEL_S8(),
	.HSEL_S9(),
	.HSEL_NOMAP( HSEL_NOMAP ),	// wire as appropriate
	 
	.MUX_SEL( MUX_SEL )		// wire as appropriate
);

//Slave to Master Mulitplexor

AHBMUX uAHBMUX (	// wire all the marked 9 ports as appropriate !!!
	//AHBLITE input signals
	.HCLK( HCLK ),				// wire as appropriate
	.HRESETn( HRESETn ),		// wire as appropriate
	.MUX_SEL( MUX_SEL ),	// wire as appropriate
	 
	.HRDATA_S0( HRDATA_MEM ),	// wire as appropriate
	.HRDATA_S1( HRDATA_LED ),	// wire as appropriate
	.HRDATA_S2(),				// leave these output ports not connected
	.HRDATA_S3(),				
	.HRDATA_S4(),
	.HRDATA_S5(),
	.HRDATA_S6(),
	.HRDATA_S7(),
	.HRDATA_S8(),
	.HRDATA_S9(),
	.HRDATA_NOMAP(32'hDEADBEEF),  // can be used for diagnostics
	 
	.HREADYOUT_S0( HREADYOUT_MEM ),	// wire as appropriate
	.HREADYOUT_S1( HREADYOUT_LED ),	// wire as appropriate
	.HREADYOUT_S2( 1'b0 ),				// wire 1'b0 here and below to lock up the system if wrong address is generated
	.HREADYOUT_S3( 1'b0 ),
	.HREADYOUT_S4( 1'b0 ),
	.HREADYOUT_S5( 1'b0 ),
	.HREADYOUT_S6( 1'b0 ),
	.HREADYOUT_S7( 1'b0 ),
	.HREADYOUT_S8( 1'b0 ),
	.HREADYOUT_S9( 1'b0 ),
	.HREADYOUT_NOMAP( 1'b0 ),

	//AHBLITE output signals to the CPU	
	.HRDATA( HRDATA ),			// wire as appropriate
	.HREADY( HREADY )					// wire as appropriate
);

// AHBLite Peripherals

//AHBLite peripheral - memory 
AHB2MEM uAHB2MEM (	// wire all the 11 ports as appropriate - now 8 ports are wired by SystemVerilog .* !!!
	//AHBLITE input signals
	.HSEL( HSEL_MEM ),
	
	//.HCLK(HCLK), 
	//.HRESETn(HRESETn), 
	//.HREADY(HREADY),     
	//.HADDR(HADDR),
	//.HTRANS(HTRANS[1:0]), 
	//.HWRITE(HWRITE),
	//.HSIZE(HSIZE),
	//.HWDATA(HWDATA[31:0]), 
	.*,       // SystemVerilog shortcut - here replaces the 8 lines above

	//AHBLITE output signals to the multiplexor		
	.HRDATA( HRDATA_MEM ), 
	.HREADYOUT( HREADYOUT_MEM )
	
	//Sideband Signals - none
	
);

//AHBLite peripheral - LEDs & SWs 
AHB2LED uAHB2LED (	// wire all the 13 ports as appropriate - now 8 ports are wired by SystemVerilog .*  !!!
	//AHBLITE input Signals
	.HSEL( HSEL_LED ),
	
//	.HCLK(HCLK), 
//	.HRESETn(HRESETn), 
//	.HREADY(HREADY),     
//	.HADDR(HADDR),
//	.HTRANS(HTRANS[1:0]), 
//	.HWRITE(HWRITE),
//	.HSIZE(HSIZE),
//	.HWDATA(HWDATA[31:0]), 
	.*,       // SystemVerilog shortcut - here replaces 8 lines above
	
	//AHBLITE output signals to the multiplexor	
	.HRDATA( HRDATA_LED ), 
	.HREADYOUT( HREADYOUT_LED ),
	
	//Sideband Signals to the on board IOs
	.LED( LEDR[7:0] ),	
	.SW( SW[9:0] )
);


endmodule
