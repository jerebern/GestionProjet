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
			Index_i					DW	0
	
			PosCursUserX			DW 1
			PosCursUserY			DW 1
			OldPosCursUserX			DW 0
			OldPosCursUserY			DW 0
			
			PositionGrille			DW 0
		
			Note					DW 0
			VieilleCouleur			DW 0
			NouvelleCouleur 		DW 0
			
			TRASH					DW 0
			
			Action					DW 0
			
			RX						DW 0
			RxNonValide				DW 1
			ContinuerPartie 		DW 1
			
			FlagPlacerAttaques		DW 0	
			FlagPremierTour			DW 1
				
			;MESSAGE
			
			MessageInitEcran		DB 'Choisir un Mode Graphique : $'
			MessageInitCGA			DB '1.CGA$'
			MessageInitTandy		DB '2.Tandy / PCJR$'			
			MessageInitVGA			DB '3.VGA$'
			MessageAttenteConnexion	DB 'En Attente Du Serveur connecte COM1$'
			MessageVictoire			DB 'Vous avez Gagnez$'
			MessagePerdu			DB 'Vosu Avez Perdu$'
			MessageArretPartie		DB 'Travail Pour Gestion Projet Hiver 2020$'
			
			
		
		

	   .CODE
;===========================================================================================================================================================================			
;											MAIN
;===========================================================================================================================================================================		 


listing: 	MOV AX, @DATA
			MOV DS,AX
;---------------------------------------------------------------------------------			
			true 		   EQU 1								;#define true 1
			false 		   EQU 0								;#define false 
			note_Place 	   EQU 9121 
			note_Attack	   EQU 6833
			note_Init_Game EQU 5746 
;---------------------------------------------------------------------------------			
			
			MOV Note,note_Init_Game
			PUSH note
			CALL make_Sound
			POP Trash
			
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

			MOV DX, OFFSET MessageInitVGA			;Ecrire_Chaine(MessageInitVGA)			
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
			
Do_Main_while:									;Do{

Do_while_Attente:								;Do{		
			
			MOV FlagPlacerAttaques,false
			
			PUSH RX
			Call receive_Com					;receive_Com(&RxCar); // LE JEU COMMENCE PAR ATTENDRE UN CAR POUR SAVOIR QUAND CES A SON TOUR 
			POP RX
  			
			PUSH FlagPlacerAttaques
			MOV DX, OFFSET MessageVictoire			 
			MOV CX, OFFSET MessagePerdu
			PUSH CX			
			PUSH DX
			PUSH ContinuerPartie
			PUSH RxNonValide
			PUSH RX
			CALL Analyse_RxCom		;RxNonValide = Analyse_RxCom(RxNonValide,RX,continuer,MessageVictoire,MessagePerdu)
			POP Trash
			POP RxNonValide
			POP ContinuerPartie
			POP TRASH
			POP TRASH
			POP FlagPlacerAttaques
			
ewhile_Attente:									;}

if_main1:	CMP FlagPlacerAttaques, true	;if(flagPlacerAttaque)	
			JNE e_if_main1
			
			PUSH Action
			PUSH PositionGrille
			PUSH PosCursUserX
			PUSH PosCursUserY
			CALL GetKeybordInput			;GetKeybordInput(Action,PositionGrille,&PosX,&PosY);
			POP  PosCursUserY
			POP  PosCursUserX
			POP  PositionGrille
			POP  Action
	
if_main_2:									;if(Action == ' ' & flagPremierTour){
			MOV AX,Action
		    CMP AL,' '
			JNE e_if_main_2
			CMP FlagPremierTour,true
			JNE e_if_main_2
			MOV FlagPremierTour,false				
			MOV Index_I,0
				
for_main1:									;for(index_i = 0; index_i < 3; index_i++){	
			CMP Index_i, 3
			JGE	e_for_main1
			
			PUSH PosCursUserY
			PUSH PosCursUserX	
			CALL PlaceUnit					;PlaceUnit(POSX,POSY)
			POP Trash
			POP Trash
			PUSH PositionGrille
			CALL Send_Com					;send_Com(PositionGrille)
			POP trash
			MOV note,note_Place
			PUSH note
			CALL make_Sound 				;make_Sound(Note)
			POP TRASH	
			INC Index_I 
			JMP for_main1
	
e_for_main1:									;}	

e_if_main_2:								;}

else_if_main_2:


				;;;///RENDU A DEVELOPPER CA QUE FAIRE POUR ENOVYER UNE ATTAQUE AU SERVEUR 
 
e_else_if_main_2:

e_if_main1:

			CMP ContinuerPartie,false				
			JE E_Main_while
			JMP Do_Main_while
E_Main_while:								;}while(ContinuerPartie != false)			
		

			MOV DX, OFFSET MessageArretPartie
			PUSH DX
			CALL Ecrire_Chaine						;Ecrire_Chaine(MessageArretPartie)
			POP TRASH	



eop:     	MOV       AX, 4C00h
			INT       33

;===========================================================================================================================================================================			
;											FIN MAIN
;===========================================================================================================================================================================
		INCLUDE com.asm
		INCLUDE Graphic.asm
		INCLUDE text.asm
		INCLUDE note.asm



;===========================================================================================================================================================================		
;											FIN	PROGRAMME
;===========================================================================================================================================================================

         END       listing