SUB1:    
		__asm("SUB %[res],%[in1],%[in2]" // tmp1 = tmp3 – tmp2;
						: [res] "=r" (tmp1)
						: [in1] "r" (tmp2), [in2] "r" (tmp3) );
SUB2:      
		__asm("SUB %[res],%[in1],%[in2]" // tmp3 = tmp1 – tmp2;
						: [res] "=r" (tmp3)
						: [in1] "r" (tmp2), [in2] "r" (tmp1) );
ADD1:    
		__asm("ADD %[res],%[in1],%[in2]"	 // tmp1 = tmp3 + tmp2; 
						: [res] "=r" (tmp1)
						: [in1] "r" (tmp2), [in2] "r" (tmp3) );
ADD2:      
		__asm("ADD %[res],%[in1],%[in2]"  // tmp3 = tmp1 + tmp2;
						: [res] "=r" (tmp3)
						: [in1] "r" (tmp2), [in2] "r" (tmp1) );

//---------------------------------------------------------------

LDR1:      
		__asm("LDR %[res],%[in1]" 			// tmp1 = *tmp4;
						: [res] "=r" (tmp1)
						: [in1] "m" (*tmp4)  );
LDR2:
		__asm("LDR %[res],%[in1]" 			// tmp3 = *tmp4;
						: [res] "=r" (tmp3)
						: [in1] "m" (*tmp4) );
STR1:
		__asm("STR %[res],%[in1]" 			// *tmp4 = tmp1;
						: [res] "=r" (tmp1)
						: [in1] "m" (*tmp4) );
STR2:
		__asm("STR %[res],%[in1]" 			// *tmp4 = tmp1;
						: [res] "=r" (tmp3)
						: [in1] "m" (*tmp4) );
