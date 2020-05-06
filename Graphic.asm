;===========================================================================================================================================================================			
;											Init Ecran
;						http://stanislavs.org/helppc/int_10-0.html
;
;
;===========================================================================================================================================================================		 
InitEcran                           PROC NEAR					;void InitEcran()	{

					Continuer	  EQU 	   <WORD PTR[BP-4]>		
					Key			  EQU	   <WORD PTR[BP-2]>		
	
			
			PUSH BP
			MOV BP,SP
			PUSH AX
			PUSH BX
			PUSH CX
			PUSH DX	
			
			MOV Continuer,0;
			
DowhileInitEcran:									;Do{	
			
			
			MOV AH,08								;KEY = GetChar();
			INT 21h
			MOV Key,AX
			
switch_InitEcran:													;switch(key){
													
caseInitEcran1:
				MOV AX,Key
				CMP AL,'1'
				JNE ecaseInitEcran1
				
				MOV AX,04h 						;INITIALISE EN MODE 320x200 4 color graphics (CGA,EGA,MCGA,VGA)
				INT 10H	
				MOV Continuer,1				;Continuer = true
				JMP eswitch_InitEcran
													
ecaseInitEcran1:																										

caseInitEcran2:
				MOV AX,Key
				CMP AL,'2'
				JNE ecaseInitEcran2
				
				MOV AX,09h 						;INITIALISE EN MODE 320x200 16 color graphics (PCjr)
				INT 10H	

				MOV Continuer,1				;Continuer = true
				JMP eswitch_InitEcran				
													
ecaseInitEcran2:

caseInitEcran3:
				MOV AX,Key
				CMP AL,'3'
				JNE ecaseInitEcran3
				
				MOV AX,13h 						;INITIALISE EN MODE 320x200 256 color graphics (MCGA,VGA)
				INT 10H		
				MOV Continuer,1				;Continuer = true				
				JMP eswitch_InitEcran				
													
ecaseInitEcran3:													
													
													
eswitch_InitEcran:													;}
			
				CMP Continuer,true
				JNE DowhileInitEcran
				JMP eDowhileInitEcran
eDowhileInitEcran:							;while(!Continuer)						;}		
			
			POP DX
			POP CX
			POP BX
			POP AX
		
			MOV SP,BP
			POP BP
			RET										;return
	
InitEcran                           ENDP 		;}			
			
		
			
;===========================================================================================================================================================================			
;										Fin Init Ecran
;===========================================================================================================================================================================		 
		
;===========================================================================================================================================================================			
;											DESSINE DE GRILLE
;===========================================================================================================================================================================		
DessinDeLaGrille                            PROC NEAR		;void DessinDeLaGrille(ResDimY,ResDimX)	{


					PositionCurseurTraceurX			  EQU	   <WORD PTR[BP-4]>				 
					PositionCurseurTraceurY			  EQU	   <WORD PTR[BP-2]>				
			
					ResDimY			 				  EQU	   <WORD PTR[BP+4]>
					ResDimX			 				  EQU	   <WORD PTR[BP+6]>
					
			
			
			
			PUSH BP
			MOV BP,SP
			PUSH AX
			PUSH BX
			PUSH CX
			PUSH DX			
			
			;////PREMIERE PARTIE DU DESSIN \\\\\\\ 
			
			
			
			MOV PositionCurseurTraceurX,0			;int PositionCurseurTraceurX = 0
			MOV PositionCurseurTraceurY,0			;int PositionCurseurTraceurY = 0
			
			
			MOV PositionCurseurTraceurX,0
for_DimX_Dessin_Grille1:							;for(PositionCurseurTraceurX = 0; PositionCurseurTraceurX < ResDimX; PositionCurseurTraceurX + 20){
			
			MOV AX,ResDimX
			CMP PositionCurseurTraceurX,AX
			JGE e_for_DimX_Dessin_Grille1
			
			MOV PositionCurseurTraceurY,0
for_DimY_Dessin_Grille1 : 						;for(PositionCurseurTraceurY = 0; PositionCurseurTraceurY < ResDimY; PositionCurseurTraceurY + 1){			
			
			MOV AX,ResDimY
			CMP PositionCurseurTraceurY,AX
			JGE e_for_DimY_Dessin_Grille1
			
			MOV AH,0CH							;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,02H							;Couleur
			MOV CX,PositionCurseurTraceurY		;Position Pixel selon la colone
			MOV DX,PositionCurseurTraceurX		;Position Pixel selon la range
			INT 10H
			
			ADD PositionCurseurTraceurY,1	
			JMP for_DimY_Dessin_Grille1
			
e_for_DimY_Dessin_Grille1:						;}
			
			add PositionCurseurTraceurX,20;
			JMP for_DimX_Dessin_Grille1
e_for_DimX_Dessin_Grille1:						;}



			;;////DEUXIEME PARTIE DU DESSIN \\\\\\\



			MOV PositionCurseurTraceurY,0
for_DimY_Dessin_Grille2:							;for(PositionCurseurTraceurY = 0; PositionCurseurTraceurY < ResDimY; PositionCurseurTraceurY + 32){
			
			MOV AX,ResDimY
			CMP PositionCurseurTraceurY,AX
			JGE e_for_DimY_Dessin_Grille2
			
			MOV PositionCurseurTraceurX,0
for_DimX_Dessin_Grille2 : 						;for(PositionCurseurTraceurX = 0; PositionCurseurTraceurX < ResDimX; PositionCurseurTraceurX + 1){			
			
			MOV AX,ResDimX
			CMP PositionCurseurTraceurX,AX
			JGE e_for_DimX_Dessin_Grille2
			
			MOV AH,0CH							;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,02H							;Couleur
			MOV CX,PositionCurseurTraceurY		;Position Pixel selon la colone
			MOV DX,PositionCurseurTraceurX		;Position Pixel selon la range
			INT 10H
			
			ADD PositionCurseurTraceurX,1	
			JMP for_DimX_Dessin_Grille2
			
e_for_DimX_Dessin_Grille2:						;}
			
			add PositionCurseurTraceurY,32;
			JMP for_DimY_Dessin_Grille2
e_for_DimY_Dessin_Grille2:						;}

			POP DX
			POP CX
			POP BX
			POP AX
	
	
			MOV SP,BP
			POP BP
			RET										;return
	
DessinDeLaGrille                           ENDP 		;}
;===========================================================================================================================================================================		
;											FIN  DESSIN DE GRILLE						
;===========================================================================================================================================================================			
;===========================================================================================================================================================================		
;											Get KEYBORD INPUT	
;
;											DESSINE ET EFFACE CURSEUR
;										
;===========================================================================================================================================================================			

GetKeybordInput                          PROC NEAR ;int GetKeybordInput(&PosX,&PosY){
				
				OldPosX	 	  EQU	   <WORD PTR[BP-4]>								
				OldPosY	 	  EQU	   <WORD PTR[BP-2]>								
				PosX	 	  EQU	   <WORD PTR[BP+4]>
				PosY	 	  EQU	   <WORD PTR[BP+6]>
				PosGrille	  EQU	   <WORD PTR[BP+8]>				
				Key	 	 	  EQU	   <WORD PTR[BP+10]>				;Char Key				
			
			PUSH BP
			MOV BP,SP
			PUSH AX
			PUSH BX
			PUSH CX
			PUSH DX

			MOV DX,PosX								;OldPosX = PosX
			MOV OldPosX,DX	

			MOV CX,PosY								;OldPosY = PosY			
			MOV OldPosY,CX							
			
			MOV AH,08								;KEY = GetChar();
			INT 21h
			MOV Key,AX
			
			
switch_GetKeybordInput1:							;siwtch(key){


switch_GetKeybordInput1_c_U:						;case UpArrow:
							
			CMP AL,'H'
			
			JNE e_switch_GetKeybordInput1_c_U	
			
			SUB PosY,20							; POSY = POSY - 20 
			SUB PosGrille,10					; PosGrille = PosGrille - 10
			
if_Key_U:										;if(PosY < 0 ){
			CMP POSY,0
			JGE	e_if_Key_U						;PosY = Posy + 20;
			ADD PosY,20
			ADD PosGrille,10					; PosGrille = PosGrille + 10
e_if_Key_U:										;}


			
			
			
			JMP e_switch_GetKeybordInput1		;break
					

e_switch_GetKeybordInput1_c_U:

switch_GetKeybordInput1_c_D:						;case DOWN KEY:
							
			CMP AL,'P'
			JNE e_switch_GetKeybordInput1_c_D

			
			ADD PosY,20								;PosY = PosY + 20
			ADD PosGrille,10					; PosGrille = PosGrille + 10
			
if_Key_D:											;if (PosY > 200){
			CMP POSY,200			
			JLE	e_if_Key_D							; PosY = Posy - 20;
			SUB PosY,20
			SUB PosGrille,10						; PosGrille = PosGrille - 10
e_if_Key_D:											;}


			
			JMP e_switch_GetKeybordInput1			;break
					

e_switch_GetKeybordInput1_c_D:								
			
switch_GetKeybordInput1_c_R:						;case RIGHT KEY:
							
			CMP AL,'M'
			JNE e_switch_GetKeybordInput1_c_R
			
			ADD POSX,32						;PosX = PosX + 32
			
			ADD PosGrille,1					; PosGrille = PosGrille + 1
			
if_Key_R:
			CMP POSX,320					;IF( PosX > 320){
			JLE	e_if_Key_R					;PosX = PosX - 32
			SUB PosX,32
			SUB PosGrille,1					; PosGrille = PosGrille - 1
e_if_Key_R:									;}
			
			
			JMP e_switch_GetKeybordInput1			;break
					

e_switch_GetKeybordInput1_c_R:


switch_GetKeybordInput1_c_L:						;case LEFT ARROW KEY:
							
			CMP AL,'K'
			JNE e_switch_GetKeybordInput1_c_L
			
			
			SUB Posx,32						;PosX = PosX - 32
			SUB PosGrille,1					; PosGrille = PosGrille - 1
			
if_Key_L:									;if (PosX < 0){
			CMP POSX,0
			JGE	e_if_Key_L					;PosX = Posx + 32 ;
			ADD PosX,32
			ADD PosGrille,1					; PosGrille = PosGrille + 1
e_if_Key_L:									;}
			
			
			JMP e_switch_GetKeybordInput1			;break
					

e_switch_GetKeybordInput1_c_L:

	

			
			
e_switch_GetKeybordInput1:								;}



			MOV CX,1
			MOV AH,0AH
			MOV BH,0							;IMPRIME UNE CARACTERE DE COULEUR 
			MOV BL,1							; COULEUR
			INT 10H


							;EFFACE ANCIEN CURSEUR 2 X 2 PX
	
			MOV AH,0CH							;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,0H							;Couleur
			MOV CX,OldPosX						;Position Pixel selon la colone
			MOV DX,OldPosY						;Position Pixel selon la range
			INT 10H
			
			MOV AH,0CH							;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,0H							;Couleur
			MOV CX,OldPosX						;Position Pixel selon la colone
			INC CX
			MOV DX,OldPosY						;Position Pixel selon la range
			INT 10H
			
			MOV AH,0CH						;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,0H						;Couleur
			MOV CX,OldPosX						;Position Pixel selon la colone
			MOV DX,OldPosY						;Position Pixel selon la range
			INC DX
			INT 10H
			
			MOV AH,0CH						;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,0H						;Couleur
			MOV CX,OldPosX						;Position Pixel selon la colone
			INC CX
			MOV DX,OldPosY						;Position Pixel selon la range
			INC DX
			INT 10H
	
		
							;Dessine un NOUVEAU Curseur 2 X 2 PX

			MOV AH,0CH						;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,1H						;Couleur
			MOV CX,PosX						;Position Pixel selon la colone
			MOV DX,PosY						;Position Pixel selon la range
			INT 10H
			
			MOV AH,0CH						;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,1H						;Couleur
			MOV CX,PosX						;Position Pixel selon la colone
			INC CX
			MOV DX,PosY						;Position Pixel selon la range
			INT 10H
			
			MOV AH,0CH						;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,1H						;Couleur
			MOV CX,PosX						;Position Pixel selon la colone
			MOV DX,PosY						;Position Pixel selon la range
			INC DX
			INT 10H
			
			MOV AH,0CH						;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,1H						;Couleur
			MOV CX,PosX						;Position Pixel selon la colone
			INC CX
			MOV DX,PosY						;Position Pixel selon la range
			INC DX
			INT 10H


			POP DX
			POP CX
			POP BX
			POP AX
	
	
			MOV SP,BP
			POP BP
			RET		
			
GetKeybordInput                           ENDP 		;}	
;===========================================================================================================================================================================		
;											FIN	GET KEYBORD INPUT
;===========================================================================================================================================================================

;===========================================================================================================================================================================		
;											PLACE UNIT
;===========================================================================================================================================================================


PlaceUnit                          PROC NEAR ;void PlaceUnit(&PosX,&PosY){
				
				i			  EQU	   <WORD PTR[BP-2]>							
				PosY	 	  EQU	   <WORD PTR[BP+4]>								
				PosX	 	  EQU	   <WORD PTR[BP+6]>
						
			
			
			
			PUSH BP
			MOV BP,SP
			PUSH AX
			
			
			ADD POSY,10							;POSY = POSY + 		
			ADD POSX,14
			
			
			MOV i,0								;for(i = 0; i < 5; i++)
forPlaceUnit1:
			CMP i,5
			JGE eforPlaceUnit1
			MOV AH,0CH							;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,3H							;Couleur
			MOV CX,POSX							;Position Pixel selon la colone
			MOV DX,POSY							;Position Pixel selon la range
			INT 10H
			
			INC POSX							;POSX++ 
			
			INC i
			
			JMP forPlaceUnit1
eforPlaceUnit1:			
			
			


			
			POP AX
	
			MOV SP,BP
			POP BP
			RET		
			
PlaceUnit                           ENDP 		;}			

;===========================================================================================================================================================================		
;											FIN PLACE UNIT
;===========================================================================================================================================================================

;===========================================================================================================================================================================		
;											PLACE ATTACK
;===========================================================================================================================================================================
PlaceAttack                          PROC NEAR ;void PlaceAttack(Case){
				
				Index		  EQU	   <WORD PTR[BP-10]>
				X		  	  EQU	   <WORD PTR[BP-8]>		
				Y		  	  EQU	   <WORD PTR[BP-6]>				
				
				PosY		  EQU	   <WORD PTR[BP-4]>		
				PosX		  EQU	   <WORD PTR[BP-2]>							
				Case	 	  EQU	   <WORD PTR[BP+4]>								
				
			
			PUSH BP
			MOV BP,SP
			PUSH AX
			
			MOV PosX,16
			MOV PosY,10
			
			MOV DX,0
			MOV AX,33
			MOV CX,10
			DIV CX
			MOV Y,AX				;Y = Case / 10
			MOV X,DX				;X = Case % 10
			
			MOV Index,0
forPlaceAttackX:					;for(index = 0; index < X; index++){
			MOV AX,X
			CMP index,AX
			JGE eforPlaceAttackX
			
			ADD PosX,32				;PosX = PosX + 32 
				
			INC index
			JMP forPlaceAttackX
eforPlaceAttackX:					;}


			MOV Index,0
forPlaceAttackY:					;for(index = 0; index < X; index++){
			MOV AX,Y
			CMP index,AX
			JGE eforPlaceAttackY
			
			ADD PosY,20				;PosY = PosY + 20
				
			INC index
			JMP forPlaceAttackY
eforPlaceAttackY:					;}

			MOV index,0
forPlaceAttack1:
			CMP index,5
			JGE eforPlaceAttack1
			MOV AH,0CH							;Desine Un Pixel en Fonction de la Position X Y
			MOV AL,2h							;Couleur
			MOV CX,PosX							;Position Pixel selon la colone
			MOV DX,PosY							;Position Pixel selon la range
			INT 10H
			
			ADD PosY,1							;POSX++ 
			
			INC index
			
			JMP forPlaceAttack1
eforPlaceAttack1:			
		
			POP AX
	
			MOV SP,BP
			POP BP
			RET		
			
PlaceAttack                           ENDP 		;}	


;===========================================================================================================================================================================		
;											FIN PLACE ATTACK
;===========================================================================================================================================================================
