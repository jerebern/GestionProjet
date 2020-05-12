;Le code viens de ce site:
;muruganad.com/8086/8086-assembly-language-program-to-play-sound-using-pc-speaker.html
		;frequency dw 9121,8609,8126,7670,7239,6833,6449,6087,5746,5423,5119,4831,4560,4304,4063,3834,3619,3416,3224,3043,2873,2711,2559,2415,2280,2152,2031,1917,1809,1715,1612,1521,1436,1355,1292
		;IndexFreStr db "C $","C# $","D $","D# $","E $","F $","F #$","G $","G# $","A $","A# $","B $"

;===========================================================================================================================================================================			
;										Make Sound
;===========================================================================================================================================================================
make_sound                          PROC NEAR					;void Send_Com(action_note)	{


	
					Action_Note			  EQU	   <WORD PTR[BP+4]>		
			
			 PUSH BP
			 MOV BP,SP
			 PUSH AX
			
	 
			 
			 MOV     AL, 182         ;	Prepare le Speaker
			 OUT     43H, AL         ;  NOTE.

        	 MOV     AX,ACTION_Note          ; Frequence en decinal
  			 OUT     42H, AL         ; OUTPUT LOW BYTE.
			 MOV     AL, AH          ; OUTPUT HIGH BYTE.
			 OUT     42H, AL 
			 IN      AL, 61H         ; TURN ON NOTE (GET VALUE FROM
									;  PORT 61H).
		 	 OR      AL, 00000011B   ; SET BITS 1 AND 0.
			 OUT     61H, AL         ; SEND NEW VALUE.
			 MOV     BX, 25          ; Pause for duration of note.			 
			
.pause1:
			 MOV     CX, 10000
.pause2:
			 DEC     CX
			 JNE     .pause2
			 DEC     BX
			 JNE     .pause1
			 IN      AL, 61h         ; Turn off note (get value from
                                ;  port 61h).
			 AND     AL, 11111100b   ; Reset bits 1 and 0.
			 OUT     61h, AL         ; Send new value.

			 POP AX	
			 MOV SP,BP
			 POP BP
			 RET										;return
	
make_sound                           	ENDP 		;}	


;===========================================================================================================================================================================			
;										Fin Make Sound
;===========================================================================================================================================================================



