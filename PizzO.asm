;--------------------------------------------------------------------------------------------------------------------;
;                                       Trabalho 2 AC - PizzO - Pizzaria Online                                      ;
;                                                                                                                    ;
;                                               Joel Freitas - 2031915                                               ;
;                                               Pedro Jaques - 2046919                                               ;
;--------------------------------------------------------------------------------------------------------------------;

;Peripherals

  Username_Start    EQU  0150H 	;Address of the input peripheral Username
	Username_End      EQU  0157H 	;Address of the input peripheral Username
  Password_Start    EQU  0160H 	;Address of the input peripheral Password
	Password_End   		EQU  0167H 	;Address of the input peripheral Password
  OK_Button      		EQU  0170H 	;OK button address
  NR_SEL_Button  		EQU  0172H 	;NR_SEL button address

;Display Adrresses

  Display_Start    					EQU		0010H		;Display start address
	Display_End								EQU		007FH		;Display end address
	Username_Start_Display		EQU		0030H		;Start address to display the Username
	Username_End_Display			EQU		003FH		;End address to display the Username
	Password_Start_Display		EQU		0050H		;Start address to display the Password
	Password_End_Display			EQU		005FH		;End address to display the Password
	Total_Euros_Start					EQU		0046H		;Start address to display the total price
	Total_Euros_End						EQU		0048H		;End address to display the total price
	Total_Cent_Start					EQU		004AH		;Start address to display cents
	Total_Cent_End						EQU		004BH		;End address to display cents

;Constants

	StackPointer				EQU 	9900H		;Endereço base da pilha (stack)
	CleaningCharacter		EQU		20H			;Cleaning character for the display
	Asterisk						EQU		2AH			;Asterisk character for the presentation of password

	OptNewAccount				EQU 	1				;Create New Account Option
	OptLogin						EQU 	2				;Login Option
	OptExitLoginMenu		EQU		3				;Exit Login Menu Option

	OptPesto       			EQU		1				;Pesto Pizza Option
	OptFourCheese 			EQU 	2				;Four Cheese Pizza Option
	OptChicken     			EQU 	3				;Chicken Pizza Option
	OptShrimp       		EQU	  4				;Shrimp Pizza Option
	OptHawaii						EQU		5				;Hawaii Pizza Option

	OptSmall						EQU		1				;Small Pizza Option
	OptLarge						EQU 	2				;Large Pizza Option

	OptSmallPrice				EQU		5				;Small Pizza Price Option
	OptLargePrice				EQU		9				;Large Pizza Price Option

	OptYes							EQU		1				;Yes Option
	OptNo								EQU		2				;No Option

	Pular_User					EQU		30H			;Valor para poder andar de registo em registo na memória (memória de utilizadores)
	Pular_Dentro_User		EQU		10H			;Valor para poder andar entre os vários dados do utilizador (username, password, histórico de compras)
	Total_User					EQU		10			;Valor da totalidade de utilizadores que a memória pode ter
	Tam_User_Pass				EQU		8				;Tamanho que o username/password pode ter
	EscolherPizza				EQU		1				;Opção para fazer o pedido da pizza que pretende
	EscolherLogout			EQU		2				;Opção caso o utilizador prentenda fazer logout do site da pizzaria
	Total_Compras				EQU 	64H			;Total de compras que pode efetuar no momento, ou seja, Total = Histórico + Compras atuais
	PedirMais						EQU		1				;Opção para a escolha de mais pizzas por parte do utilizador
	PagarTotal					EQU 	2				;Opção para a escolha do pagamento do pedido do utilizador
	Tam_Euros						EQU		3				;Tamanho disponível no display para a representação do dinheiro (Parte Euros)
	Pular_Historico			EQU		10H			;Valor para poder andar entre as várias posições de endereço para poder visualizar o valor em euros
	Desconta						EQU		32H			;Valor para subtrair ao histórico caso o valor do histórico seja superior a 50 euros

;Database (Username, Password e purchase history)

	DB_start	EQU		4000H		;Start address for the database
	DB_End		EQU		5000H		;End address for the database

PLACE 3FF0H

	DB_Headers:
		STRING "USER  PASS  HIST"

;--------------------------------------------------------------------------------------------------------------------;
;                     										             Screens/Menus	   				                                     ;
;--------------------------------------------------------------------------------------------------------------------;

PLACE 2000H

	Start_Screen:
		STRING "    Welcome     "
		STRING "      to        "
		STRING "     PizzO      "
		STRING "       -        "
		STRING "Online Pizzaria "		
		STRING "                "
		STRING "	  Press OK    "

PLACE 2080H

	Login_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "1. New Account  "
		STRING "2. Login        "
		STRING "3. Exit         "
		STRING "                "
		STRING "                "

PLACE 2100H

	Login_Register_Form:
		STRING "     PizzO      "
		STRING "    Username:   "		
		STRING "                "
		STRING "    Password:   "
		STRING "                "
		STRING "                "
		STRING " OK to continue "
		
PLACE 2180H

	Account_Created_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "Account Created "
		STRING " Successfully!  "
		STRING "                "
		STRING "                "
		STRING " OK to continue "

PLACE 2200H

	Existing_Username_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "  This Username "
		STRING "     is not     "
		STRING "   available!   "
		STRING "                "
		STRING " OK to continue "

PLACE 2280H

	Missing_Field_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING " One field was  "
		STRING " not filled in! "
		STRING "                "
		STRING "                "
		STRING " OK to continue "

PLACE 2300H

	Invalid_Option_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING " Invalid Option!"
		STRING " Choose a valid "
		STRING "     option     "
		STRING "                "
		STRING " OK to continue "

PLACE 2380H

	Account_Not_Created_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "  This Account  "
		STRING "     is not     "
		STRING "    created!    "
		STRING "                "
		STRING " OK to continue "
		
PLACE 2400H

	Invalid_Password_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "     Invalid    "
		STRING "    Password!   "
		STRING "                "
		STRING "                "
		STRING " OK to continue "

PLACE 2480H

	Incomplete_Password_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "     Invalid    "
		STRING "    Password!   "
		STRING "At least 3 chars"
		STRING "                "
		STRING " OK to continue "

PLACE 2500H

	DB_Full_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "  Account not   "
		STRING "    created!    "
		STRING " Full Database! "
		STRING "                "
		STRING " OK to continue "
	
PLACE 2580H

	Valid_Login_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "                "
		STRING "  Valid Login!  "
		STRING "                "
		STRING "                "
		STRING " OK to continue "

PLACE 2600H

	Confirm_Exit_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "  Are you sure? "
		STRING "1. Yes, exit    "
		STRING "2. No, dont exit"
		STRING "                "
		STRING " OK to continue "

PLACE 2680H

	Exit_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "   Thanks for   "
		STRING "   preference!  "
		STRING "Come back always"
		STRING "                "
		STRING " OK to continue "

PLACE 2700H

	Main_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "1. Order Pizza  "
		STRING "2. Logout       "
		STRING "                "
		STRING "                "
		STRING " OK to continue "

PLACE 2780H

	Pizza_Menu:
		STRING "     PizzO      "
		STRING "1. Pesto        "
		STRING "2. Four Cheese  "
		STRING "3. Chicken      "
		STRING "4. Shrimp       " 
		STRING "5. Hawaii       "
		STRING " OK to continue "
		
PLACE 2800H

	Pizza_Size_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "     Sizes:     "
		STRING "1. Small (5 EUR)"
		STRING "2. Large (9 EUR)"
		STRING "                "
		STRING " OK to continue "
		
PLACE 2880H

	Order_More_Or_Pay_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "                "
		STRING "1. Order more   "
		STRING "2. Payment      "
		STRING "                "
		STRING " OK to continue "
		
PLACE 2900H

	Payment_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "                "
		STRING "TOTAL:   ,   EUR"
		STRING "Disc.:   ,   EUR"
		STRING "                "
		STRING " OK to Pay      "

;--------------------------------------------------------------------------------------------------------------------;
;                     										             Main Program  	   				                                     ;
;--------------------------------------------------------------------------------------------------------------------;

PLACE 0000H

	Begin:
		MOV R0, Start										;Moves the address of the tag Start to R0
		JMP R0
		
PLACE 6000H

	Begining:
		MOV SP, StackPointer						;Base of stack at 9900H
		CALL CleanDisplayRoutine				;Routine to clean the display
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean Username and Password
		CALL ValidateRoutine						;Validation to enter

	Start:
		MOV R2, Start_Screen						;Move to R2 the address of the "Start_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Start_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean Username and Password
		CALL ValidateRoutine						;Validation to enter

	LoginMenu:
		MOV R2, Login_Menu							;Put in R2 the address of the "Login_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Login_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadOptions:
		MOV R0, NR_SEL_Button						;Put in R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Put in R1 the content of the address "NR_SEL_Button"
		CMP R1, OptNewAccount						;Compares the value of R1 with the constant "OptNewAccount"
		JEQ NewAccountForm							;If the values are equal, jumps to the address "NewAccountForm"
		CMP R1, OptLogin								;Compares the value of R1 with the constant "OptLogin"
		JEQ LoginForm										;If the values are equal, jumps to the address "LoginForm"
		CMP R1, OptExitLoginMenu				;Compares the value of R1 with the constant "OptExitLoginMenu"
		JEQ ConfirmExitLoginMenu				;If equal, jumps to "ConfirmExitLoginMenu"
		CALL InvalidOptionRoutine				;Routine to display invalid option pop up
		JMP LoginMenu										;Goes back to menu if none where selected

	NewAccountForm:
		MOV R2, Login_Register_Form			;If the option selected by the user is not valid, moves to R2 the address of "Confirm_Exit_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Confirm_Exit_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		RET

	LoginForm:
		MOV R2, Login_Register_Form			;If the option selected by the user is not valid, moves to R2 the address of "Confirm_Exit_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Confirm_Exit_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ConfirmExitLoginMenu:
		MOV R2, Confirm_Exit_Menu				;If the option selected by the user is not valid, moves to R2 the address of "Confirm_Exit_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Confirm_Exit_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadExitOptions:
		MOV R0, NR_SEL_Button						;Put in R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Put in R1 the content of the address "NR_SEL_Button"
		CMP R1, OptYes									;Compares the value of R1 with the constant "OptYes"
		JEQ	ExitProgram									;If true jumps to "ExitProgram"
		CMP R1, OptNo										;Compares the value of R1 with the constant "OptNo"
		JEQ	LoginMenu										;If true jumps back to de "LoginMenu"
		CALL InvalidOptionRoutine				;Routine to display invalid option pop up
		JMP LoginMenu										;Goes back to menu if none where selected

	ExitProgram:
		MOV R2, Exit_Screen							;Moves to R2 the address of "Exit_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Exit_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP Begining										;Goes back to the begining of the program

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to display wrong option	   				                                   ;
;--------------------------------------------------------------------------------------------------------------------;

	InvalidOptionRoutine:
		MOV R2, Invalid_Option_Screen		;If the option selected by the user is not valid, moves to R2 the address of "Invalid_Option_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Invalid_Option_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to clean the display  	   				                                   ;
;--------------------------------------------------------------------------------------------------------------------;

	CleanDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		PUSH R3
		MOV R0, Display_Start						;Display start address
		MOV R1, Display_End							;Display end address
		MOV R3, CleaningCharacter				;Put on the R3 the cleaning character (20h)
		
	CleanDisplayCicle:
		MOVB [R0], R3										;Copies CleaningCharacter to the Display
		CMP R0, R1											;Compares R0 (position on which is on the display) with the value of R1 (final display value)
		JGE EndOfCleaningRoutine				;If the values are equal, the display is clean and jumps to "EndOfCleaningRoutine"
		ADD R0, 1												;Increases 1 to the value of R0 (position in which it is on the display)
		JMP CleanDisplayCicle						;If the end of the display hasn't been reached yet, jump to "CleanDisplayCicle"
		
	EndOfCleaningRoutine:
		POP R3													;Removes from Stacks the records 
		POP R1
		POP R0
		RET	

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to show the display  	   				                                     ;
;--------------------------------------------------------------------------------------------------------------------;

	ShowDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		PUSH R3
		MOV R0, Display_Start						;Display start address
		MOV R1, Display_End							;Display end address
		
	WriteDisplayCicle:
		MOV R3, [R2]										;Copies from 
		MOV [R0], R3										;Copy for the display
		CMP R0, R1											;Compares the value of R0 with the value of R1
		JGE EnfOfShowDisplayRoutine			;If the values are equal jumps to "EnfOfShowDisplayRoutine"
		ADD R2, 2												;Increment 2 to the value of the menu word
		ADD R0, 2												;Increment 2 to the value of the display memory
		JMP WriteDisplayCicle						;Jump to the address "WriteDisplayCicle"
		
	EnfOfShowDisplayRoutine:
		POP R3													;Removes from Stacks the records 
		POP R1								
		POP R0
		RET	

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to clean the Peripherals 				                                     ;
;--------------------------------------------------------------------------------------------------------------------;

	CleanPeripheralsRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		PUSH R2	
		MOV R0, OK_Button								;Put in R0 the address of the peripheral "OK_Button"
		MOV R1, NR_SEL_Button						;Put in R1 the address of the peripheral "NR_SEL_Button"
		MOV R2, 0												;Put in R2 0
		MOVB [R0], R2										;Puts in the memory position "OK_Button" the value of R2
		MOVB [R1], R2										;Puts in the memory position "NR_SEL_Button" the value of R2
		POP R2													;Removes from Stack the records
		POP R1									
		POP R0									
		RET

;--------------------------------------------------------------------------------------------------------------------;
;                     					  Routine to clean the Username and Password 				                                 ;
;--------------------------------------------------------------------------------------------------------------------;

	CleanUserPassRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine		
		PUSH R1
		PUSH R2	
		PUSH R3
		MOV R0, Username_Start					;Puts in the R0 the address of the start of the input peripheral to the introduction of Username
		MOV R1, OK_Button								;Coloca no registo R1 o endereço do periférico "Pin_OK"
		MOV R2, 0												;Coloca em R2 a constante 0
		
	CleanUserPassCicle:
		CMP R0, R1											;Compara o início do periférico de entrada do username com o endereço do periférico "Pin_OK"
		JEQ EndOfCleanUserPassRoutine									;Caso os valores sejam iguais, acaba a limpeza dos periféricos username e password e salta para o endereço "Fim_Limpeza"
		MOVB [R0], R2										;Coloca na posição de memória R0 (posição entre o inicio do periférico "Inicio_User" e o periférico "Pin_OK") o valor do registo R2
		ADD R0, 1												;Incrementa 1 ao valor do registo R0 (posição entre o inicio do periférico "Inicio_User" e o periférico "Pin_OK")
		JMP CleanUserPassCicle								;Caso ainda não tenha chegado ao fim, salta para o endereço "Ciclo_Limpar" para continuar a limpeza
		
	EndOfCleanUserPassRoutine:
		POP R3													;Removes from Stack the records
		POP R2
		POP R1
		POP R0
		RET
		
;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to validate the Button OK  				                                   ;
;--------------------------------------------------------------------------------------------------------------------;

	ValidateRoutine:
		PUSH R6													;Saves in the stack the records that are changed in the routine
		PUSH R7									
		MOV R7, OK_Button									;Put in the register R7 the address of the peripheral "OK_Button"

	Validate:
		MOVB R6, [R7]							;Coloca no registo R6 o conteúdo do endereço "OK_Button"
		CMP R6, 1								;Compara o valor de R6 com a constante 1
		JNE Validate								;Caso o valor seja diferente, ele salta para o endereço "Valida" enquanto não fizer a validação ("OK_Button" a 1)
		POP R7									;*********************************************************;			
		POP R6									;               Retira da stack os registos
		RET										;
