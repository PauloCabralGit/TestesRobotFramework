*** Settings ***
Documentation      criacao de cadastro
Resource    Resourse.robot


*** Test Cases ***

CN001: Realizar cadastro com sucesso
     Dado que acesso o site "http://automationpractice.com/index.php?controller=authentication&back=my-account"
     E insiro um email valido no campo "paulocabral_90@hotmail.com"
     E clico em Create an account
     E preencho todos os campos                 
     Quando clico em "Register"
     Então devo ser redirecionado para pagina "MY ACCOUNT"
CN002: Verificar campos obrigatorios
     Dado que acesso o site "http://automationpractice.com/index.php?controller=authentication&back=my-account"  
     E insiro um email valido no campo "paulocabral_90@hotmail.com"
     E clico em Create an account
     E verifico se o campo "First name " e obrigatorio e apos preencho o campo "Paulo"
     E verifico se o campo "Last name " e obrigatorio e apos preencho o campo "Cabral"
     E verifico se o campo "Email " e obrigatorio e apos preencho o campo "paulocabral_90@hotmail.com"
     E verifico se o campo "Password " e obrigatorio e apos preencho o campo "12345"
     Então fecho o browser
     
     

   




