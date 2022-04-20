;---------------------------------------------------------------------------------------------------------------------------------------------------------------;
;                                               Trabalho 2 AC - PizzO - Pizzaria Online                                                                         ;
;                                                                                                                                                               ;
;                                                       Joel Freitas - 2031915                                                                                  ;
;                                                       Pedro Jaques - 2046919                                                                                  ;
;---------------------------------------------------------------------------------------------------------------------------------------------------------------;

;Peripherals

  Username       EQU  0150H ;Address of the input peripheral Username
  Password       EQU  0160H ;Address of the input peripheral Password
  OK_Button      EQU  0170H ;OK button address
  NR_SLE_Button  EQU  0180H ;NR_SEL button address

;Display Adrresses

  Display_Start     EQU		0010H			;Display start address
	Display_End				EQU		007FH			;Display end address
	Username_Start		EQU		0035H			;Start address to display the Username
	Username_End			EQU		003CH			;End address to display the Username
	Password_Start		EQU		0045H			;Start address to display the Password
	Password_End			EQU		004CH			;End address to display the Password
	Total_Euros_Start	EQU		0046H			;Start address to display the total price
	Total_Euros_End		EQU		0048H			;Endereço do fim do display para a visualização do preço total a pagar
	Total_Cent_Start	EQU		004AH			;Endereço do display para a visualização dos cêntimos do valor a pagar