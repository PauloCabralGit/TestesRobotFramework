---
name: qa-revisao-estatica
description: Faz teste estático (ISTQB cap. 3): revisa requisitos, histórias de usuário, critérios de aceite, planos de teste e código de automação para achar ambiguidade, lacunas e riscos antes de testar. Use ao pedir "revisar requisito", "análise de testabilidade" ou "code review de testes".
---

# Teste estático e revisões (ISTQB CTFL 4.0 §3)

Encontrar defeito cedo custa menos. Revise antes de automatizar.

## Tipos de revisão
Informal · Walkthrough · Revisão técnica · Inspeção (a mais formal, com papéis e métricas).

## Revisão de requisito/história (testabilidade)
Para cada item, verifique:
- **Claro e não ambíguo?** Termos vagos: "rápido", "amigável", "etc.", "adequado", "quando necessário".
- **Completo?** Fluxos alternativos, erros, limites, perfis de usuário, mensagens.
- **Consistente?** Contradição com outro requisito.
- **Testável?** Dá para decidir passa/falha? Existe critério de aceite mensurável (INVEST para histórias)?
- **Rastreável?** Tem identificador.
- **Fatores não funcionais?** Desempenho, segurança, acessibilidade.

Saída: tabela `item | problema | tipo (ambiguidade/lacuna/contradição) | pergunta ao dono | sugestão`.

## Revisão do código de automação (Robot Framework)
- Locators estáveis (`data-qa`, `id`), centralizados em variáveis; sem XPath posicional frágil.
- Esperas explícitas (`Wait Until ...`) em vez de `Sleep`.
- Keywords reutilizáveis, nomes que expressam intenção, sem duplicação.
- Sem credenciais ou dados reais no repositório; configuração por variáveis.
- Asserções existem e verificam algo relevante; nenhum teste "passa vazio".
- Teardown fecha o navegador e limpa dados; testes independentes.
- `Documentation` e tags (`smoke`, `regressao`, `api`) presentes.

## Análise estática
Use ferramentas quando existirem: `robocop` (lint de Robot) e `python -m robot --dryrun`. Reporte, não mascare, os avisos.

## Regras
Critique o artefato, não a pessoa. Priorize os achados por impacto e proponha o conserto, não só o problema.
