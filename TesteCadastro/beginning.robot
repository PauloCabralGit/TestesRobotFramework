*** Settings ***
Documentation      Fluxos web de cadastro, login, compra e exclusao de conta.
...                Cada teste cria o proprio usuario (e-mail unico) e o remove no teardown,
...                entao os testes sao independentes e podem rodar em qualquer ordem.
Resource           Resourse.robot
Test Teardown      Clean up the test user


*** Test Cases ***

CN001: Successful user registration
    [Tags]    web    smoke    critico    cadastro
    I have a unique test user
    Give access to the site "${Login_URL}"
    And I enter the name "${User_Name}"
    And I enter the email "${User_Email}"
    And I click on Signup
    And I fill in all the fields
    When I click on Register
    Then I confirm that the account was created

CN002: Verify required fields
    [Tags]    web    regressao    cadastro
    Give access to the site "${Login_URL}"
    And I click on Signup
    Then I confirm that the signup form is still displayed

CN003: By product registration
    [Tags]    web    regressao    critico    compra
    I have a registered user who is logged in
    When I click on "Woman"
    And I click on "Dress"
    And I click on "Add to cart"
    Then I confirm that the product was added to the cart
    And I click on "Continue Shopping"
    And I click on "View Cart"
    And I click on "Proceed To Checkout"
    And I click on "Place Order"
    And I fill in the payment details
    And I click on "Pay and Confirm Order"
    Then I confirm that the order was placed successfully

CN004: Delete account
    [Tags]    web    regressao    conta
    I have a registered user who is logged in
    And I delete the account
    Then I confirm that the account was deleted

CN008: Successful login
    [Tags]    web    smoke    critico    login
    I have a registered user who is logged in
    And I log out
    And I enter on login email "${User_Email}"
    And I enter the password "${User_Password}"
    And I click on Login
    Then I confirm that I am logged in

CN005: Login with wrong password is rejected
    [Tags]    web    regressao    login
    I have a registered user who is logged in
    And I log out
    And I enter on login email "${User_Email}"
    And I enter the password "SenhaErrada!999"
    And I click on Login
    Then I confirm that the login was rejected

CN016: Add multiple products to the cart
    [Documentation]    Dois produtos diferentes da categoria Dress entram no carrinho (sem login),
    ...                cada um em sua linha, com quantidade 1 e total = preco x quantidade.
    [Tags]    web    regressao    critico    compra    carrinho
    Give access to the site "${Base_URL}"
    And I click on "Woman"
    And I click on "Dress"
    And I add the product "3" to the cart
    And I add the product "38" to the cart
    When I click on "View Cart"
    Then I confirm that the cart has 2 different products
    And I confirm that the cart contains the product "3" with quantity "1"
    And I confirm that the cart contains the product "38" with quantity "1"
    And I confirm that the line total of the product "3" is price times quantity
    And I confirm that the line total of the product "38" is price times quantity

CN006: Login with unregistered email is rejected
    [Tags]    web    regressao    login
    I have a unique test user
    Give access to the site "${Login_URL}"
    And I enter on login email "${User_Email}"
    And I enter the password "${User_Password}"
    And I click on Login
    Then I confirm that the login was rejected

CN007: Signup with an already registered email is rejected
    [Tags]    web    regressao    cadastro
    I have a registered user who is logged in
    And I log out
    And I enter the name "${User_Name}"
    And I enter the email "${User_Email}"
    And I click on Signup
    Then I confirm that the signup was rejected because the email already exists

CN017: Adding the same product twice increases the quantity
    [Documentation]    O mesmo produto adicionado duas vezes gera uma unica linha com quantidade 2.
    [Tags]    web    regressao    compra    carrinho
    Give access to the site "${Base_URL}"
    And I click on "Woman"
    And I click on "Dress"
    And I add the product "3" to the cart
    And I add the product "3" to the cart
    When I click on "View Cart"
    Then I confirm that the cart has 1 different products
    And I confirm that the cart contains the product "3" with quantity "2"
    And I confirm that the line total of the product "3" is price times quantity

CN014: Remove one product from the cart
    [Documentation]    Remover um produto tira so a linha dele; o outro produto permanece.
    [Tags]    web    regressao    compra    carrinho
    Give access to the site "${Base_URL}"
    And I click on "Woman"
    And I click on "Dress"
    And I add the product "3" to the cart
    And I add the product "38" to the cart
    And I click on "View Cart"
    And I remove the product "3" from the cart
    Then I confirm that the cart has 1 different products
    And I confirm that the cart does not contain the product "3"
    And I confirm that the cart contains the product "38" with quantity "1"
