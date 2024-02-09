
; Vector Table Mapped to Address 0 at Reset

						PRESERVE8
                		THUMB

        				AREA	RESET, DATA, READONLY	  			; First 32 WORDS is VECTOR TABLE
        				EXPORT 	__Vectors
					
__Vectors		    	DCD		0x000003FF							; 1K Internal Memory
        				DCD		0x81 ;Reset_Handler
        				DCD		0  			
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD 	0
        				DCD		0
        				DCD		0
        				DCD 	0
        				DCD		0
        				
        				; External Interrupts
						        				
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
              
                AREA |.text|, CODE, READONLY
;Reset Handler
Reset_Handler	PROC
                GLOBAL Reset_Handler
                ENTRY

				LDR 	R1, =0x50000000		; LED/SW address
				LDR		R2, =0x000000FF		; pattern 1		
				LDR		R4, =0xFFFFFF		; value to determine the delay				

AGAIN		   	LDR		R5, [R1]			; load SW[9:0]
				EORS	R5, R2, R5			; XOR with FF => invert
				STR		R5, [R1]			; store LEDR[8:0]

				MOV		R0,R4				; some delay
Loop			SUBS	R0,R0,#1
				BNE Loop
				
				EORS	R5, R2, R5			; XOR with FF => invert again
				STR		R5, [R1]			; store LEDR[8:0]

				MOV		R0,R4				; some delay again
Loop1			SUBS	R0,R0,#1
				BNE Loop1

				B AGAIN
				ENDP

				ALIGN 		4						; Align to a word boundary

		END                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
   