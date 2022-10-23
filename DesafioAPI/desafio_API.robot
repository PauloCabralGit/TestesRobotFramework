*** Settings ***

Library     RequestsLibrary
Resource    resourse_API.robot
Resource    ../DesafioCadastro/Resourse.robot

*** Test Cases ***
CT001 - Realizar GET
    Dado que eu verifico se a api esta ONLINE 
    E realizo um GET
CT002 - Criar uma chamada POST e validar o retorno    
    Dado que eu verifico se a api esta ONLINE
    E realizo um POST
    #E verifico todos os retornos do cadastro
    Entao confiro status code    200
CT003 - Criar uma chamada GET, que consulte o que foi criado no POST e validar o retorno   
    Dado que eu verifico se a api esta ONLINE
    E verifico se o post foi criado com sucesso
    Entao confiro status code    200
CT004 - Criar uma chamada UPDATE, que delete o que foi criado no POST e validar o retorno
    Dado que eu verifico se a api esta ONLINE
    E realizo um UPDATE  
    Entao confiro status code    200
CT005 - Criar uma chamada DELETE, que delete o que foi criado no POST e validar o retorno 
    Dado que eu verifico se a api esta ONLINE
    E realizo um DELETE
    Entao confiro status code    200

  







