*** Settings ***

Library     RequestsLibrary
Resource    resourse_API.robot
Resource    ../TesteCadastro/Resourse.robot

*** Test Cases ***
CT001 - Realizar GET
    Give access to the site "http://localhost:8080"
    And I perform a GET request
CT002 - Criar uma chamada POST e validar o retorno    
    Give access to the site "http://localhost:8080"
    And I perform a POST request
    #E verifico todos os retornos do cadastro
    Then I verify the response
CT003 - Criar uma chamada GET, que consulte o que foi criado no POST e validar o retorno   
    Give access to the site "http://localhost:8080"
    And I perform a GET request
    And I verify the response
    Then I confirm the status code is 200
CT004 - Criar uma chamada UPDATE, que delete o que foi criado no POST e validar o retorno
    Give access to the site "http://localhost:8080"
    And I perform an UPDATE request
    Then I verify the response
    And I confirm the status code is 200
CT005 - Criar uma chamada DELETE, que delete o que foi criado no POST e validar o retorno 
    Give access to the site "http://localhost:8080"
    And I perform a DELETE request
    Then I verify the response
    And I confirm the status code is 200

  







