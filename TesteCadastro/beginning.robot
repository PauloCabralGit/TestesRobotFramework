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
