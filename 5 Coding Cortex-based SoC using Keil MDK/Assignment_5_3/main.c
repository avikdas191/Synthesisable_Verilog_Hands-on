#include <stdint.h>
#define AHB_LED_BASE				(uint32_t*) 0x50000000  // address of the LED peripheral in the SoC

int main(void) {
	
	uint32_t *ptr = AHB_LED_BASE; // pointer to the LED peripheral location
	uint32_t tmp, A, B, C; 				// temporary and required variables

	while (1)	{
		tmp = *ptr; 								// read the value of all the switches and pushbuttons
		B = tmp & 0x38;   // mask off all the unnecessary bits; 0x38 means 0_000_111_000 		 
																	// all the bits except for the SW[5:3] ones will become zeroes
																	// but these three bits (where 1 was used in the mask) will remain
		B = B >> 3;  				// finally we need to shift right the required bits

		// to get A, you will need to use the mask 0_111_000_000 - convert this binary value to hexadecimal, 
		// and shift to the right by 6 bits
		A = tmp & 0x1C0;
		A = A >> 6;
		
		// to get C, you will need to use the mask 0_000_000_111 - convert this binary value to hexadecimal, 
		// no shift to the right is required here		
		C = tmp & 0x7;
					
		*ptr = (~ (A ^ B) ^ C) & 0x7;		// show these three bits on the LEDRs
	}
} 

//0_111_111_111 0x1FF