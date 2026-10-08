*** Settings ***

Library    SeleniumLibrary
Library    Process
Library    Screenshot
Library    DateTime

*** Variables ***

${BROWSER}                  chrome
${Base_URL}                 https://automationexercise.com
${Login_URL}                ${Base_URL}/login

# Dados de teste (fictícios). O e-mail é gerado a cada teste (ver Test Setup).
${User_Name}                Paulo Cabral
${User_Password}            SenhaTeste123
${User_Email}               ${EMPTY}

${Continue_Button}          css:[data-qa="continue-button"]
${Logout_Link}              css:a[href="/logout"]

${Signup_Name}               css:[data-qa="signup-name"]
${Signup_Email}              css:[data-qa="signup-email"]
${Login_Email}               css:[data-qa="login-email"]
${Login_Password}            css:[data-qa="login-password"]
${Signup_Button}             css:[data-qa="signup-button"]
${Login_Button}              css:[data-qa="login-button"]
${Title_Mr}                  id:id_gender1
${Password}                  id:password
${Date_day}                  id:days
${Date_months}               id:months
${Date_years}                id:years
${First_name}                id:first_name
${Last_name}                 id:last_name
${Company}                   id:company
${Address1}                  id:address1
${Country}                   id:country
${State}                     id:state
${City}                      id:city
${Zipcode}                   id:zipcode
${Phone_mobile}              id:mobile_number
${Create_Account_Button}     css:[data-qa="create-account"]

${Category_Woman}            css:a[href="#Women"]
${Category_Dress}            css:a[href="/category_products/1"]
${Add_To_Cart_Button}        css:.product-image-wrapper a.add-to-cart
${Modal_Title}                css:.modal-title
${Continue_Shopping_Button}  css:.close-modal
${View_Cart_Link}             xpath=//a[@href='/view_cart']
${Proceed_To_Checkout_Button}  css:.check_out
${Cart_Rows}                   css:#cart_info_table tbody tr
${Name_On_Card}                css:[data-qa="name-on-card"]
${Card_Number}                 css:[data-qa="card-number"]
${CVC}                         css:[data-qa="cvc"]
${Expiry_Month}                css:[data-qa="expiry-month"]
${Expiry_Year}                 css:[data-qa="expiry-year"]


*** Keywords ***

Give access to the site "${Site}"
    Open Browser    url=${Site}    browser=${BROWSER}    options=add_argument("--host-resolver-rules=MAP *.doubleclick.net 0.0.0.0,MAP *.googlesyndication.com 0.0.0.0,MAP *.google-analytics.com 0.0.0.0,MAP *.googletagservices.com 0.0.0.0,MAP adservice.google.com 0.0.0.0")
    Set Window Size    1920    1080

And I enter the name "${Name}"
    Input Text    ${Signup_Name}    ${Name}

And I enter the email "${Email}"
    Input Text    ${Signup_Email}    ${Email}

And I enter the password "${Password}"
    Input Password    ${Login_Password}    ${Password}

And I enter on login email "${Email}"
    Input Text    ${Login_Email}    ${Email}

And I click on login
    Scroll Element Into View    ${Login_Button}
    Execute Javascript    document.querySelector('[data-qa="login-button"]').click();     

And I click on Signup
    Scroll Element Into View    ${Signup_Button}
    Execute Javascript    document.querySelector('[data-qa="signup-button"]').click();

Then I confirm that the signup form is still displayed
    Page Should Contain Element    ${Signup_Name}

And I fill in all the fields
    Wait Until Element Is Visible    ${Title_Mr}    timeout=15s
    Click Element                 ${Title_Mr}
    Input Password                ${Password}      ${User_Password}
    Select From List By Value     ${Date_day}      11
    Select From List By Value     ${Date_months}   7
    Select From List By Value     ${Date_years}    1990
    Input Text                    ${First_name}    Paulo
    Input Text                    ${Last_name}     Cabral
    Input Text                    ${Company}       Paulo LTDA
    Input Text                    ${Address1}      Rua teste da silva
    Select From List By Value     ${Country}       Canada
    Input Text                    ${State}         Ontario
    Input Text                    ${City}          Curitiba
    Input Text                    ${Zipcode}       00000
    Input Text                    ${Phone_mobile}  +5541996816096

When I click on Register
    Scroll Element Into View    ${Create_Account_Button}
    Execute Javascript    document.querySelector('[data-qa="create-account"]').click();

Then I should be redirected to the "MY ACCOUNT" page
    Wait Until Page Contains    Account Created!    timeout=15s

Then I confirm that the account was created
    Wait Until Page Contains    Account Created!    timeout=15s

And I continue to the home page
    Wait Until Element Is Visible    ${Continue_Button}    timeout=15s
    Click Element                    ${Continue_Button}

Then I confirm that I am logged in
    Wait Until Page Contains    Logged in as    timeout=15s

Then I confirm that the login was rejected
    Wait Until Page Contains    Your email or password is incorrect!    timeout=15s

And I log out
    Wait Until Element Is Visible    ${Logout_Link}    timeout=10s
    Click Element                    ${Logout_Link}
    Wait Until Element Is Visible    ${Login_Email}    timeout=10s

Then I confirm that the account was deleted
    Wait Until Page Contains  Account Deleted!    timeout=15s

Then I should be redirected to the "account information" page
    Wait Until Element Is Visible    ${Password}    timeout=15s

And I delete the account
    Go To                     ${Base_URL}/delete_account

Then I close the browser
    Close All Browsers

I click on "${Element}"
    Run Keyword If    '${Element}' == 'Woman'                  Click Element    ${Category_Woman}
    ...    ELSE IF    '${Element}' == 'Dress'                   Click Category Dress
    ...    ELSE IF    '${Element}' == 'Add to cart'              Click Element    ${Add_To_Cart_Button}
    ...    ELSE IF    '${Element}' == 'Continue Shopping'        Click Element    ${Continue_Shopping_Button}
    ...    ELSE IF    '${Element}' == 'View Cart'                Click Element    ${View_Cart_Link}
    ...    ELSE IF    '${Element}' == 'Proceed To Checkout'      Click Element    ${Proceed_To_Checkout_Button}
    ...    ELSE IF    '${Element}' == 'Place Order'              Click Element    ${Proceed_To_Checkout_Button}
    ...    ELSE IF    '${Element}' == 'Pay and Confirm Order'    Execute Javascript    document.querySelector('[data-qa="pay-button"]').click();
    ...    ELSE                                                  Fail    Elemento "${Element}" nao mapeado no keyword "And I click on"

Click Category Dress
    Wait Until Element Is Visible    ${Category_Dress}    timeout=5s
    Click Element                    ${Category_Dress}

Then I confirm that the product was added to the cart
    Wait Until Element Is Visible    ${Modal_Title}    timeout=10s
    Element Text Should Be           ${Modal_Title}     Added!

And I fill in the payment details
    Input Text    ${Name_On_Card}    Paulo Cabral
    Input Text    ${Card_Number}     4111111111111111
    Input Text    ${CVC}             123
    Input Text    ${Expiry_Month}    12
    Input Text    ${Expiry_Year}     2030

Then I confirm that the order was placed successfully
    Wait Until Page Contains    Order Placed!    timeout=20s

And I add the product "${Product_Id}" to the cart
    Wait Until Element Is Visible    css:.productinfo a.add-to-cart[data-product-id="${Product_Id}"]    timeout=10s
    Execute Javascript    document.querySelector('.productinfo a.add-to-cart[data-product-id="${Product_Id}"]').click();
    Then I confirm that the product was added to the cart
    And I click on "Continue Shopping"
    Wait Until Element Is Not Visible    ${Modal_Title}    timeout=10s

I confirm that the cart has ${Quantity} different products
    Wait Until Element Is Visible    ${Cart_Rows}    timeout=10s
    ${Count}    Get Element Count    ${Cart_Rows}
    Should Be Equal As Integers    ${Count}    ${Quantity}

I confirm that the cart contains the product "${Product_Id}" with quantity "${Quantity}"
    Page Should Contain Element    css:#product-${Product_Id}
    Element Text Should Be    css:#product-${Product_Id} .cart_quantity button    ${Quantity}

I confirm that the line total of the product "${Product_Id}" is price times quantity
    ${Price_Text}       Get Text    css:#product-${Product_Id} .cart_price p
    ${Quantity_Text}    Get Text    css:#product-${Product_Id} .cart_quantity button
    ${Total_Text}       Get Text    css:#product-${Product_Id} .cart_total_price
    ${Price}       Evaluate    int(re.sub(r'[^0-9]', '', $Price_Text))   modules=re
    ${Quantity}    Evaluate    int($Quantity_Text)
    ${Total}       Evaluate    int(re.sub(r'[^0-9]', '', $Total_Text))   modules=re
    ${Expected}    Evaluate    $Price * $Quantity
    Should Be Equal As Integers    ${Total}    ${Expected}

I confirm that the cart does not contain the product "${Product_Id}"
    Page Should Not Contain Element    css:#product-${Product_Id}

And I remove the product "${Product_Id}" from the cart
    Click Element    css:a.cart_quantity_delete[data-product-id="${Product_Id}"]
    Wait Until Page Does Not Contain Element    css:#product-${Product_Id}    timeout=10s

I confirm that the signup was rejected because the email already exists
    Wait Until Page Contains    Email Address already exist!    timeout=15s

# --- Setup / Teardown: cada teste cria e remove o proprio usuario ---

I have a unique test user
    ${Timestamp}    Get Current Date    result_format=%Y%m%d%H%M%S%f
    Set Test Variable    ${User_Email}    qa.${Timestamp}@example.com

I have a registered user who is logged in
    I have a unique test user
    Give access to the site "${Login_URL}"
    And I enter the name "${User_Name}"
    And I enter the email "${User_Email}"
    And I click on Signup
    And I fill in all the fields
    When I click on Register
    Then I confirm that the account was created
    And I continue to the home page
    Then I confirm that I am logged in

Clean up the test user
    # Se o usuario ainda estiver logado, apaga a conta; depois fecha tudo.
    Run Keyword And Ignore Error    Go To    ${Base_URL}/delete_account
    Close All Browsers
