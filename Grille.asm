;
;============================================================================
;			DESSIN DE GRILLE 10 X 10 
;
;				JEREMY BERNARD 
;					
;					DEBUT
;				  2020-01-23
;					FIN
;				  
;============================================================================



         .MODEL    small          ; 
         .STACK    512            ; Taille de la pile

;============================================================================
		.DATA
		
			DimX					DW	200
			DimY					DW	320
		
	
			PosCursUserX			DW 1
			PosCursUserY			DW 1
			OldPosCursUserX			DW 0
			OldPosCursUserY			DW 0
			
			PositionGrille			DW 0
		
		
			VieilleCouleur			DW 0
			NouvelleCouleur 		DW 0
			
			TRASH					DW 0
			
			Action					DW 0
			
			RX						DW 0
			RxNonValide				DW 1
			
			
			;MESSAGE
			
			MessageInitEcran		DB 'Choisir un Mode Graphique : $'
			MessageInitCGA			DB '1.CGA$'
			MessageInitTandy		DB '2.Tandy / PCJR$'			
			MessageInitVGA			DB '3.VGA$'
			MessageAttenteConnexion	DB 'En Attente Du Serveur connecte COM1$'
			
		

	   .CODE
;===========================================================================================================================================================================			
;											MAIN
;===========================================================================================================================================================================		 


listing: 	MOV AX, @DATA
			MOV DS,AX
			
			true EQU 1								;#define true 1
			false EQU 0								;#define false 
		
			CALL Init_Com
			

			MOV DX,OFFSET MessageAttenteConnexion
			PUSH DX
			CALL Ecrire_Chaine						;Ecrire_Chaine(MessageAttenteConnexion)
			POP Trash
			
			;CALL AttenteConnexion					;//A METTRE EN COMMENTAIRE SI ON VEUT TESTTER
						
		
			MOV DX, OFFSET MessageInitEcran
			PUSH DX
			CALL Ecrire_Chaine						;Ecrire_Chaine(MessageInitEcran)
			POP TRASH				
						
			MOV DX, OFFSET MessageInitCGA			;Ecrire_Chaine(MessageInitCGA)
			PUSH DX
			CALL Ecrire_Chaine
			POP TRASH				
			
			MOV DX, OFFSET MessageInitTandy			;Ecrire_Chaine(MessageInitTandy)
			PUSH DX
			CALL Ecrire_Chaine
			POP TRASH

			MOV DX, OFFSET MessageInitVGA				
			PUSH DX
			
			CALL Ecrire_Chaine						;Ecrire_Chaine(MessageInitVGA)
			POP TRASH	

			CALL InitEcran							;void InitEcran()
			
			
			push DimX
			push DimY
			CALL DessinDeLaGrille			;DessinDeLaGrille(ResDimY,ResDimX);
			pop TRASH
			pop Trash
			
			MOV AX,43
			PUSh AX
			CALL PlaceAttack
			POP TRASH
Do:		

Do_while_Attente_Car_Valide:					;Do{		
			
			PUSH RX
			Call receive_Com					;receive_Com(&RxCar); // LE JEU COMMENCE PAR ATTENDRE UN CAR POUR SAVOIR QUAND CES A SON TOUR 
			POP RX
			;CMP RX, 0
			;JL Do_while_Attente_Car_Valide
			;CMP Rx, 107
			;JG Do_while_Attente_Car_Valide		; }while (Rx < 0 || Rx > 107);
	
			PUSH RxNonValide
			PUSH RX
			CALL Analyse_RxCom					;RxNonValide = Analyse_RxCom(RxNonValide,RX)
			POP Trash
			POP RxNonValide
			
ewhile_Attente_Car_Valide:					
			
;switch_RX_ACT:												;switch(Analyse_RxCom)	

;switch_RX_c_1:
;			CMP 
;eswitch_RX_c_1:		
			


			PUSH Action
			PUSH PositionGrille
			PUSH PosCursUserX
			PUSH PosCursUserY
			CALL GetKeybordInput			;GetKeybordInput(Action,PositionGrille,&PosX,&PosY);
			POP  PosCursUserY
			POP  PosCursUserX
			POP  PositionGrille
			POP  Action
	
if_main_1:									;if(Action == ' '){
			MOV AX,Action
		    CMP AL,' '
			JNE e_if_main_1

			PUSH PosCursUserY
			PUSH PosCursUserX	
			CALL PlaceUnit					;PlaceUnit(POSX,POSY)
			POP Trash
			POP Trash
					
			PUSH PositionGrille
			CALL Send_Com					;send_Com(Action)
			POP trash
					
			MOV RxNonValide,true
whileMain2:									;while(RxNonValide){
			CMP RxNonValide,true
			JNE e_whileMain2
		

			
		
			JMP whileMain2

e_whileMain2:								;}

e_if_main_1:								;}
			MOV AX, Action
			CMP AL,'.'
			JE e_while1
			JMP Do
e_while1:			
			



eop:     MOV       AX, 4C00h
		 INT       33

;===========================================================================================================================================================================			
;											FIN MAIN
;===========================================================================================================================================================================
		INCLUDE com.asm
		INCLUDE Graphic.asm
		INCLUDE text.asm



;===========================================================================================================================================================================		
;											FIN	PROGRAMME
;===========================================================================================================================================================================

         END       listing