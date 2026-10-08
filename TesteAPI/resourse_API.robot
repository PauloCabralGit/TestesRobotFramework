*** Settings ***

Library           RequestsLibrary
Library           Collections
Library           SeleniumLibrary
Library           String

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
      Log                  ${Resposta.text}
      Set Test Variable    ${Resposta}

E confiro que a resposta e uma lista nao vazia
    ${Lista}    Set Variable    ${Resposta.json()}
    ${Tipo}     Evaluate        type($Lista).__name__
    Should Be Equal As Strings    ${Tipo}    list
    Should Not Be Empty           ${Lista}

E confiro que o campo "${Campo}" da resposta vale "${Esperado}"
    ${Corpo}    Set Variable    ${Resposta.json()}
    Should Be Equal As Strings    ${Corpo}[${Campo}]    ${Esperado}

  
E realizo um POST 
    ${Headers}    Create Dictionary    content-type=application/json
    ${Resposta}    Post Request   API    Books    
    ...    ${Cadastro}   
    ...    headers=${Headers}                         
    Log                    ${Resposta.text}
    Set Test Variable      ${Resposta}     

E confiro que todos os livros respeitam o contrato
    ${Lista}    Set Variable    ${Resposta.json()}
    ${Valido}   Evaluate    all(isinstance(b.get('id'), int) and isinstance(b.get('title'), str) and isinstance(b.get('pageCount'), int) and 'description' in b and 'excerpt' in b and 'publishDate' in b for b in $Lista)
    Should Be True    ${Valido}    Algum livro nao respeita o contrato (id:int, title:str, pageCount:int, description, excerpt, publishDate)

E realizo um POST com o corpo "${Corpo}"
    ${Headers}     Create Dictionary    content-type=application/json
    ${Resposta}    Post Request    API    Books    data=${Corpo}    headers=${Headers}
    Log                  ${Resposta.text}
    Set Test Variable    ${Resposta}

E consulto o livro existente de id ${Id}
    ${Resposta}    Get Request    API    Books/${Id}
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
