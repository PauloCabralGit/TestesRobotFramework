# Plano de Testes — TestesRobotFramework

> Versão 1.0 · 2026-10-08 · Atividade do processo: **Planejamento/Análise** (baseado na leitura do código; nenhuma suíte foi executada para gerar este documento).
> Os requisitos não estão documentados no repositório. Os `RQ-xx` abaixo foram **inferidos** dos testes e dos sites alvo e precisam de validação do responsável pelo produto.

## 1. Identificação e escopo

| Item | Descrição |
|---|---|
| Sistemas sob teste | (1) Site de e-commerce de demonstração https://automationexercise.com. (2) API de demonstração https://fakerestapi.azurewebsites.net/api/v1/ (recurso `Books`) |
| Natureza | Sistemas públicos de terceiros, sem controle sobre versão, dados ou disponibilidade |
| Suítes | `TesteCadastro/beginning.robot` (web, SeleniumLibrary), `TesteAPI/API.robot` (API, RequestsLibrary) |
| CI | `.github/workflows/robot-tests.yml` (jobs `api-tests` e `cadastro-tests`) |

**Dentro do escopo:** cadastro de usuário, login, compra de produto (carrinho até confirmação do pedido), exclusão de conta, CRUD básico de `Books` na API.

**Fora do escopo (nesta versão):** desempenho/carga, segurança (além de verificações básicas), acessibilidade, compatibilidade com outros navegadores/mobile, demais recursos da API (`Authors`, `Activities`, etc.), demais telas do site (contato, busca, assinatura, avaliação de produto, API de produtos do site). Cada item pode entrar em versões futuras (ver `CENARIOS.md`, seção "Cenários propostos").

## 2. Objetivos de teste

1. Garantir que os fluxos críticos de negócio do site (cadastrar, autenticar, comprar, excluir conta) funcionam ponta a ponta.
2. Garantir que as operações CRUD da API de `Books` respondem conforme o contrato esperado.
3. Detectar regressões automaticamente a cada push/PR para `master`.
4. Manter a automação estável e de baixo custo de manutenção (taxa de falso positivo baixa).

## 3. Itens de teste e funcionalidades (priorizados)

| Prioridade | Funcionalidade | Suíte |
|---|---|---|
| Alta | Cadastro de usuário (RQ-01) | Web |
| Alta | Login (RQ-02) | Web |
| Alta | Compra: adicionar ao carrinho, checkout, pagamento, confirmação (RQ-03) | Web |
| Média | Exclusão de conta (RQ-04) | Web |
| Média | API Books: GET lista, POST, GET por id, PUT, DELETE (RQ-05 a RQ-09) | API |
| Média | Validação de campos obrigatórios (RQ-10) | Web |

## 4. Abordagem e estratégia

**Níveis:** sistema (web, ponta a ponta) e integração/contrato (API). Não há acesso ao código dos sistemas, então não há teste de componente nem caixa-branca.

**Tipos:** funcional (principal), regressão (automática no CI), confirmação (reteste de bugs corrigidos). Não funcionais ficam fora do escopo atual, exceto verificações simples (tempo de resposta da API, como ideia futura).

**Técnicas** (skill `qa-tecnicas-de-teste`):
- Partição de equivalência e valor limite para campos do cadastro e payloads da API.
- Tabela de decisão para login (e-mail válido/inválido × senha válida/inválida).
- Transição de estado para o ciclo de vida da conta (inexistente → criada → logada → excluída).
- Error guessing: vazio, espaços, caracteres especiais, e-mail duplicado.

**Pirâmide de automação:** preferir API quando a regra puder ser verificada ali; UI só para jornadas críticas. Hoje a proporção é de 6 casos web e 5 de API, sem camada de componente.

## 5. Análise de risco

Escala: probabilidade (P) e impacto (I) de 1 a 3; exposição = P×I.

| ID | Risco | P | I | Exp. | Mitigação / teste |
|---|---|---|---|---|---|
| R1 | *(Mitigado em 2026-10-08)* Testes web **dependiam uns dos outros** (CN001 cria a conta; CN003 e CN004 usam essa conta e CN004 a apaga). Falha/ordem diferente derruba os demais | 3 | 3 | **9** | Feito: setup cria usuário com e-mail único e teardown apaga. Validado em ordem aleatória |
| R2 | Site externo fora do ar, lento, com anúncios/CAPTCHA ou mudança de locators | 3 | 3 | **9** | Esperas explícitas, bloqueio de domínios de anúncio (já feito), classificar falha como ambiente, reexecutar até 2× |
| R3 | *(Reduzido)* Conta compartilhada no CI | 1 | 3 | 3 | E-mail único por teste; `concurrency` no workflow mantido por precaução |
| R4 | **Falsos positivos**: testes sem asserção suficiente "passam vazio" (ex.: CN001 e CN004 não verificam o resultado; CN002 não verifica rejeição do login; testes de API aceitam 200 mesmo quando o recurso é simulado) | 3 | 2 | 6 | Adicionar asserções reais (ver `CENARIOS.md`, itens marcados "revisar") |
| R5 | API de demonstração **não persiste dados**: POST/PUT/DELETE retornam sucesso sem alterar estado, então o GET posterior não prova nada | 3 | 2 | 6 | Validar o corpo da resposta e o contrato; aceitar a limitação e documentar |
| R6 | Dados sensíveis/pessoais fixos no código (e-mail, telefone, senha, cartão de teste) | 2 | 2 | 4 | Mover para variáveis/variáveis de ambiente; usar só dados fictícios |
| R7 | Falta de cobertura de cenários negativos (login inválido, e-mail duplicado, carrinho vazio) | 3 | 2 | 6 | Implementar cenários propostos |
| R8 | *(Mitigado)* Dependências sem versão fixa | 1 | 2 | 2 | Versões fixadas em `requirements.txt` (selenium 4.49.0, seleniumlibrary 6.9.0) |

## 6. Critérios de entrada

- Site e API acessíveis (verificação inicial: resposta HTTP 200 nas URLs base).
- Dependências instaladas (`pip install -r requirements.txt`) e navegador Chrome disponível (local) ou Xvfb (CI).
- `python -m robot --dryrun` sem erros de sintaxe.
- Massa de dados definida (ver seção 9).

## 7. Critérios de saída

- 100% dos casos de prioridade Alta executados.
- ≥ 95% de aprovação nos casos executados, sem falha de classe "defeito real" aberta de severidade Crítica/Alta.
- Toda falha classificada (teste quebrado / defeito / ambiente) e, quando defeito, com issue aberta.
- Relatório de conclusão gerado (skill `qa-metricas-e-relatorio`).

## 8. Critérios de suspensão e retomada

- **Suspender:** site/API indisponível ou retornando erro 5xx de forma generalizada; defeito bloqueante no login/cadastro que impede os demais testes.
- **Retomar:** serviço restabelecido e verificação inicial (seção 6) aprovada.

## 9. Ambiente e dados

| Item | Detalhe |
|---|---|
| Ferramentas | Python 3.12, Robot Framework 7.2.2, robotframework-requests 0.9.7, robotframework-seleniumlibrary ≥ 6.9.0, selenium ≥ 4.49.0, Chrome |
| Execução local | `python -m robot --outputdir results/<suite> <arquivo.robot>` |
| CI | GitHub Actions, `ubuntu-latest`, Xvfb para o navegador; artefatos de resultado publicados |
| Dados | E-mail único gerado por teste (`qa.<timestamp>@example.com`); senha e demais dados fictícios em variáveis (R6 parcialmente tratado); cartão de teste 4111 1111 1111 1111; API `Books` com id 201 |
| Restrições | `concurrency` mantido no CI; API de terceiros não persiste dados (R5) |

## 10. Papéis e responsabilidades

| Papel | Responsável |
|---|---|
| Responsável pela automação e plano | Paulo Cabral (dono do repositório) |
| Apoio de automação/manutenção | Agente `automatizador-qa` (sempre com revisão humana antes de merge) |
| Aprovação de requisitos e prioridades | A definir |

## 11. Cronograma e estimativa

A definir. Não há dados históricos de esforço no repositório para estimar. Sugestão: estimar por analogia após a primeira rodada completa do backlog.

## 12. Métricas e relatórios

Taxa de aprovação, tempo de execução, flakiness, % de requisitos com caso, % automatizado, defeitos por severidade. Modelo e fonte de dados na skill `qa-metricas-e-relatorio`. Relatórios em `results/` e artefatos do CI.

## 13. Gestão de defeitos

Issues no GitHub com labels `bug` e `automation`, título `[BUG] <módulo> - <sintoma>`, severidade e prioridade separadas (skill `qa-relatorio-de-defeitos`). Antes de abrir, procurar duplicado.

## 14. Premissas e riscos do projeto

- O site e a API são de demonstração, mantidos por terceiros, e podem mudar a qualquer momento sem aviso.
- O comportamento esperado dos requisitos inferidos precisa ser confirmado.
- O custo de manutenção da UI tende a superar o da API; priorizar estabilidade dos locators.

## 15. Ações recomendadas (prioridade)

1. Tornar os testes web independentes e usar e-mail único por execução (R1, R3).
2. Reforçar asserções dos casos marcados "revisar" (R4, R5).
3. Implementar os cenários negativos de maior valor (R7).
4. Remover dados fixos do código (R6) e fixar versões (R8).
