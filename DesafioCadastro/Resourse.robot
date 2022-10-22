*** Settings ***

Library    SeleniumLibrary
Library    Process
Library    Screenshot

*** Variables ***

${BROWSER}    chrome

*** Keywords ***

Dado que acesso o site "${Site}"
    Open Browser  url=${Site}   browser=${BROWSER} 

E insiro um email valido no campo "${Email}"
    Input Text    //input[@id='email_create']  ${Email}

E clico em Create an account
    Click Button    //button[@id='SubmitCreate'] 
    Wait Until Element Is Visible    //div[@class='form-group form-ok'] 
    
E preencho todos os campos obrigatorios
    Sleep    5  
    Click Element     //input[@id='id_gender1'] 
    Input Text    //*[text()='First name ']//..//input[@class='is_required validate form-control']    Paulo
    Input Text    //*[text()='Last name ']//..//input[@class='is_required validate form-control']     Cabral
    Clear Element Text    //*[text()='Email ']//..//input[@class='is_required validate form-control']
    Input Text     //*[text()='Email ']//..//input[@class='is_required validate form-control']        paulocabral_90@hotmail.com 
    Input Password    //*[text()='Password ']//..//input[@class='is_required validate form-control']   12345 
    Click Element    //select[@id='days']//option[@value='11']
    Click Element    //select[@id='months']//option[@value='7']
    Click Element    //select[@id='years']//option[@value='1990']
    Input Text    //input[@id='company']    Fake LTDA
    Input Text    //input[@id='address1']    Rua Etelvina Pimentel Rodrigues
    Input Text    //input[@id='city']    Curitiba
    Click Element    //select[@id='id_state']//option[@value='7']
    Input Text    //input[@id='postcode']    00000
    Input Text    //input[@id='phone_mobile']    +554199681-6096   
    
Quando clico em "Register"
    Click Button    //button[@id='submitAccount']

Então devo ser redirecionado para pagina "MY ACCOUNT"
  Wait Until Element Is Visible    //span[@class='navigation_page'] 
  Close All Browsers

E verifico se o campo "${Campo}" e obrigatorio
    Sleep    5      
    Clear Element Text    //*[text()='${Campo}']//..//input[@class='is_required validate form-control']
    Click Element         //*[text()='${Campo}']//..//input[@class='is_required validate form-control']
    Click Element         //*[text()='Your address']    
    Wait Until Element Is Visible    //div[@class='required form-group form-error'] 
    Capture Page Screenshot   
      
Então fecho o browser
    Close All Browsers
 