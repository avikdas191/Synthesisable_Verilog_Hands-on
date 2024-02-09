#include <stdint.h>
#define AHB_LED_BASE				(uint8_t*) 0x50000000  // address of the LED peripheral in the SoC

int main(void) {
	
	uint8_t *ptr = AHB_LED_BASE; // pointer to the LED peripheral location
	uint8_t tmp; 								// temporary 

	while (1)	{
		tmp = *ptr; 								// read the value of all the switches; and address within 16 MB is valid
		
		// subsequent byte addresses        					constants from the lab 3_3, C does not accepts binary		
		
		*(ptr+0) = 0x90; 						// for displying '9' on HEX0   8'b10010000
		*(ptr+1) = 0xB0; 						// for displying '3' on HEX1   8'b10110000		
		*(ptr+2) = 0xB0; 						// for displying '3' on HEX2   8'b10110000
		*(ptr+3) = 0x99; 						// for displying '4' on HEX3   8'b10011001	
		*(ptr+4) = 0xB0; 						// for displying '3' on HEX4   8'b10110000
		*(ptr+5) = 0xC0; 						// for displying '0' on HEX5   8'b11000000
		
		*(ptr+6) = tmp;							// write back SWs to the LEDRs, could do simply   *(ptr+6) = *ptr;				
	}
	
}

//		Default
		//*(ptr+0) = 0xF9; 						// for displying '1' on HEX0   8'b11111001
		//*(ptr+1) = 0xA4; 						// for displying '2' on HEX1   8'b10100100		
		//*(ptr+2) = 0x24; 						// for displying '2' on HEX2   8'b10100100 + leading zero for .
		//*(ptr+3) = 0xF9; 						// for displying '1' on HEX3   8'b11111001	
		//*(ptr+4) = 0x19; 						// for displying '4' on HEX4   8'b10011001 + leading zero for .
		//*(ptr+5) = 0xA4; 						// for displying '2' on HEX5   8'b10100100	

//		Michelle
//		*(ptr+0) = 0xC0; 						// for displying '0' on HEX0   8'b11000000
//		*(ptr+1) = 0x92; 						// for displying '5' on HEX1   8'b10010010		
//		*(ptr+2) = 0x80; 						// for displying '8' on HEX2   8'b10000000 + leading zero for .
//		*(ptr+3) = 0xF9; 						// for displying '1' on HEX3   8'b11111001	
//		*(ptr+4) = 0xC0; 						// for displying '0' on HEX4   8'b11000000 + leading zero for .
//		*(ptr+5) = 0xC0; 						// for displying '0' on HEX5   8'b11000000	