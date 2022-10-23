*** Settings ***

Library    SeleniumLibrary
Library    Process
Library    Screenshot

*** Variables ***

${BROWSER}    chrome
${title}         //input[@id='id_gender1'] 
${First_name}    //*[text()='First name ']//..//input[@class='is_required validate form-control']    
${Last_name}     //*[text()='Last name ']//..//input[@class='is_required validate form-control']     
${Limpa_email}   //*[text()='Email ']//..//input[@class='is_required validate form-control']
${Email}         //*[text()='Email ']//..//input[@class='is_required validate form-control']        
${Password}      //*[text()='Password ']//..//input[@class='is_required validate form-control']   
${Date_day}      //select[@id='days']//option[@value='11']
${Date_months}   //select[@id='months']//option[@value='7']
${Date_years}    //select[@id='years']//option[@value='1990']
${company}       //input[@id='company']    
${address1}      //input[@id='address1']    
${city}          //input[@id='city']    
${id_state}      //select[@id='id_state']//option[@value='7']
${postcode}      //input[@id='postcode']    
${phone_mobile}  //input[@id='phone_mobile']    

*** Keywords ***

Dado que acesso o site "${Site}"
    Open Browser  url=${Site}   browser=${BROWSER} 

E insiro um email valido no campo "${Email}"
    Input Text    //input[@id='email_create']  ${Email}

E clico em Create an account
    Click Button    //button[@id='SubmitCreate'] 
    Wait Until Element Is Visible    //div[@class='form-group form-ok'] 
    
E preencho todos os campos
    Sleep    5  
    Click Element    ${title} 
    Input Text       ${First_name}    Paulo 
    Input Text       ${Last_name}     Cabral
    Input Text       ${Email}         paulocabral_90@hotmail.com
    Input Password   ${Password}      12345
    Click Element    ${Date_day}
    Click Element    ${Date_months}
    Click Element    ${Date_years}
    Input Text       ${company}        Paulo LTDA
    Input Text       ${address1}       Rua teste da silva
    Input Text       ${city}           Curitiba
    Click Element    ${id_state} 
    Input Text       ${postcode}       00000   
    Input Text       ${phone_mobile}   +554199681-6096   
        
    
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
 