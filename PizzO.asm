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
	Pizza_Name_Title_End			EQU		001FH		;	End address to display Pizza Name

;Constants

	StackPointer				EQU 	9900H		;Endereço base da pilha (stack)
	CleaningCharacter		EQU		20H			;Cleaning character for the display
	Asterisk						EQU		2AH			;Asterisk character for the presentation of Password

	SmallPrice					EQU		5				;Small Pizza Price
	LargePrice					EQU		9				;Large Pizza Price

	OptNewAccount				EQU 	1				;Create New Account Option
	OptLogin						EQU 	2				;Login Option
	OptExitLoginMenu		EQU		3				;Exit Login Menu Option

	OptOrderPizza				EQU		1				;Order Pizza Option
	OptLogout						EQU		2				;Logout Option

	OptPesto       			EQU		1				;Pesto Pizza Option
	OptFourCheese 			EQU 	2				;Four Cheese Pizza Option
	OptChicken     			EQU 	3				;Chicken Pizza Option
	OptShrimp       		EQU	  4				;Shrimp Pizza Option
	OptHawaii						EQU		5				;Hawaii Pizza Option

	OptSmallPizza				EQU		1				;Small Pizza Option
	OptLargePizza				EQU 	2				;Large Pizza Option

	OptPayment					EQU		1				;Payment Option
	OptOrderMore				EQU		2				;Order More Option

	OptYes							EQU		1				;Yes Option
	OptNo								EQU		2				;No Option

	UserPassMaxSize			EQU		6				;Maximum character size for Username and Password
	MaxUsersInDB				EQU 	5				;Maximum number of users allowed in DB
	Iterate_User				EQU		10H			;Value to be able to iterate between users in Database
	Iterate_User_Info		EQU		6H			;Value to be able to iterate between user info (Username, Password, historic)

	Total_Compras				EQU 	64H			;Total de compras que pode efetuar no momento, ou seja, Total = Histórico + Compras atuais
	PedirMais						EQU		1				;Opção para a escolha de mais pizzas por parte do utilizador
	PagarTotal					EQU 	2				;Opção para a escolha do pagamento do pedido do utilizador
	Tam_Euros						EQU		3				;Tamanho disponível no display para a representação do dinheiro (Parte Euros)
	Pular_Historico			EQU		10H			;Valor para poder andar entre as várias posições de endereço para poder visualizar o valor em euros
	Desconta						EQU		32H			;Valor para subtrair ao histórico caso o valor do histórico seja superior a 50 euros

;Database (Username, Password e purchase history)

	DB_Start	EQU		4000H		;Start address for the Database
	DB_End		EQU		4040H		;End address for the Database

PLACE 3FF0H

	DB_Headers:
		STRING "USER  PASS  HIST"

;-------------------------------------------------------------------------------------------------------------------;
;                     										             Screens/Menus	   				                                    ;
;-------------------------------------------------------------------------------------------------------------------;

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

	Login_Form:
		STRING "     Login      "
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

	Incomplete_Password_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "     Invalid    "
		STRING "    Password!   "
		STRING "At least 3 chars"
		STRING "                "
		STRING " OK to continue "

PLACE 2380H

	DB_Full_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING " Can not create "
		STRING "    Account!    "
		STRING " Full Database! "
		STRING "                "
		STRING " OK to continue "

PLACE 2400H

	Invalid_Option_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING " Invalid Option!"
		STRING " Choose a valid "
		STRING "     option     "
		STRING "                "
		STRING " OK to continue "

PLACE 2480H

	Account_Not_Created_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "  This Account  "
		STRING "     is not     "
		STRING "    created!    "
		STRING "                "
		STRING " OK to continue "
		
PLACE 2500H

	Invalid_Password_Screen:
		STRING "     PizzO      "
		STRING "                "
		STRING "     Invalid    "
		STRING "    Password!   "
		STRING "                "
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
		STRING "                "
		STRING "                "
		STRING "     Sizes:     "
		STRING "1. Small (5 EUR)"
		STRING "2. Large (9 EUR)"
		STRING "                "
		STRING " OK to select   "
		
PLACE 2880H

	Payment_Menu:
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

PLACE 2980H

	Register_Form:
		STRING " 	 New Account  "
		STRING "    Username:   "		
		STRING "                "
		STRING "    Password:   "
		STRING "                "
		STRING "                "
		STRING " OK to continue "

PLACE 3000H

	Pesto:
		STRING "     Pesto      "
	Four_Cheese:
		STRING "   Four Cheese  "
	Chicken:
		STRING "     Chicken    "
	Shrimp:
		STRING "     Shrimp     " 
	Hawaii:
		STRING "     Hawaii     "

;-------------------------------------------------------------------------------------------------------------------;
;                     										             Main Program  	   				                                    ;
;-------------------------------------------------------------------------------------------------------------------;

PLACE 0000H

	Begin:
		MOV R0, Begining								;Moves the address of the tag Start to R0
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
		MOV R2, Login_Menu							;Moves to R2 the address of the "Login_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Login_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadLoginMenuOptions:
		MOV R0, NR_SEL_Button						;Moves to R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Moves to R1 the value of the address "NR_SEL_Button"
		CMP R1, OptNewAccount						;Compares the value of R1 with the constant "OptNewAccount"
		JEQ NewAccountForm							;If the values are equal, jumps to the address "NewAccountForm"
		CMP R1, OptLogin								;Compares the value of R1 with the constant "OptLogin"
		JEQ LoginForm										;If the values are equal, jumps to the address "LoginForm"
		CMP R1, OptExitLoginMenu				;Compares the value of R1 with the constant "OptExitLoginMenu"
		JEQ ConfirmExitMenu							;If equal, jumps to "ConfirmExitMenu"
		CALL InvalidOptionRoutine				;Routine to display invalid option pop up
		JMP LoginMenu										;Goes back to menu if none where selected

	ConfirmExitMenu:
		MOV R2, Confirm_Exit_Menu				;Moves to R2 the address of "Confirm_Exit_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Confirm_Exit_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadExitOptions:
		MOV R0, NR_SEL_Button						;Moves to R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Moves to R1 the content of the address "NR_SEL_Button"
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

	NewAccountForm:
		CALL CheckUsersInDBRoutine			;Routine to check if more users can be added(R4 keeps with number of users in DB)
		MOV R1, MaxUsersInDB						;Moves to R1 the maximum number of users allowed in DB
		CMP R4, R1											;Compares R4 with R1 to check if there is space available in DB
 		JEQ FullDataBasePopUp						;If no space available jumps to full DB screen 
		MOV R2, Register_Form						;Moves to R2 the address of "Register_Form"
		CALL ShowDisplayRoutine					;Routine to display the "Register_Form"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		CALL ShowUserAndPassOnDisplayRoutine		;Routine to Show Username and Password on the display
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		CALL CheckUsername							;Routine to check if the Username inserted is already taken
		CMP R10, UserPassMaxSize				;Compares R10 with UserPassMaxSize constant to check if characters are equal to the one in DB
		JEQ	ExistingUsernamePopUp				;If equal jumps to "ExistingUsernamePopUp"
		CALL CheckFormFieldsCycle				;Routine to check if any field was left empty
		CMP R9, 0												;Compares the value of R9 (amount of characters that Username has) with 0
		JEQ MissingFieldPopUp						;If equal, no Username was inserted, jumps to "MissingFieldPopUp"
		CMP R10, 0											;Compares the value of R10 (amount of characters that Password has) with 0
		JEQ MissingFieldPopUp						;If equal, no Password was inserted, jumps to "MissingFieldPopUp"
		CMP R10, 3											;Compares the value of R10 (amount of characters that Password has) with 3
		JLT IncompletePasswordPopUp			;If less, the Password was incomplete(at least 3 characters), jumps to "IncompletePasswordPopUp"
		CALL SaveUserInDBRoutine				;Routine to save new user to the Database
		JMP	AccountCreatedWithSuccess		;After creating account jumps to "AccountCreatedWithSuccess"

	FullDataBasePopUp:
		MOV R2, DB_Full_Screen					;Moves to R2 the address of "DB_Full_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "DB_Full_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP LoginMenu										;Jumps back to "LoginMenu"

	ExistingUsernamePopUp:
		MOV R2, Existing_Username_Screen	;Moves to R2 the address of "Existing_Username_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Existing_Username_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP LoginMenu										;Jumps back to "LoginMenu"

	MissingFieldPopUp:
		MOV R2, Missing_Field_Screen		;Moves to R2 the address of "Missing_Field_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Missing_Field_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP LoginMenu										;Jumps back to "LoginMenu"

	IncompletePasswordPopUp:
		MOV R2, Incomplete_Password_Screen	;Moves to R2 the address of "Incomplete_Password_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Incomplete_Password_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP LoginMenu										;Jumps back to "LoginMenu"

	AccountCreatedWithSuccess:
		MOV R2, Account_Created_Screen	;Moves to R2 the address of "Account_Created_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Account_Created_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options

	LoginForm:
		MOV R2, Login_Form							;Moves to R2 the address of "Login_Form"
		CALL ShowDisplayRoutine					;Routine to display the "Login_Form"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL ValidateRoutine						;Routine to validate the selected options
		CALL ShowUserAndPassOnDisplayRoutine		;Routine to Show Username and Password on the display
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		CALL CheckUsername							;Routine to check if the Username inserted is equal to any on the DB
		CMP R10, UserPassMaxSize				;Compares R10 with UserPassMaxSize constant to check if Username exists in DB
		JLT	UsernameNotFound						;If less than 6, it means that the Username inserted is not in the Database, so jumps to "UsernameNotFound"
		CALL CheckPassword							;Routine to check the Username and Password
		CMP R10, UserPassMaxSize				;Compares R10 with UserPassMaxSize constant to check if Username exists in DB
		JLT	InvalidPassword							;If less than 6, it means that the Password inserted is not correct Database, so jumps to "InvalidPassword"
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		JMP	MainMenu

	UsernameNotFound:
		MOV R2, Account_Not_Created_Screen	;Moves to R2 the address of "Account_Not_Created_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Account_Not_Created_Screen"
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP LoginMenu										;Jumps back to the LoginMenu

	InvalidPassword:
		MOV R2, Invalid_Password_Screen	;Moves to R2 the address of "Invalid_Password_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Invalid_Password_Screen"
		CALL CleanUserPassRoutine				;Routine to clean the Username and Password inputs
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP LoginForm										;Jumps back to the LoginForm

	MainMenu:
		MOV R2, Main_Menu								;Moves to R2 the address of "Main_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Main_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadMainMenuOptions:
		MOV R0, NR_SEL_Button						;Moves to R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Moves to R1 the content of the address "NR_SEL_Button"
		CMP R1, OptOrderPizza						;Compares the value of R1 with the constant "OptOrderPizza"
		JEQ	PizzaMenu										;If true jumps to "ExitProgram"
		CMP R1, OptLogout								;Compares the value of R1 with the constant "OptLogout"
		JEQ	ConfirmExitMenu							;If true jumps to "ConfirmExitMenu"
		CALL InvalidOptionRoutine				;If the option selected does not exist calls routine to display invalid option pop up
		JMP MainMenu										;Goes back to menu if none where selected

	PizzaMenu:
		MOV R2, Pizza_Menu							;Moves to R2 the address of "Pizza_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Pizza_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadPizzaMenuOptions:
		MOV R0, NR_SEL_Button						;Moves to R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Moves to R1 the content of the address "NR_SEL_Button"
		CMP R1, OptPesto								;Compares the value of R1 with the constant "OptPesto"
		MOV R2, Pesto										;Moves to R2 the address of "Pesto"
		JEQ	PizzaSizeMenu								;If true jumps to "PizzaSizeMenu"
		CMP R1, OptFourCheese						;Compares the value of R1 with the constant "OptFourCheese"
		MOV R2, Four_Cheese							;Moves to R2 the address of "Four_Cheese"
		JEQ	PizzaSizeMenu								;If true jumps to "PizzaSizeMenu"
		CMP R1, OptChicken							;Compares the value of R1 with the constant "OptChicken"
		MOV R2, Chicken									;Moves to R2 the address of "Chicken"
		JEQ	PizzaSizeMenu								;If true jumps to "PizzaSizeMenu"
		CMP R1, OptShrimp								;Compares the value of R1 with the constant "OptShrimp"
		MOV R2, Shrimp									;Moves to R2 the address of "Shrimp"
		JEQ	PizzaSizeMenu								;If true jumps to "PizzaSizeMenu"
		CMP R1, OptHawaii								;Compares the value of R1 with the constant "OptHawaii"
		MOV R2, Hawaii									;Moves to R2 the address of "Hawaii"
		JEQ	PizzaSizeMenu								;If true jumps to "PizzaSizeMenu"
		CALL InvalidOptionRoutine				;If the option selected does not exist calls routine to display invalid option pop up
		JMP PizzaMenu										;Goes back to menu if none where selected

	PizzaSizeMenu:	
		CALL ShowPizzaNameRoutine				;Routine to display pizza name on title
		MOV R2, Pizza_Size_Menu					;Moves to R2 the address of "Pizza_Size_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Pizza_Size_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadPizzaSizeOptions:
		MOV R0, NR_SEL_Button						;Moves to R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Moves to R1 the value of "NR_SEL_Button"
		CMP R1, OptSmallPizza						;Compares the value of R1 with the constant "OptSmallPizza" (1)
		MOV R3, SmallPrice							;Saves the small pizza price in R3 (5€)
		JEQ	PaymentMenu									;If true jumps to "PaymentMenu"
		CMP R1, OptLargePizza						;Compares the value of R1 with the constant "OptLargePizza" (2)
		MOV R3, LargePrice							;Saves the large pizza price in R3 (9€)
		JEQ	PaymentMenu									;If true jumps to "PaymentMenu"
		CALL InvalidOptionRoutine				;If the option selected does not exist calls routine to display invalid option pop up
		JMP PizzaSizeMenu								;Goes back to menu if none where selected

	PaymentMenu:
		MOV R2, Payment_Menu						;Moves to R2 the address of "Payment_Menu"
		CALL ShowDisplayRoutine					;Routine to display the "Payment_Menu"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options

	ReadPaymentMenuOptions:
		MOV R0, NR_SEL_Button						;Moves to R0 the address of the peripheral "NR_SEL_Button"
		MOVB R1, [R0]										;Moves to R1 the value of "NR_SEL_Button"
		CMP R1, OptOrderMore						;Compares the value of R1 with the constant "OptOrderMore" (1)
		JEQ	PizzaMenu										;If true jumps to "PizzaMenu"
		CMP R1, OptPayment							;Compares the value of R1 with the constant "OptPayment" (2)
		JEQ	PaymentScreen								;If true jumps to "PaymentScreen"
		CALL InvalidOptionRoutine				;If the option selected does not exist calls routine to display invalid option pop up
		JMP PaymentMenu									;Goes back to menu if none where selected
		
	PaymentScreen:
		MOV R2, Payment_Screen					;Moves to R2 the address of "Payment_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Payment_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		JMP	MainMenu

;-------------------------------------------------------------------------------------------------------------------;
;																									End Main Program																									;
;-------------------------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------------------------;
;																							Routine to clean the display																					;
;-------------------------------------------------------------------------------------------------------------------;

	CleanDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R2
		MOV R0, Display_Start						;Moves to R0 the address "Display_Start"
		MOV R1, Display_End							;Moves to R1 the address "Display_End"
		MOV R2, CleaningCharacter				;Moves to R2 the "CleaningCharacter" (20H)
		
	CleanDisplayCicle:
		MOVB [R0], R2										;Moves to the current Display address the CleaningCharacter to clean the Display
		CMP R0, R1											;Compares the address of the start of the Display with the address of the end of the display
		JGE EndOfCleaningRoutine				;If equal, the display is clean and terminates the routine
		ADD R0, 1												;Adds 1 to the current address of the Display to move to the next position on the display
		JMP CleanDisplayCicle						;If the end of the display hasn't been reached yet, repeat the cycle
		
	EndOfCleaningRoutine:
		POP R2													;Removes from Stacks the records
		POP R1
		POP R0
		RET	

;-------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to clean the Peripherals 			                                     	;
;-------------------------------------------------------------------------------------------------------------------;

	CleanPeripheralsRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		PUSH R2	
		MOV R0, OK_Button								;Moves to R0 the address of the peripheral "OK_Button"
		MOV R1, NR_SEL_Button						;Moves to R1 the address of the peripheral "NR_SEL_Button"
		MOV R2, 0												;Moves to R2 the constant 0
		MOVB [R0], R2										;Puts 0 in the peripheral "OK_Button"
		MOVB [R1], R2										;Puts 0 in the peripheral "NR_SEL_Button"

	EndOfCleanPeripheralsRoutine:
		POP R2													;Removes from Stack the records
		POP R1									
		POP R0									
		RET

;-------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to show the Display  	 				                                     	;
;														 The Menu/Screen to display comes in the register R2																	 	;
;-------------------------------------------------------------------------------------------------------------------;

	ShowDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R3
		MOV R0, Display_Start						;Moves to R0 the address of "Display_Start"
		MOV R1, Display_End							;Moves to R1 the address of "Display_End"
		
	ShowDisplayCycle:	
		MOV R3, [R2]										;Moves from R2(the menu/screen to display) to R3
		MOV [R0], R3										;Moves to the display all the information on the menu/screen		
		CMP R0, R1											;Compares the address of the start of the Display with the address of the end of the display
		JGE EnfOfShowDisplayRoutine			;If equal, everythig has been displayed, so terminates the routine		
		ADD R2, 2												;Increments 2 to R2, to move to the next byte to be displayed
		ADD R0, 2												;Increments 2 to the value of the display memory to display the next byte
		JMP ShowDisplayCycle						;Repeats the cycle
		
	EnfOfShowDisplayRoutine:
		POP R3													;Removes from Stacks the records 
		POP R1
		POP R0
		RET	

;-------------------------------------------------------------------------------------------------------------------;
;                     			 Routine to Show Pizza Name(R2) on the title of Pizza Size Menu	                        ;
;-------------------------------------------------------------------------------------------------------------------;
	
	ShowPizzaNameRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine									
		PUSH R1
		PUSH R3
		MOV R0, Display_Start						;Moves to R0 the address of "Display_Start"
		MOV R1, Pizza_Name_Title_End		;Moves to R1 the address of "Pizza_Name_Title_End"

	CopyToDisplayPizzaNameCycle:
		MOV R3, [R2]										;Moves from R2(the pizza name to display) to R3
		MOV [R0], R3										;Moves to the display the pizza name
		CMP R0, R1											;Compares the address of "Display_Start" with the address "Pizza_Name_Title_End"
		JGE EnfOfShowPizzaNameRoutine		;If equal, everythig has been displayed, so terminates the routine
		ADD R3, 2												;Increments 2 to R3, to move to the next byte to be displayed
		ADD R0, 2												;Increments 2 to the value of the display memory to display the next byte
		JMP CopyToDisplayPizzaNameCycle	;Jump to the address "CopyToDisplayPizzaNameCycle"
		
	EnfOfShowPizzaNameRoutine:
		POP R3													;Removes from Stacks the records							
		POP R1
		POP R0
		RET	
	
;-------------------------------------------------------------------------------------------------------------------;
;                     					  Routine to clean the Username and Password 				                                ;
;-------------------------------------------------------------------------------------------------------------------;

	CleanUserPassRoutine: 
		PUSH R0													;Saves in Stack the records that are changed during the routine		
		PUSH R1
		PUSH R2
		MOV R0, Username_Start					;Moves to R0 the address of "Username_Start"(address of the starting input of Username)
		MOV R1, OK_Button								;Moves to R1 the address of "OK_Button"(before this address stays the address of the end of de Password input peripheral)
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
		
;-------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to validate the Button OK  				                                  ;
;-------------------------------------------------------------------------------------------------------------------;

	ValidateRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1									
		MOV R0, OK_Button								;Moves to R0 the address of "OK_Button"

	Validate:
		MOVB R1, [R0]										;Moves to R1 the value of "OK_Button"
		CMP R1, 1												;Compares the value of R1 with 1
		JNE Validate										;If not equal, jump to  "Validate" address until it does the validation, creating a loop

	EndOfValidateRoutine:
		POP R1													;Remove the records from the Stack
		POP R0
		RET

;-------------------------------------------------------------------------------------------------------------------;
;                     						      Routine to display wrong option	   				                                  ;
;-------------------------------------------------------------------------------------------------------------------;

	InvalidOptionRoutine:
		MOV R2, Invalid_Option_Screen		;Moves to R2 the address of "Invalid_Option_Screen"
		CALL ShowDisplayRoutine					;Routine to display the "Invalid_Option_Screen"
		CALL CleanPeripheralsRoutine		;Routine to clean the input peripherals
		CALL ValidateRoutine						;Routine to validate the selected options
		RET

;-------------------------------------------------------------------------------------------------------------------;
;                     				  Show Username And Password On Display Routine		 							                     	;
;-------------------------------------------------------------------------------------------------------------------;

	ShowUserAndPassOnDisplayRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
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
		MOVB [R3], R7										;Shows in the display the character from Username peripheral
		CMP R3, R4											;Compares the beginning of the display for the peripheral of Username with the end
		JEQ CopyPassToDisplayCycle			;If the end of the display was reached, it jumps to "CopyPassToDisplayCycle"
		ADD R0, 1												;Increment 1 to the input peripheral for Username
		ADD R3, 1												;Increment 1 to the display for the introduction of Username
		JMP CopyUserToDisplayCycle			;Repeats the cycle if the Username isn't all copied
		
	CopyPassToDisplayCycle:
		MOVB R7, [R1]										;Move to R3 the value of R1
		CMP R7, 0												;Compares the value of R3 with 0, to check if the end of inserted Password was reached
		JEQ EndOfShowUserAndPassOnDisplayRoutine	;If equal, it jump to "EndOfShowUserAndPassOnDisplayRoutine"
		MOVB [R5], R2										;Shows in the display the character from Password peripheral
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

;-------------------------------------------------------------------------------------------------------------------;
;                     		 Routine to check how many users are there in the Database	  				                    ;
;-------------------------------------------------------------------------------------------------------------------;

	CheckUsersInDBRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R2
		PUSH R3
		MOV R0, DB_Start								;Move to R0 the address of the start of the Database
		MOV R1, DB_End									;Move to R1 the address of the end of the Database
		MOV R2, Iterate_User						;Value that serves to iterate a user in user in memory
		MOV R4, 0												;Moves to R4 the value 0 (variable to count number of users)

	CheckCycle:
		CMP R0, R1											;Compares R0 with R1 to check if the end of DB was reached
		JGT EndOfCheckUsersInDBRoutine	;If greater, the end of Database was reached
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

;-------------------------------------------------------------------------------------------------------------------;
;                     		 Routine to check if a Username already exists in the Database 			                     	;
;-------------------------------------------------------------------------------------------------------------------;

	CheckUsername:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4
		PUSH R5
		PUSH R6
		PUSH R7
		PUSH R8
		MOV R0, Username_Start					;Moves to R0 the start of the Username peripheral
		MOV R1, Username_End						;Moves to R1 the end of the Username peripheral
		MOV R2, DB_Start								;Moves to R3 the start of the Database
		MOV R3, DB_End
		MOV R4, Iterate_User						
		MOV R5, Iterate_User_Info
		MOV R6, 0
		
	VerificationCycle:
		CMP R2, R3											;Check if the end of the database as been reached
		JGT	EndOfCheckUsername					;If yes, jumps to the end of the routine
		CMP R0, R1											;Check if the end of the Username peripheral was reached
		JGT	NextUserCycle								;If yes, Username all checked, jumps to "NextUserCycle"
		MOVB R7, [R0]										;Moves to R7 the value of the first character in the input
		MOVB R8, [R2]										;Moves to R8 the value of the first character in the Database
		CMP R7, R8											;Compares it with the first character of the first Username in the database
		JNE	NextUserCycle								;If not equal, jumps to "NextUserCycle"
		ADD R6, 1												;Adds 1 to the variable that saves the number of equal characters
		CMP R6,	6												;Compares with 6 to check if all characters are equal
		JEQ	EndOfCheckUsername					;If equal, jumps to "EndOfCheckUsername"
		ADD R0, 1												;Adds 1 to move to next character on the Username
		ADD R2, 1												;Adds 1 to move to next character on the database
		JMP VerificationCycle						;Repeats the cycle until all Username is checked

	NextUserCycle:
		MOV R0, Username_Start					;Resets R0 to the begin os Username peripheral
		SUB R2, R5											;Goes back to the address of begin of username in database
		ADD R2, R4											;Adds R2 to R4 to iterate to the next user in the Database
		JMP	VerificationCycle						;Goes back to "VerificationCycle"

	EndOfCheckUsername:
		MOV R10, R6											;Moves the number of equal chars to R10
		POP R8													;Remove the records from the stack
		POP R7
		POP R6
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		POP R0
		RET

;-------------------------------------------------------------------------------------------------------------------;
;                     		 Routine to check if a Password already exists in the Database 		                        ;
;-------------------------------------------------------------------------------------------------------------------;

	CheckPassword:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4
		PUSH R5
		PUSH R6
		PUSH R7
		PUSH R8
		MOV R0, Password_Start					;Moves to R0 the address of the start of the Password peripheral
		MOV R1, Password_End						;Moves to R1 the address of the end of the Password peripheral
		MOV R2, DB_Start								;Moves to R2 the address of the start of the Database
		MOV R3, DB_End									;Moves to R3 the address of the end of the Database
		MOV	R4, Iterate_User
		MOV R5, Iterate_User_Info				
		MOV R6, 0												;Moves to R6 the constant 0, this will be counting how many characters are equal
		ADD R2, R5											;Jumps to the address where the password is saved in database
	
	VerificatePasswordCycle:
		CMP R2, R3											;Check if the end of the database as been reached
		JGT	EndOfCheckPassword					;If yes, jumps to the end of the routine
		CMP R0, R1											;Compares start of Password input peripheral with the end of it
		JGT	NextPasswordCycle						;If equal, Password all checked, jumps to "NextPasswordCycle"
		MOVB R7, [R0]										;Moves to R5 the value of the first character in the input
		MOVB R8, [R2]										;Moves to R6 the value of the first character in the Database
		CMP R7, R8											;Compares it with the first character of the first Password in the database
		JNE	NextPasswordCycle						;If not equal, jumps to "NextPasswordCycle"
		ADD R6, 1												;Adds 1 to the variable that saves the number of equal characters
		CMP R6,	6												;Compares with 6 to check if all characters are equal
		JEQ	EndOfCheckPassword					;If equal, jumps to "EndOfCheckPassword"
		ADD R0, 1												;Adds 1 to move to next character on the Password
		ADD R2, 1												;Adds 1 to move to next character on the database
		JMP VerificatePasswordCycle			;Repeats the cycle until all Password is checked

	NextPasswordCycle:
		MOV R0, Password_Start					;Resets R0 to the begin os Password peripheral
		SUB R3, R5											;Resets R3 to the begin of the Password in the Database
		ADD R3, R4											;Jumps R3 address to the start os Password address in the Database
		JMP	VerificatePasswordCycle			;Goes back to "VerificatePasswordCycle"

	EndOfCheckPassword:
		MOV R10, R6											;Moves the number of equal chars to R10
		POP R8													;Remove the records from the stack
		POP R7
		POP R6
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		POP R0
		RET

;-------------------------------------------------------------------------------------------------------------------;
;                     				 Routine to check if any field on the form was left empty				                     	;
;-------------------------------------------------------------------------------------------------------------------;

	CheckFormFieldsCycle:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4
		MOV R0, Username_Start_Display	;Moves to R0 the address of the start of the input peripheral Username
		MOV R1, Username_End_Display		;Moves to R1 the address of the end of the input peripheral Username
		MOV R2, Password_Start_Display	;Moves to R2 the address of the start of the input peripheral Password
		MOV R3, Password_End_Display		;Moves to R3 the address of the start of the input peripheral Password
		MOV R9, 0												;Flag: 0 - no Username, >1 - has Username
		MOV R10, 0											;Flag: 0 - no Password, >1 - has Password
		
	CheckUserFieldCycle:
		CMP R0, R1											;Compares the start of the Username peripheral with the end
		JGT CheckPassFieldCycle					;If greater, the peripheral was all checked, jumps to "CheckPassFieldCycle"
		MOVB R4, [R0]										;Moves to R4 the value of the R0 address
		CMP R4, 0												;Compares the value of R4 (character of the Username peripheral) with 0
		JNE CheckPassFieldCycle					;If different, the Username peripheral contains written characters, jumps to the "CheckPassFieldCycle"
		ADD R0, 1												;Increments 1 to R0 (next character of the Username peripheral)
		ADD R9, 1
		JMP CheckUserFieldCycle					;Repeats the cycle until all Username is checked

	CheckPassFieldCycle:
		CMP R2, R3											;Compares the start of the Password peripheral with the end
		JGT EndOFCheckFormFieldsCycle 	;If greater, the peripheral was all checked, jumps to "EndOFCheckFormFieldsCycle"
		MOVB R4, [R2]										;Moves to R4 the content of the address of R2
		CMP R4, 0												;Compares the value of R4 (character of th Password peripheral) with 0
		JNE EndOFCheckFormFieldsCycle		;If different, the Password input peripheral contains written characters, jumps to "EndOFCheckFormFieldsCycle"
		ADD R2, 1												;Increments 1 to the value of the R2 (next Password peripheral character)
		ADD R10, 1											;Increments the flag that tells if there are characters
		JMP CheckPassFieldCycle					;Repeats the cycle until all Password is checked				

	EndOFCheckFormFieldsCycle:
		POP R4													;Remove the records from the stack
		POP R3
		POP R2
		POP R1
		POP R0
		RET
		

;-------------------------------------------------------------------------------------------------------------------;
;                     		 Routine to save in the Database the Username and Password	  			                     	;
;-------------------------------------------------------------------------------------------------------------------;

	SaveUserInDBRoutine:
		PUSH R0													;Saves in Stack the records that are changed during the routine
		PUSH R1
		PUSH R2
		PUSH R3
		PUSH R4
		PUSH R5
		PUSH R6
		PUSH R7	
		PUSH R8	
		MOV R0, DB_Start								;Move to R0 the address of the start of the Database
		MOV R1, Iterate_User						;Move to R1 the constant "Iterate_User" to iterate between users
		MOV R2, Iterate_User_Info				;Move to R2 the constant "Iterate_User_Info" to iterate between the user info (Username, Password and Historic of Purchase)
		MOV R3, Username_Start					;Move to R3 the address of the start of the peripheral Username
		MOV R4, Username_End						;Move to R4 the address of the end of the peripheral Username
		MOV R5, Password_Start					;Move to R5 the address of the start of the peripheral Password
		MOV R6, Password_End						;Move to R6 the address of the end of the peripheral Password
		
	CheckPositionToSaveNewUser:
		MOV R7, R0											;Moves to R7 the address of the start of the Database
		MOVB R8, [R0]										;Moves to R8 the value of the first byte of the Username on Database
		CMP R8, 0												;Compares R8 with the constant 0						
		JEQ SaveUsernameCycle						;If equal, there is no user in that position of the Database, jump to "SaveUsernameCycle"
		ADD R0, R1											;Adds R1 to R0 to iterate to next user position
		JMP CheckPositionToSaveNewUser	;Repeats untill an empty position is found in the Database
		
	SaveUsernameCycle:
		MOVB R8, [R3]										;Moves to R8 the character in the first position of the Username peripheral
		CMP R8, 0												;Compares the character with 0
		JEQ JumpToPasswordPosition			;If equal, Username's saving is over and jumps to "JumpToPasswordPosition"
		MOVB [R0], R8										;Writes character in Database position
		CMP R3, R4											;Compares the start of Username peripheral with the end
		JEQ JumpToPasswordPosition			;If equal, jumps to the "JumpToPasswordPosition"
		ADD R0, 1												;Increments 1 to the actual Database address to write the next Username character
		ADD R3, 1												;Increments 1 to the address of Username peripheral to check the next character
		JMP SaveUsernameCycle						;If the Username haven't been all written in the Database, repeats the cycle
		
	JumpToPasswordPosition:
		ADD R7, R2											;Adds R2 to R7 to place the start of the Password position in the Database in R7
		MOV R0, R7											;Moves to R0 the place to begin writing the Password in the Database
		
	SavePasswordCycle:
		MOVB R8, [R5]										;Moves to R8 the character of the peripheral Password
		CMP R8, 0												;Compares the value R8 with 0
		JEQ EndOfSaveUserInDBRoutine		;If equal, the Password writing is over and jumps to "EndOfSaveUserInDBRoutine"
		MOVB [R0], R8										;Writes Password character in Database
		CMP R5, R6											;Compares the start of Password peripheral with the end
		JEQ EndOfSaveUserInDBRoutine		;If equal, jumps to "EndOfSaveUserInDBRoutine"
		ADD R0, 1												;Increments 1 to the actual Database address to write the next Password character
		ADD R5, 1												;Increments 1 to the address of Password peripheral to check the next character
		JMP SavePasswordCycle						;If the Password haven't been all written in the Database, repeats the cycle
		
	EndOfSaveUserInDBRoutine:
		POP R8													;Remove the records from the stack
		POP R7
		POP R6
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		POP R0
		RET