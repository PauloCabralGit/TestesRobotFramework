*** Settings ***

Library     RequestsLibrary
Resource    resourse_API.robot

*** Test Cases ***
CT001 - Realizar GET e validar a lista de livros
    [Tags]    api    smoke
    Dado que eu verifico se a api esta ONLINE
    E realizo um GET
    Entao confiro status code    200
    E confiro que a resposta e uma lista nao vazia
CT002 - Criar uma chamada POST e validar o retorno
    [Tags]    api    regressao
    Dado que eu verifico se a api esta ONLINE
    E realizo um POST
    Entao confiro status code    200
    E confiro que o campo "id" da resposta vale "201"
    E confiro que o campo "title" da resposta vale "Paulo"
CT003 - Criar uma chamada GET de um livro existente e validar o retorno
    [Tags]    api    regressao
    Dado que eu verifico se a api esta ONLINE
    E consulto o livro existente de id 200
    Entao confiro status code    200
    E confiro que o campo "id" da resposta vale "200"
CT004 - Criar uma chamada PUT que atualize um livro e validar o retorno
    [Tags]    api    regressao
    Dado que eu verifico se a api esta ONLINE
    E realizo um UPDATE
    Entao confiro status code    200
    E confiro que o campo "id" da resposta vale "201"
    E confiro que o campo "title" da resposta vale "Paulo"
CT005 - Criar uma chamada DELETE de um livro e validar o retorno
    [Tags]    api    regressao
    Dado que eu verifico se a api esta ONLINE
    E realizo um DELETE
    Entao confiro status code    200
