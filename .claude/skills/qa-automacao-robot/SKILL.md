---
name: qa-automacao-robot
description: Boas práticas de arquitetura e manutenção de automação com Robot Framework, Selenium e Requests, baseadas no ISTQB CTAL-TAE (Test Automation Engineer). Use ao criar, refatorar ou estabilizar testes automatizados, tratar testes flaky, estruturar keywords ou configurar execução no CI.
---

# Engenharia de automação (ISTQB CTAL-TAE; ISTQB CTFL §6)

## Quando automatizar
Automatize o que é repetitivo, estável, crítico e de alto valor (regressão, smoke, dados em volume). Não automatize o que muda toda semana, é exploratório ou custa mais para manter do que rodar à mão.

## Arquitetura em camadas (TAS - Test Automation Solution)
1. **Testes** (`*.robot`): legíveis, de negócio, sem detalhe técnico.
2. **Keywords de negócio/fluxo** (`Resourse.robot`): combinam passos ("Fazer login").
3. **Keywords de baixo nível/locators**: página/elemento isolados (padrão Page Object adaptado a Robot). Mudou a tela → altera um lugar só.
4. **Bibliotecas e utilitários**: dados, esperas, evidências.
Dados de teste e configuração separados do código (variáveis, `--variablefile`, variáveis de ambiente).

## Princípios
- **Independência e idempotência**: cada teste cria e limpa seus dados; e-mails únicos (`${TIMESTAMP}`).
- **Esperas explícitas**, nunca `Sleep` fixo como estratégia.
- **Locators resilientes**: `data-qa` > `id` > CSS curto > XPath relativo. Evite índices e posição.
- **Pirâmide**: mais testes de API que de UI; UI apenas para jornadas críticas.
- **Falha útil**: screenshot automático na falha, mensagem de asserção clara.
- **Tags**: `smoke`, `regressao`, `api`, `critico` para selecionar o que rodar (`--include`).
- **Paralelismo só com dados isolados**. A conta compartilhada atual exige execução serial.

## Tratando testes flaky
1. Reproduza (rode 5-10 vezes). 2. Classifique: sincronização, dado compartilhado, ordem, ambiente. 3. Corrija a causa (espera/dado/isolamento). 4. Se não der, isole com tag `flaky` e abra issue. **Nunca** aumente retry para esconder.

## CI (GitHub Actions)
- Instale dependências fixas (`requirements.txt`), cache de pip, Xvfb ou headless para UI.
- Publique `output.xml`, `log.html`, `report.html` e screenshots como artefatos (`if: always()`).
- Falhou = job vermelho. Use `concurrency` quando houver recurso compartilhado.

## Métricas da automação
Taxa de passa, tempo de execução, taxa de flakiness, % de casos automatizados, esforço de manutenção, defeitos achados pela automação. Reporte tendência, não só o número do dia.

## Riscos a vigiar
Expectativa de "automatizar tudo", manutenção subestimada, dependência de site externo (ex.: automationexercise.com pode mudar ou ficar fora do ar), dados sensíveis no código.
