;---------------------------------------------------------------------------------------------------------------------------------------------------------------;
;                                               Trabalho 2 AC - PizzO - Pizzaria Online                                                                         ;
;                                                                                                                                                               ;
;                                                       Joel Freitas - 2031915                                                                                  ;
;                                                       Pedro Jaques - 2046919                                                                                  ;
;---------------------------------------------------------------------------------------------------------------------------------------------------------------;

;Peripherals

  Username       EQU  0150H 	;Address of the input peripheral Username
  Password       EQU  0160H 	;Address of the input peripheral Password
  OK_Button      EQU  0170H 	;OK button address
  NR_SLE_Button  EQU  0180H 	;NR_SEL button address

;Display Adrresses

  Display_Start     EQU		0010H		;Display start address
	Display_End				EQU		007FH		;Display end address
	Username_Start		EQU		0035H		;Start address to display the Username
	Username_End			EQU		003CH		;End address to display the Username
	Password_Start		EQU		0045H		;Start address to display the Password
	Password_End			EQU		004CH		;End address to display the Password
	Total_Euros_Start	EQU		0046H		;Start address to display the total price
	Total_Euros_End		EQU		0048H		;End address to display the total price
	Total_Cent_Start	EQU		004AH		;Start address to display cents
	Total_Cent_End		EQU		004AH		;End address to display cents

;Constants

	CaraterVazio				EQU		20H			;Carater para limpar o écran
	CaraterAsterisco		EQU		2AH			;Caracter asterisco para a apresentação da password
	Pular_User					EQU		30H			;Valor para poder andar de registo em registo na memória (memória de utilizadores)
	Pular_Dentro_User		EQU		10H			;Valor para poder andar entre os vários dados do utilizador (username, password, histórico de compras)
	Total_User					EQU		10			;Valor da totalidade de utilizadores que a memória pode ter
	Tam_User_Pass				EQU		8				;Tamanho que o username/password pode ter
	StackPointer				EQU 	9900H 	;Endereço base da pilha (stack)
	CriarConta					EQU 	1				;Opção fazer login
	Fazerlogin					EQU 	2				;Opção criar conta
	Sair_Registo_Login	EQU		3				;Opção sair do menu principal
	EscolherPizza				EQU		1				;Opção para fazer o pedido da pizza que pretende
	EscolherLogout			EQU		2				;Opção caso o utilizador prentenda fazer logout do site da pizzaria
	SPrimavera					EQU 	1				;Opção para a escolha da pizza Primavera
	SPepperoni					EQU		2				;Opção para a escolha da pizza Pepperoni
	SCarbonara					EQU		3				;Opção para a escolha da pizza Carbonara
	STropical						EQU		4				;Opção para a escolha da pizza Tropical
	SFrango							EQU		5				;Opção para a escolha da pizza Frango
	TPequeno 						EQU		1				;Opção para a escolha do tamanho de pizza pequena
	TGrande							EQU		2				;Opçãp para a escolha do tamanho de pizza grande 
	PizzaPequena				EQU		5				;Valor do custo da pizza pequena
	PizzaGrande					EQU		8				;Valor do custo da pizza grande
	Total_Compras				EQU 	64H			;Total de compras que pode efetuar no momento, ou seja, Total = Histórico + Compras atuais
	PedirMais						EQU		1				;Opção para a escolha de mais pizzas por parte do utilizador
	PagarTotal					EQU 	2				;Opção para a escolha do pagamento do pedido do utilizador
	Tam_Euros						EQU		3				;Tamanho disponível no display para a representação do dinheiro (Parte Euros)
	Pular_Historico			EQU		10H			;Valor para poder andar entre as várias posições de endereço para poder visualizar o valor em euros
	Desconta						EQU		32H			;Valor para subtrair ao histórico caso o valor do histórico seja superior a 50 euros