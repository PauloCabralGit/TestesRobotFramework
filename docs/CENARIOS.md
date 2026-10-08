# Cenários de Teste e Rastreabilidade

> Gerado em 2026-10-08 a partir da leitura de `TesteCadastro/beginning.robot`, `TesteCadastro/Resourse.robot`, `TesteAPI/API.robot` e `TesteAPI/resourse_API.robot`.
> **Último resultado:** execução local em 2026-10-08, após as correções desta versão: Web 11/11 (6/6 também em ordem aleatória, antes do CN016) e API 5/5. Os requisitos `RQ-xx` são **inferidos** e precisam de validação.

## 1. Requisitos inferidos

| ID | Requisito (comportamento esperado) |
|---|---|
| RQ-01 | Um visitante consegue criar uma conta informando nome, e-mail e dados de cadastro; a conta é criada com a mensagem "Account Created!" |
| RQ-02 | Um usuário cadastrado consegue autenticar com e-mail e senha corretos; credenciais inválidas são rejeitadas |
| RQ-03 | Um usuário autenticado consegue adicionar um produto ao carrinho, finalizar a compra com pagamento e ver "Order Placed!" |
| RQ-04 | Um usuário autenticado consegue excluir a própria conta ("Account Deleted!") |
| RQ-05 | A API `GET /Books` lista os livros (200) |
| RQ-06 | A API `POST /Books` cria um livro e retorna os dados enviados (200) |
| RQ-07 | A API `GET /Books/{id}` retorna o livro pedido (200) |
| RQ-08 | A API `PUT /Books/{id}` atualiza o livro (200) |
| RQ-09 | A API `DELETE /Books/{id}` remove o livro (200) |
| RQ-10 | O formulário de cadastro não avança quando os campos obrigatórios estão vazios |

## 2. Matriz de rastreabilidade (cenários existentes)

| Requisito | Caso | Técnica | Suíte | Automação | Prioridade | Último resultado |
|---|---|---|---|---|---|---|
| RQ-01 | CN001 | Caso de uso | Web | Automatizado | Alta | PASS |
| RQ-10 | CN002 | PE | Web | Automatizado (cobre só o campo nome vazio) | Média | PASS |
| RQ-03 | CN003 | Caso de uso | Web | Automatizado | Alta | PASS |
| RQ-04 | CN004 | Caso de uso | Web | Automatizado | Média | PASS |
| RQ-02 | CN006 | Tabela de decisão (e-mail não cadastrado) | Web | Automatizado | Alta | PASS |
| RQ-01 | CN007 | Error guessing (e-mail duplicado) | Web | Automatizado | Alta | PASS |
| RQ-03 | CN014 | Caso de uso (remover item) | Web | Automatizado | Alta | PASS |
| RQ-03 | CN016 | Caso de uso / invariante (total = preço × qtd) | Web | Automatizado | Alta | PASS |
| RQ-02 | CN005 | Tabela de decisão (senha inválida) | Web | Automatizado | Alta | PASS |
| RQ-03 | CN017 | PE (quantidade 2) | Web | Automatizado | Alta | PASS |
| RQ-02 | CN008 | Caso de uso | Web | Automatizado | Alta | PASS |
| RQ-05 | CT001 | Caso de uso | API | Automatizado | Média | PASS |
| RQ-06 | CT002 | Caso de uso | API | Automatizado | Média | PASS |
| RQ-07 | CT003 | Caso de uso | API | Automatizado | Média | PASS |
| RQ-08 | CT004 | Caso de uso | API | Automatizado | Média | PASS |
| RQ-09 | CT005 | Caso de uso | API | Automatizado (só status code; DELETE não devolve corpo) | Média | PASS |

## 3. Detalhamento dos casos

Todos os casos web são **independentes**: o *Test Setup* gera um e-mail único (`qa.<timestamp>@example.com`) e o *Test Teardown* apaga a conta e fecha o navegador.

- **CN001 — Cadastro com sucesso.** Preenche o cadastro e confere "Account Created!".
- **CN002 — Campos obrigatórios.** Clica em Signup sem preencher e confere que o formulário continua exibido.
- **CN003 — Compra de produto.** Usuário já logado; adiciona ao carrinho, paga e confere "Order Placed!".
- **CN004 — Excluir conta.** Usuário logado; apaga a conta e confere "Account Deleted!".
- **CN005 — Login com senha errada.** Confere "Your email or password is incorrect!".
- **CN016 — Vários produtos no carrinho.** Sem login; adiciona os produtos 3 e 38 da categoria Dress, confere 2 linhas no carrinho, quantidade 1 em cada e total da linha = preço × quantidade (não fixa preços do catálogo).
- **CN006 — Login com e-mail não cadastrado.** Confere "Your email or password is incorrect!".
- **CN007 — Cadastro com e-mail já existente.** Cria usuário, faz logout, tenta se cadastrar de novo com o mesmo e-mail e confere "Email Address already exist!".
- **CN017 — Mesmo produto duas vezes.** Uma única linha com quantidade 2 e total = preço × quantidade.
- **CN014 — Remover produto do carrinho.** Remove o produto 3; permanece só o 38 com quantidade 1.
- **CN008 — Login com sucesso.** Faz logout, loga de novo e confere "Logged in as".
- **CT001** GET `/Books` → 200 e lista não vazia.
- **CT002** POST `/Books` → 200 e corpo com `id` 201 e `title` "Paulo".
- **CT003** GET `/Books/200` (livro **existente**) → 200 e `id` 200.
- **CT004** PUT `/Books/201` → 200 e corpo com `id` 201 e `title` "Paulo".
- **CT005** DELETE `/Books/201` → 200.
- **Limitação conhecida da API de demonstração:** POST/PUT/DELETE não persistem (GET `/Books/201` retorna 404). Por isso o CT003 consulta um livro existente e os testes validam o *eco* da resposta, não o estado.

## 4. Cenários propostos (lacunas de cobertura)

Prioridade pela exposição de risco do plano. Técnica indicada entre parênteses.

### Web — alta prioridade
> Já implementados: CN005, CN006, CN007, CN008, CN014, CN016 e CN017.
| ID | Cenário | Técnica | Requisito |
|---|---|---|---|
| CN009 | Logout encerra a sessão | Transição de estado | RQ-02 |
| CN010 | Finalizar compra com carrinho vazio não é possível | Error guessing | RQ-03 |

### Web — média prioridade
| ID | Cenário | Técnica | Requisito |
|---|---|---|---|
| CN011 | Cadastro com campos obrigatórios vazios (cada campo) mostra validação | PE | RQ-10 |
| CN012 | Cadastro com e-mail em formato inválido não avança | PE / AVL | RQ-10 |
| CN013 | Pagamento com cartão inválido/ campos vazios é rejeitado | PE | RQ-03 |
| CN018 | Carrinho de visitante é mantido ao fazer login (comportamento a confirmar com o dono do produto) | Transição de estado | RQ-03 |
| CN019 | Busca de produto por nome retorna resultados e termo inexistente retorna vazio | PE | novo |
| CN020 | Página de detalhe do produto mostra nome, preço, categoria e permite definir quantidade e adicionar | Caso de uso | novo |
| CN015 | Excluir conta e tentar logar de novo falha | Transição de estado | RQ-04 |

### API — média prioridade
| ID | Cenário | Técnica | Requisito |
|---|---|---|---|
| CT006 | GET `/Books` retorna lista com campos `id`, `title`, `pageCount` com os tipos corretos (validação de contrato) | Contrato | RQ-05 |
| CT007 | GET `/Books/{id}` inexistente retorna 404 | PE | RQ-07 |
| CT008 | POST com corpo vazio ou inválido retorna 400/erro tratado | PE | RQ-06 |
| CT009 | POST com `id` no limite (0, 1, máximo) é tratado | AVL | RQ-06 |
| CT010 | O corpo da resposta do POST espelha o enviado | Caso de uso | RQ-06 |
| CT011 | PUT em id inexistente retorna erro tratado | PE | RQ-08 |
| CT012 | Tempo de resposta do GET `/Books` dentro do limite acordado (limite **a definir**) | Não funcional | RQ-05 |

## 5. Melhorias de manutenção

Feitas em 2026-10-08: testes web independentes com e-mail único; asserções adicionadas (CN001, CN002, CN004, CT001–CT004); dados de teste em variáveis; tags (`smoke`, `regressao`, `critico`, `api`, `web`); versões fixadas em `requirements.txt`.

Pendentes:
1. Migrar `Get Request`/`Post Request`/`Delete Request` (deprecated) para `GET On Session`/`POST On Session`/`DELETE On Session`.
2. Mover os dados de teste para um arquivo de variáveis (`--variablefile`) ou variáveis de ambiente.
3. CN002 cobre só o campo nome; ampliar com CN011 (cada campo obrigatório).
4. Padronizar idioma entre as suítes (web em inglês, API em português).
5. CN003 tem ~11 passos; extrair keywords de negócio (ex.: "adicionar produto ao carrinho").

## 6. Convenções

- IDs: `CN###` (web) e `CT###` (API), sequenciais; `RQ-##` para requisitos.
- Este arquivo é atualizado a cada criação, alteração ou remoção de teste.
