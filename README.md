# PizzO - Online Pizzeria

## 1. Description of the project

### 1.1. Specifying the problem

In this project the students will develop a program that allows the control of online food orders for a pizza delivery company. The graphical interface (or display) should simulate the web page where customers place their orders online. The display (output peripheral) has 7x16 dimensions (7 lines of 16 characters - bytes). The processor to be used will be PEPE, as illustrated in Annex I.

Customers must be registered to place the order. It should then be possible, in case a customer is not registered, to create the registration to later login and place an order. In this registration a Username and Password is entered by the user, which will be stored in the application's database if the registration is valid. It should not be possible to register if any of the fields are not filled in. The Password must be at least 3 characters long. The screen should display the ASCII code corresponding to the Username (e.g., if the user enters one of the characters with the hexadecimal value 41, the screen should display "A"). When entering the Password, the character "*" shall be shown on the screen as a form of privacy in the characters filled in by the user. If the login is incorrect or the registration is not valid, the user should be informed.

After validating the login, or after a registration is made, the user must be able to choose between placing an order or logging out of the system.

When choosing to place an order, five different pizzas should be available for choice, with each variety having two sizes available, small and large. The small pizzas cost 5€ and the large ones 9€.

For every 50€ spent by a customer, they are entitled to a 50% discount on the smallest pizza in their next order (or current order, if it brings their total to over 50€ spent). For example, assume that a customer has in his order history a total value of 45€, and the order he is currently placing makes the total value in history equal to or greater than 50€. In this case, this order will get a 50% discount on the lowest value pizza.

When the order is finalized, the user should be shown the discount granted and the final value of the order.

### 1.2. User Interface

The user interface will be done through a display (output peripheral), with 7x16 dimensions (7 lines of 16 characters - bytes). Initially the main menu is presented on the display, which provides the options to login or register a new client. The user interaction with the system is done through the input peripherals.

Input peripherals:

* Username
* Password
* Botão OK
* Botão NR_SEL

Username and Password peripherals are used for login and client registration. Each of them consists of 8 characters.

The Butão OK is used to validate the numeric option chosen (by entering the desired number in the NR_SEL peripheral) in menus that allow multiple options to be chosen. In each menu, the various options must be listed and then validated using this button.
