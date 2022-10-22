*** Settings ***

Library           RequestsLibrary
Library           Collections
Library           SeleniumLibrary

*** Variables ***
${Site_API}    https://fakerestapi.azurewebsites.net/api/v1/
&{Cadastro}    id=201
...            title=Paulo 


*** Keywords ***  

Dado que eu verifico se a api esta ONLINE
    Create Session    API    ${Site_API}    verify=true
    ${Resposta}    Create Dictionary    content-type=application/json
    Set Suite Variable    ${Resposta}
    
Entao confiro status code   
  
  [Arguments]    ${STATUS_CODE}
  Should Be Equal As Strings    ${Resposta.status_code}    ${STATUS_CODE}         


E realizo um GET
      ${Resposta}    Get Request    API    Books
      Log             ${Resposta.text}
      Set Variable    ${Resposta}

  
E realizo um POST 
    ${Headers}    Create Dictionary    content-type=application/json
    ${Resposta}    Post Request   API    Books    
    ...    ${Cadastro}   
    ...    headers=${Headers}                         
    Log                    ${Resposta.text}
    Set Test Variable      ${Resposta}     

E verifico se o post foi criado com sucesso
    ${Resposta}    Get Request    API    Books/201
    Log                  ${Resposta.text}
    Set Test Variable    ${Resposta} 
    
E realizo um UPDATE 
    ${Headers}     Create Dictionary    content-type=application/json
    ${Resposta}    PUT On Session    API    Books/201   headers=${Headers}
    ...    data={ "id": "201", "title": "Paulo", "dueDate": "2022-10-21T03:56:48.6Z", "completed": true}   
    ...    headers=${Headers} 
    Log            ${Resposta.text}
    Set Test Variable    ${Resposta}

E realizo um DELETE    
   ${Headers}     Create Dictionary    content-type=application/json
   ${Resposta}    Delete Request    API    Books/201  
   ...    data={ "id": "201", "title": "Paulo", "dueDate": "2022-10-21T03:56:48.6Z", "completed": true}   
   ...    headers=${Headers} 
   Log            ${Resposta.text}
   Set Test Variable    ${Resposta}  
