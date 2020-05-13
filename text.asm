
;===========================================================================================================================================================================			
;										Car Loading
;===========================================================================================================================================================================		 
AttenteConnexion                          PROC NEAR					;void AttenteConnexion()	{
							ReceiveCar				  EQU	   <WORD PTR[BP-4]>
							Etat_Attente			  EQU	   <WORD PTR[BP-2]>	

			
			 PUSH BP
			 MOV BP,SP
			 PUSH AX
			 
			 MOV Etat_Attente,0
			 
			 
			 MOV AH,02H
			 MOV DL,10					;printf("\n")
			 INT 21H
		
			 MOV AH,02H
			 MOV DL,13
			 INT 21h
			 
while_Att_Con:							;while(receive_Com != 100){
			 CMP ReceiveCar,100
			 JE ewhile_Att_Con
			
			 
			 MOV AH,02
			 MOV DL,08						;printf(08) //Efface le caractere precedent
			 INT 21h
			 
switch_Att_Con:			 					;switch(Etat_Attente)

switch_c_0:
			CMP Etat_Attente,0					;case 0:
			JNE eswitch_c_0

			MOV AH,02
			MOV DL,'/'							;printf('/')
			INT 21h
			
			MOV Etat_Attente,1
			JMP eswitch_Att_Con
eswitch_c_0:

switch_c_1:
			CMP Etat_Attente,1					;case 1:
			JNE eswitch_c_1

			MOV AH,02
			MOV DL,'|'							;printf('|')
			INT 21h
			
			MOV Etat_Attente,2
			JMP eswitch_Att_Con					;break
eswitch_c_1:

switch_c_2:										;case 2:
			 CMP Etat_Attente,2
			 JNE eswitch_c_2

			 MOV AH,02
			 MOV DL,'\'							;printf('\')
			 INT 21h
			 MOV Etat_Attente,0
			 JMP eswitch_Att_Con					;break;
eswitch_c_2:			 
			 
eswitch_Att_Con:			 
			 
			 PUSH ReceiveCar
			 CALL Receive_Com				;receive_Com(Receive_Com)
			 POP ReceiveCar
			 
			 JMP while_Att_Con				;}
ewhile_Att_Con:
			 POP AX	
			 MOV SP,BP
			 POP BP
			 RET										;return
	
AttenteConnexion                           ENDP 		;}	

;===========================================================================================================================================================================			
;									 Fin Car_Loading
;===========================================================================================================================================================================		 




;===========================================================================================================================================================================			
;										Debut Ecrire_Chaine
;===========================================================================================================================================================================		 
Ecrire_Chaine                           PROC NEAR					;void Ecrire_Chaine(msg)	{


					msg			  EQU	   <WORD PTR[BP+4]>		
	
			
			PUSH BP
			MOV BP,SP
			PUSH AX
	
			
			MOV AH,09h
			MOV DX,msg					;printf("%s",msg);
			INT 21H
					
			MOV AH,02H
			MOV DL,10					;printf("\n")
			INT 21H	
			
			MOV AH,02H
			MOV DL,13					;printf(13)
			INT 21h			
			
			POP AX	
			MOV SP,BP
			POP BP
			RET							;return
	
Ecrire_Chaine                           ENDP 		;}	

;===========================================================================================================================================================================			
;										Fin Ecrire_Chaine	
;===========================================================================================================================================================================		 
	
