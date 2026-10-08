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

CN009: Logout ends the session
    [Tags]    web    regressao    login
    I have a registered user who is logged in
    And I log out
    Then I confirm that I am logged out

CN010: Checkout is not possible with an empty cart
    [Tags]    web    regressao    compra    carrinho
    Give access to the site "${Base_URL}"
    When I open the cart page
    Then I confirm that the cart is empty

CN013: Payment with empty card fields is blocked
    [Tags]    web    regressao    compra    pagamento
    I have a registered user who is logged in
    And I am at the payment page with one product in the cart
    When I click on "Pay and Confirm Order"
    Then I confirm that the payment was rejected

CN023: Payment with invalid card data is rejected
    [Documentation]    DEFEITO CONHECIDO: o site aceita cartao invalido (numero "abcd", CVC de 2 digitos,
    ...                mes 99, ano 1999) e confirma o pedido. O teste afirma o comportamento correto e
    ...                fica como SKIP no CI (--skiponfailure known-bug) ate o site corrigir.
    [Tags]    web    regressao    compra    pagamento    known-bug
    I have a registered user who is logged in
    And I am at the payment page with one product in the cart
    And I fill in the payment details with name "Paulo Cabral" number "abcd" cvc "12" month "99" year "1999"
    When I click on "Pay and Confirm Order"
    Then I confirm that the payment was rejected

CN015: Deleted account cannot log in again
    [Tags]    web    regressao    conta    login
    I have a registered user who is logged in
    And I delete the account
    Then I confirm that the account was deleted
    And Give access to the site "${Login_URL}"
    And I enter on login email "${User_Email}"
    And I enter the password "${User_Password}"
    And I click on Login
    Then I confirm that the login was rejected

CN019: Search for an existing product returns results
    [Tags]    web    regressao    busca
    Give access to the site "${Base_URL}"
    When I search for the product "Dress"
    Then I confirm that the search returned products

CN021: Search for a non-existent product returns no results
    [Tags]    web    regressao    busca
    Give access to the site "${Base_URL}"
    When I search for the product "zzzxxqq"
    Then I confirm that the search returned no products

CN020: Product details page shows the product information
    [Tags]    web    regressao    produto
    Give access to the site "${Base_URL}"
    When I open the details of the product "3"
    Then I confirm that the product details are displayed

CN022: Quantity chosen on the details page goes to the cart
    [Tags]    web    regressao    compra    carrinho    produto
    Give access to the site "${Base_URL}"
    And I open the details of the product "3"
    And I add the product from the details page with quantity "3"
    When I open the cart page
    Then I confirm that the cart has 1 different products
    And I confirm that the cart contains the product "3" with quantity "3"
    And I confirm that the line total of the product "3" is price times quantity
