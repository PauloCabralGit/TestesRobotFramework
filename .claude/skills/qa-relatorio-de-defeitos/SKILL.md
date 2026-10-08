---
name: qa-relatorio-de-defeitos
description: Redige, classifica e acompanha relatórios de defeito (bugs) no padrão ISTQB, com severidade, prioridade, passos de reprodução e ciclo de vida, e abre issues no GitHub com gh. Use ao encontrar falha de teste, ao pedir "abrir bug" ou "reportar defeito".
---

# Gestão de defeitos (ISTQB CTFL 4.0 §5.5; IEEE 1044)

## Antes de reportar
1. Reproduza (pelo menos 2 vezes) e descarte flaky, ambiente e dado.
2. Confirme que o comportamento esperado vem do requisito.
3. Procure duplicado: `gh issue list --state open --search "<termo>"`. Se existir, comente nele.

## Conteúdo do relatório
- **Título**: `[BUG] <módulo> - <sintoma>` (curto, específico).
- **Ambiente**: URL/versão, navegador, SO, data/hora, build/commit.
- **Passos para reproduzir**: numerados, determinísticos.
- **Resultado esperado** × **resultado obtido**.
- **Evidências**: trecho de log, screenshot, payload/resposta, nome do teste Robot, link do run do CI.
- **Severidade** e **Prioridade** (separadas), **frequência** (sempre/intermitente).
- **Impacto** no usuário/negócio e **workaround**, se houver.

## Severidade × prioridade
- **Severidade** (impacto técnico): Crítica (sistema/fluxo central inutilizável, perda de dados) · Alta · Média · Baixa (cosmético).
- **Prioridade** (urgência de correção): decidida com o negócio. Um erro de grafia no logotipo pode ter severidade baixa e prioridade alta.

## Ciclo de vida
Novo → Aberto/Atribuído → Corrigido → Em reteste → Fechado · (ou Reaberto / Rejeitado / Duplicado / Adiado). No reteste, rode o teste de **confirmação** e depois a **regressão** da área.

## Abrindo no GitHub
```
gh issue create --title "[BUG] ..." --label bug,automation --body-file bug.md
```
Se o label não existir, crie com `gh label create`. Não coloque senhas, tokens ou dados pessoais reais no corpo.

## Evite
Relato vago ("não funciona"), vários defeitos no mesmo relatório, tom acusatório, severidade inflada, bug sem passos reproduzíveis.
