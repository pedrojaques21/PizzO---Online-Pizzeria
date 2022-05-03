;--------------------------------------------------------------------------------------------------------------------;
;                                       Trabalho 2 AC - PizzO - Pizzaria Online                                      ;
;                                                                                                                    ;
;                                               Joel Freitas - 2031915                                               ;
;                                               Pedro Jaques - 2046919                                               ;
;--------------------------------------------------------------------------------------------------------------------;

;Peripherals

  Username_Start    EQU  0150H 	;Address of the input peripheral Username
	Username_End      EQU  0155H 	;Address of the input peripheral Username
  Password_Start    EQU  0160H 	;Address of the input peripheral Password
	Password_End   		EQU  0165H 	;Address of the input peripheral Password
  OK_Button      		EQU  0170H 	;OK button address
  NR_SEL_Button  		EQU  0172H 	;NR_SEL button address

;Display Adrresses

  Display_Start    					EQU		0010H		;Display start address
	Display_End								EQU		007FH		;Display end address
	Username_Start_Display		EQU		0035H		;Start address to display the Username
	Username_End_Display			EQU		003AH		;End address to display the Username
	Password_Start_Display		EQU		0055H		;Start address to display the Password
	Password_End_Display			EQU		005AH		;End address to display the Password
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

	UserPassMemSize			EQU		6				;Size of bytes of the username and password
	MaxUsersInDB				EQU 	5				;Maximum number of users allowed in DB
	Iterate_User				EQU		10H			;Value to be able to iterate between users in database
	Iterate_User_Info		EQU		6H			;Value to be able to iterate between user info (username, password, historic)

	EscolherPizza				EQU		1				;Opção para fazer o pedido da pizza que pretende
	EscolherLogout			EQU		2				;Opção caso o utilizador prentenda fazer logout do site da pizzaria
	Total_Compras				EQU 	64H			;Total de compras que pode efetuar no momento, ou seja, Total = Histórico + Compras atuais
	PedirMais						EQU		1				;Opção para a escolha de mais pizzas por parte do utilizador
	PagarTotal					EQU 	2				;Opção para a escolha do pagamento do pedido do utilizador
	Tam_Euros						EQU		3				;Tamanho disponível no display para a representação do dinheiro (Parte Euros)
	Pular_Historico			EQU		10H			;Valor para poder andar entre as várias posições de endereço para poder visualizar o valor em euros
	Desconta						EQU		32H			;Valor para subtrair ao histórico caso o valor do histórico seja superior a 50 euros

;Database (Username, Password e purchase history)

	DB_Start	EQU		4000H		;Start address for the database
	DB_End		EQU		4040H		;End address for the database

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
		STRING " OK to select   "

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
		STRING " Can not create "
		STRING "    Account!    "
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
		STRING "                "
		STRING "1. Yes    2. No "
		STRING "                "
		STRING " OK to select   "

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
		STRING " OK to select   "

PLACE 2780H

	Pizza_Menu:
		STRING "     PizzO      "
		STRING "1. Pesto        "
		STRING "2. Four Cheese  "
		STRING "3. Chicken      "
		STRING "4. Shrimp       " 
		STRING "5. Hawaii       "
		STRING " OK to select   "
		
PLACE 2800H

	Pizza_Size_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "     Sizes:     "
		STRING "1. Small (5 EUR)"
		STRING "2. Large (9 EUR)"
		STRING "                "
		STRING " OK to select   "
		
PLACE 2880H

	Order_More_Or_Pay_Menu:
		STRING "     PizzO      "
		STRING "                "
		STRING "                "
		STRING "1. Order more   "
		STRING "2. Payment      "
		STRING "                "
		STRING " OK to select   "
		
PLACE 2900H

	Payment_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "                "
		STRING "TOTAL:   ,   EUR"
		STRING "Disc.:   ,   EUR"
		STRING "                "
		STRING " OK to pay      "

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
		MOVB R1, [R0]										;Put in R1 the value of the address "NR_SEL_Button"
		CMP R1, OptNewAccount						;Compares the value of R1 with the constant "OptNewAccount"
		JEQ NewAccountForm							;If the values are equal, jumps to the address "NewAccountForm"
		CMP R1, OptLogin								;Compares the value of R1 with the constant "OptLogin"
		JEQ LoginForm										;If the values are equal, jumps to the address "LoginForm"
		CMP R1, OptExitLoginMenu				;Compares the value of R1 with the constant "OptExitLoginMenu"
		JEQ ConfirmExitLoginMenu				;If equal, jumps to "ConfirmExitLoginMenu"
		CALL InvalidOptionRoutine				;Routine to display invalid option pop up
		JMP LoginMenu										;Goes back to menu if none where selected

	NewAccountForm:
		CALL CheckUsersInDBRoutine			;Routine to check if more users can be added(R4 keeps with number of users in DB)
		MOV R1, MaxUsersInDB						;Moves to R1 the maximum number of users allowed in DB
		CMP R4, R1											;Compares R10 with R1 to check if there is space available in DB
 		JEQ FullDataBasePopUp						;If no space available jumps to full DB screen 
		MOV R2, Login_Register_Form			;Moves to R2 the address of "Login_Register_Form"
		CALL ShowDisplayRoutine					;Routine to display the "Login_Register_Form"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the username and password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		CALL ShowUserAndPassOnDisplayRoutine		;Routine to Show username and password on the display
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	FullDataBasePopUp:
		MOV R2, DB_Full_Screen
		CALL ShowDisplayRoutine					;Routine to display the "DB_Full_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the username and password inputs
		CALL ValidateRoutine						;Routine to validate the selected options

	AccountCreatedWithSuccess:
		MOV R2, Account_Created_Screen
		CALL ShowDisplayRoutine					;Routine to display the "Login_Register_Form"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the username and password inputs
		CALL ValidateRoutine						;Routine to validate the selected options

	LoginForm:
		MOV R2, Login_Register_Form			;Moves to R2 the address of "Login_Register_Form"
		CALL ShowDisplayRoutine					;Routine to display the "Login_Register_Form"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ConfirmExitLoginMenu:
		MOV R2, Confirm_Exit_Menu				;Moves to R2 the address of "Confirm_Exit_Menu"
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
		CALL InvalidOptionRoutine				;If the option selected does not exist calls routine to display invalid option pop up
		JMP LoginMenu										;Goes back to menu if none where selected

	ExitProgram:
		MOV R2, Exit_Screen							;Moves to R2 the address of "Exit_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Exit_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP Begining										;Goes back to the begining of the program

;--------------------------------------------------------------------------------------------------------------------;
;                     										         End Main Program  	   				                                     ;
;--------------------------------------------------------------------------------------------------------------------;

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to clean the display  	   				                                   ;
;--------------------------------------------------------------------------------------------------------------------;

	CleanDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		PUSH R3
		MOV R0, Display_Start						;Moves to R0 the "Display_Start"
		MOV R1, Display_End							;Moves to R1 the "Display_End"
		MOV R3, CleaningCharacter				;Moves to R3 the "CleaningCharacter"
		
	CleanDisplayCicle:
		MOVB [R0], R3										;Copies CleaningCharacter to the Display
		CMP R0, R1											;Compares R0 (position of the start of the display) with the value of R1 (end of the display)
		JGE EndOfCleaningRoutine				;If the values are equal, the display is clean and jumps to "EndOfCleaningRoutine"
		ADD R0, 1												;Increases 1 to the value of R0 to move to the next position on the display
		JMP CleanDisplayCicle						;If the end of the display hasn't been reached yet, jump to "CleanDisplayCicle"
		
	EndOfCleaningRoutine:
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
		MOV R2, 0												;Put in R2 the constant 0
		MOVB [R0], R2										;Puts in the memory position "OK_Button" the value of R2
		MOVB [R1], R2										;Puts in the memory position "NR_SEL_Button" the value of R2
		POP R2													;Removes from Stack the records
		POP R1									
		POP R0									
		RET

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to show the display  	   				                                     ;
;														 The Menu/Screen to display comes in the register R2																		 ;
;--------------------------------------------------------------------------------------------------------------------;

	ShowDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		PUSH R3
		MOV R0, Display_Start						;Moves to R0 the "Display_Start"
		MOV R1, Display_End							;Moves to R1 the "Display_End"
		
	ShowDisplayCycle:
		MOV R3, [R2]										;Moves from R2(the menu/screen to display) to R3 
		MOV [R0], R3										;Moves to the display all the information on the menu/screen
		CMP R0, R1											;Compares the value of R0 with the value of R1
		JGE EnfOfShowDisplayRoutine			;If the values are equal everythig has been displayed so jumps to "EnfOfShowDisplayRoutine"
		ADD R2, 2												;Increment 2 to the value of the menu word
		ADD R0, 2												;Increment 2 to the value of the display memory
		JMP ShowDisplayCycle						;Jump to the address "ShowDisplayCycle"
		
	EnfOfShowDisplayRoutine:
		POP R3													;Removes from Stacks the records 
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
		MOV R0, Username_Start					;Moves to R0 the address of "Username_Start"(address of the starting input of Username)
		MOV R1, OK_Button								;Moves to R1 the address of "OK_Button"(before this address stays the address of the end of de password input peripheral)
		MOV R2, 0												;Moves to R2 the constant 0
		
	CleanUserPassCycle:
		MOVB [R0], R2										;Moves the value of R2(0) to R0 (position between the beginning of the peripheral "Username_Start" and the peripheral "OK_Button")
		CMP R0, R1											;Compares the address of R0 with R1 to check if both peripherals are clean
		JEQ EndOfCleanUserPassRoutine		;If the values are equal, the Username and Password peripherals are clean
		ADD R0, 1												;Increases 1 to the value of the R0 to avance 1 position of memory
		JMP CleanUserPassCycle					;Repeats the cycle until the peripherals are clean
		
	EndOfCleanUserPassRoutine:
		POP R2													;Removes from Stack the records
		POP R1
		POP R0
		RET
		
;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to validate the Button OK  				                                   ;
;--------------------------------------------------------------------------------------------------------------------;

	ValidateRoutine:
		PUSH R0													;Saves in the stack the records that are changed in the routine
		PUSH R1									
		MOV R0, OK_Button								;Moves to R0 the address of "OK_Button"

	Validate:
		MOVB R1, [R0]										;Moves to R1 the value of "OK_Button"
		CMP R1, 1												;Compares the value of R1 with the constant 1
		JNE Validate										;If not equal, jump to  "Validate" address until it does the validation, creating a loop
		POP R1													;Remove the records from the Stack
		POP R0
		RET

;--------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to display wrong option	   				                                   ;
;--------------------------------------------------------------------------------------------------------------------;

	InvalidOptionRoutine:
		MOV R2, Invalid_Option_Screen		;Moves to R2 the address of "Invalid_Option_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Invalid_Option_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		RET

;--------------------------------------------------------------------------------------------------------------------;
;                     				  Show Username And Password On Display Routine		   							                     ;
;--------------------------------------------------------------------------------------------------------------------;

	ShowUserAndPassOnDisplayRoutine:
		PUSH R0													;Saves in the stack the records that are changed in the routine
		PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4
		PUSH R5
		PUSH R6
		PUSH R7
		MOV R0, Username_Start					;Moves to R0 the address of the start of the peripheral Username
		MOV R1, Password_Start					;Move to R1 the address of the start of the peripheral Password
		MOV R2, Asterisk								;Move to R2 the constant "Asterisk"
		MOV R3, Username_Start_Display	;Move to R3 the address of the display where Username will start to be displayed
		MOV R4, Username_End_Display		;Move to R4 the address of the display where Username will end to be displayed
		MOV R5, Password_Start_Display	;Move to R5 the address of the display where Password will start to be displayed
		MOV R6, Password_End_Display		;Move to R6 the address of the display where Password will end to be displayed
		
	CopyUserToDisplayCycle:
		MOVB R7, [R0]										;Moves to R7 the value of R0(first character of Username)
		CMP R7, 0												;Compares the value of R3 with 0, to check if the end of inserted Username was reached
		JEQ CopyPassToDisplayCycle			;If equal, jump to "CopyPassToDisplayCycle"
		MOVB [R3], R7										;Shows in the display the character from username peripheral
		CMP R3, R4											;Compares the beginning of the display for the peripheral of Username with the end
		JEQ CopyPassToDisplayCycle			;If the end of the display was reached, it jumps to "CopyPassToDisplayCycle"
		ADD R0, 1												;Increment 1 to the input peripheral for Username
		ADD R3, 1												;Increment 1 to the display for the introduction of Username
		JMP CopyUserToDisplayCycle			;Repeats the cycle if the Username isn't all copied
		
	CopyPassToDisplayCycle:
		MOVB R7, [R1]										;Move to R3 the value of R1
		CMP R7, 0												;Compares the value of R3 with 0, to check if the end of inserted Password was reached
		JEQ EndOfShowUserAndPassOnDisplayRoutine	;If equal, it jump to "EndOfShowUserAndPassOnDisplayRoutine"
		MOVB [R5], R2										;Shows in the display the character from password peripheral
		CMP R5, R6											;Compares the beginning of the display for the peripheral of Password with the end
		JEQ EndOfShowUserAndPassOnDisplayRoutine	;If you have reached the end of the display, it jumps to the address "EndOfShowUserAndPassOnDisplayRoutine"
		ADD R1, 1												;Increment 1 to the input peripheral referring to Password
		ADD R5, 1												;Increment 1 to the display for the introduction of Password
		JMP CopyPassToDisplayCycle			;Repeats the cycle if the Password isn't all copied
		
	EndOfShowUserAndPassOnDisplayRoutine:
		POP R7													;Remove the records from the Stack
		POP R6
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		POP R0
		RET
;--------------------------------------------------------------------------------------------------------------------;
;                     		 Routine to check how many users are there in the Database	  				                     ;
;--------------------------------------------------------------------------------------------------------------------;

	CheckUsersInDBRoutine:
		PUSH R0													;Saves in the stack the records that are changed in the routine
		PUSH R1
		PUSH R2
		PUSH R3
		MOV R0, DB_Start								;Address of the start of the Database
		MOV R1, DB_End									;Address of the end of the Database
		MOV R2, Iterate_User						;Value that serves to ride a user in user in memory
		MOV R4, 0												;Moves to R4 the value 0 (variable to count number of users)

	CheckCycle:
		CMP R0, R1											;Compares R0 with R1 to check if the end of DB was reached
		JGT EndOfCheckUsersInDBRoutine	;If greater, the end of database was reached
		MOVB R3, [R0]										;Moves to R3 the value of R0
		CMP R3, 0												;Compares R3 with 0
		JEQ EndOfCheckUsersInDBRoutine	;If equal, all users in the memory have been checked, jumps to "EndOfCheckUsersInDBRoutine"
		ADD R4, 1												;Increments 1 to R4 (variable to count number of users)
		ADD R0, R2											;Increments the address in R0 to iterate to the next user
		JMP CheckCycle									;Repeats until all users are checked
	
	EndOfCheckUsersInDBRoutine:
		POP R3													;Remove the records from the stack							
		POP R2
		POP R1
		POP R0
		RET
		