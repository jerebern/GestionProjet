;============================================================================

         .MODEL    small          ; 
         .STACK    512            ; Taille de la pile

;============================================================================
		.DATA
		
		frequency dw 9121,8609,8126,7670,7239,6833,6449,6087,5746,5423,5119,4831,4560,4304,4063,3834,3619,3416,3224,3043,2873,2711,2559,2415,2280,2152,2031,1917,1809,1715,1612,1521,1436,1355,1292
		;IndexFreStr db "C $","C# $","D $","D# $","E $","F $","F #$","G $","G# $","A $","A# $","B $"
		
		car db 0
		index dw 0
		
		
		
		

	   .CODE
		 

 
        ; MOV       DS, AX

listing: MOV       AX, @DATA
		 mov DS,AX



while1:		 

			 MOV 	   AH, 08
			 INT        33			  			;car = getchar();
			 MOV        car, AL


			 
if_1:			cmp car,'H'
				JNE eif_1
				inc index
				
				
eif_1:

if_2:			cmp car,'P'
				JNE eif_2
				dec index
				

eif_2:	

ifIndex:

				CMP index,25
				JL eifIndex
				mov index,0


eifIndex:

ifIndex2:

				CMP index,0
				JG eifIndex2
				mov index,25


eifIndex2:

			MOV DX,index
			add dx,'0'

			 MOV AH,02
			 int 33




			
			mov     al, 182         ; Prepare the speaker for the
			out     43h, al         ;  note.
			MOV si,index
			mov     ax,frequency[si]          ; Frequency number (in decimal)
                                ;  for middle C.
			out     42h, al         ; Output low byte.
			mov     al, ah          ; Output high byte.
			out     42h, al 
			in      al, 61h         ; Turn on note (get value from
                                ;  port 61h).
			or      al, 00000011b   ; Set bits 1 and 0.
			out     61h, al         ; Send new value.
			mov     bx, 25          ; Pause for duration of note.

		
		JMP while1
endwhile1:

		
		;============================================================================
eop:     MOV       AX, 4C00h
         INT       33

         END       listing