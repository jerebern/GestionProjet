/******************************************************************

	--> source.c

	Module d'utilisation du port RS232 sur Unix / Linux

	Stevens Gagnon
	Departement Informatique
	College Shawinigan

*******************************************************************/
/* Source */

#include "sg_rs232.h"

/*-------------------------------------------------------------*/


struct Player {
	
	int ID;
	char ConexionType[6];
	int fd;
	unsigned char rxCar;
	unsigned char txCar;
	
};


int main()
{
	unsigned char rxCar, txCar;
	int fd;
	int i;
	
	struct Player player[2];

/*-------------------------------------------------------------*/

	/* "ttyS1" : pour Linux 9 sur VMWare */
	/* "ttyS0" : pour Linux 8 sur VMWare */
	/* "cuad0" : pour FreeBSD*/
	/* "tty00" : pour OpenBSD*/
	/* En FreeBSD l'usager qui execute doit faire partie du groupe "dialer" */

//	fd = ini("ttyS2");       ////A crisser dans un switch pour gosser avec les joueur
	
		player[0].ID = 1;
	    snprintf(player[0].ConexionType,6,"ttyS2");
		player[0].fd = ini(player[0].ConexionType);
		
		
		player[1].ID = 2;
		snprintf(player[1].ConexionType,6,"ttyS4");
		player[1].fd = ini(player[1].ConexionType);
		
	//	bool Cases[100] = {false}; 
		
		int EtatParti;
		
		EtatParti = 0;

		if( player[0].fd < 1 && player[1].fd < 1 )
		{
			printf("****************** PROBLEME : ini ********************\n");
		}
		else
		{

			printf("-----------------------------\n");
			
			while(1){
				
			printf("\n ==================================================== \n");
			printf("Etat parti = %i",EtatParti);
			printf("\n ==================================================== \n");		
	
			switch(EtatParti){
		
			//Debut de la connexion -> Attente de connexion sur ASM dans Com.ASM 
			case 0:
				

				for(i =  0; i < 2; i++){
			
				player[i].txCar = 100;
								
				if( Tx(player[i].fd, &player[i].txCar, 0 ) )
					printf("Player ID : %i Tx: %c\n", player[i].ID ,player[i].txCar);
						
			}
														
				EtatParti = 1;
				break;
				
			case 1:
			//Chacun des joueurs place leurs bateaux -> 
	
				for(i = 0; i < 2; i++){
	
					player[i].txCar = 106;	
					if( Tx(player[i].fd, &player[i].txCar, 0 ) )
					printf("Player ID : %i Tx: %c\n", player[i].ID ,player[i].txCar);
			    	for(int j = 0; j < 3; j++ ){
					if( Rx(player[i].fd, &player[i].rxCar, 0)) 					
						printf("Player ID : %i A PLACER  RX: %i\n",player[i].ID	,player[i].rxCar);				
						}
							}	
				
				EtatParti = 2;
			
				break;	
				
			case 2 :
				//Chacun place ses attaques

				for(i = 0; i < 2; i++){
					player[i].txCar = 106;	
						if( Tx(player[i].fd, &player[i].txCar, 0)){
								printf("Player ID : %i transmission permission attaque  RX: %i\n",player[i].ID	,player[i].txCar);
								player[i].txCar = 106;	
						if( Rx(player[i].fd, &player[i].txCar, 0 ) )
								printf("Player ID : %i Envoie � la case : %c\n", player[i].ID ,player[i].rxCar);							
						}			
														
						}
										
				break;
						
				}
			
				
					
			}						
							
			}

			printf("-----------------------------\n");
			close(fd);
		}




