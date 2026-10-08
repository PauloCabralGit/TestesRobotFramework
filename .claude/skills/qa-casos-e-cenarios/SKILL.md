---
name: qa-casos-e-cenarios
description: Escreve casos de teste e cenários BDD/Gherkin claros, rastreáveis e automatizáveis, mantendo docs/CENARIOS.md e a matriz de rastreabilidade. Use ao pedir "escrever casos de teste", "cenários BDD", "critérios de aceite" ou "matriz de rastreabilidade".
---

# Casos de teste e cenários (ISTQB CTFL 4.0 §4 e §5; ISO 29119-3)

## Anatomia de um caso de teste
- **ID** (`CN###` web, `CT###` API), **título** que diz a intenção.
- **Requisito/risco** relacionado (rastreabilidade).
- **Técnica** usada e **prioridade** (alta/média/baixa).
- **Pré-condições** e **dados de teste**.
- **Passos** (um comportamento por caso) e **resultado esperado** verificável.
- **Pós-condição/limpeza** (o teste deixa o ambiente como encontrou).
- **Status de automação**: manual, automatizado, a automatizar.

## BDD (Dado/Quando/Então)
- Escreva no nível do negócio, não da interface: "Quando eu faço login com credenciais inválidas", não "clico no botão #login".
- Um cenário, um comportamento. No máximo ~7 passos.
- Reuse o padrão do projeto (Given/When/Then em inglês em `beginning.robot`, Dado/E/Entao em `API.robot`).
- Detalhes técnicos (seletores, esperas) ficam nas keywords de `Resourse.robot`.

## Bons critérios
Casos **independentes** (rodam em qualquer ordem), **determinísticos**, **atômicos**, com dado único por execução (e-mail com timestamp) e **sem** dependência de resultado de outro caso, salvo fluxo declarado.

## Matriz de rastreabilidade (`docs/CENARIOS.md`)
| Requisito | Caso | Técnica | Suíte | Automação | Último resultado |
Mantenha atualizada ao criar, alterar ou remover testes. Requisito sem caso = lacuna; caso sem requisito = revisar.

## Checklist de revisão do caso
- [ ] O resultado esperado vem do requisito e não do comportamento atual?
- [ ] Há caso negativo e de limite?
- [ ] Os dados são reproduzíveis e a limpeza é feita?
- [ ] O título é compreensível sem ler os passos?
