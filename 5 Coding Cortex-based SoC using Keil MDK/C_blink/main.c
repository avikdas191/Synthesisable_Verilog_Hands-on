#include <stdint.h>
#define AHB_LED_BASE				0x50000000

int main(void) {
	uint32_t i, i1;
	uint32_t delay = 0x008FFFFF;
	
	for (i=0;i<3;i++)	{
		*(volatile uint32_t*) AHB_LED_BASE = 0xAA;
		for(i1=0;i1<delay;i1++);
		*(volatile uint32_t*) AHB_LED_BASE = 0x55;
		for(i1=0;i1<delay;i1++);		
	}	
	
	*(volatile uint32_t*) AHB_LED_BASE = 0x0F;	
	
	i = *(volatile uint32_t*) 0x51000000; // DCD returns HREADY = 1'b0;
	
	*(volatile uint32_t*) AHB_LED_BASE = 0xF0;	
	
	while(1);
	
}
