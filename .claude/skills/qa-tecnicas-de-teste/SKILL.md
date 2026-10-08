---
name: qa-tecnicas-de-teste
description: Aplica as técnicas de projeto de teste do ISTQB (caixa-preta, caixa-branca e baseadas em experiência) para derivar casos de teste a partir de requisitos, telas ou APIs. Use ao criar cenários novos, avaliar cobertura ou quando pedirem "partição de equivalência", "valor limite", "tabela de decisão", "transição de estado" ou "casos de teste para X".
---

# Técnicas de teste (ISTQB CTFL 4.0, cap. 4)

Escolha a técnica pelo tipo de requisito, não por hábito. Sempre declare qual técnica gerou cada caso.

## Caixa-preta

| Técnica | Use quando | Como aplicar | Cobertura |
|---|---|---|---|
| **Partição de equivalência (PE)** | Entradas com faixas ou classes (idade, país, tipo de usuário) | Divida em classes válidas e inválidas. 1 caso por classe | % de classes cobertas |
| **Análise de valor limite (AVL)** | Faixas numéricas ou de tamanho (senha 8-20, quantidade 1-99) | Teste mínimo, máximo e os vizinhos fora: 2 valores (min, max) ou 3 valores por limite | % de limites cobertos |
| **Tabela de decisão** | Regras de negócio com combinação de condições | Liste condições × ações; reduza colunas redundantes | % de regras (colunas) cobertas |
| **Transição de estado** | Objeto com ciclo de vida (pedido, conta, sessão) | Desenhe estados, eventos, ações; cubra transições válidas e inválidas | Estados, transições, sequências |
| **Caso de uso / histórias** | Fluxos ponta a ponta | Fluxo principal + alternativos + exceções | Fluxos cobertos |

## Caixa-branca
- **Cobertura de instrução** (statement) e **de decisão** (branch): use quando houver acesso ao código; decisão é mais forte que instrução.

## Baseadas em experiência
- **Error guessing**: use histórico de defeitos (`docs/APRENDIZADOS.md`, issues) e lista de falhas típicas: vazio, nulo, espaços, acentos, emoji, SQL/HTML em campo, duplicidade, concorrência, timeout.
- **Teste exploratório**: carta (charter) com missão, timebox (30-90 min) e notas de sessão.
- **Baseado em checklist**: reaproveite listas (ex.: OWASP Top 10, acessibilidade WCAG).

## Procedimento
1. Leia o requisito e extraia entradas, regras, estados e riscos.
2. Escolha a técnica (muitas vezes combine PE + AVL; regras complexas pedem tabela de decisão).
3. Gere a tabela de casos: ID, técnica, entrada, resultado esperado, prioridade.
4. Elimine redundância; marque o que já está automatizado.
5. Entregue também a **lacuna de cobertura**: o que ficou de fora e por quê.

## Exemplo (campo senha 8-20 caracteres)
PE: <8 (inválida), 8-20 (válida), >20 (inválida). AVL: 7, 8, 20, 21. Error guessing: só espaços, caracteres especiais, senha igual ao e-mail.

## Regras
- Todo caso tem **resultado esperado verificável**, derivado do requisito (oráculo), nunca do comportamento atual do sistema.
- Casos negativos valem tanto quanto os positivos.
- Ligue cada caso a um requisito (rastreabilidade) quando houver.
