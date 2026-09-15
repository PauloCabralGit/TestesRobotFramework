*** Settings ***
Documentation      criacao de cadastro
Resource    Resourse.robot


*** Test Cases ***

CN001: Successful user registration
     Give access to the site "https://automationexercise.com/login"
     And I enter the name "Paulo Cabral"
     And I enter the email "paulocabral_90@hotmail.com"
     And I click on Signup
     And I fill in all the fields
     When I click on Register
     Then I close the browser
CN002: Verify required fields
     Give access to the site "https://automationexercise.com/login"
     And I click on Signup
     Then I confirm that the signup form is still displayed
     And I enter on login email "paulocabral_90@hotmail.com"
     And I enter the password "SenhaTeste123"
     And I click on Login
     Then I close the browser
CN003: By product registration
     Give access to the site "https://automationexercise.com/login"
     And I enter on login email "paulocabral_90@hotmail.com"
     And I enter the password "SenhaTeste123"
     And I click on login
     then I click on "Woman"
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
     Then I close the browser
CN004: Delete account
     Give access to the site "https://automationexercise.com/login"
     And I enter on login email "paulocabral_90@hotmail.com"
     And I enter the password "SenhaTeste123"
     And I click on Login
     And I delete the account
     Then I close the browser