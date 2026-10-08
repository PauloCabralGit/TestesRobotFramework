---
name: qa-plano-de-testes
description: Cria e mantém plano e estratégia de testes seguindo ISTQB (processo de teste, abordagem baseada em risco, critérios de entrada/saída, níveis e tipos de teste, ISO 25010). Use ao pedir "plano de testes", "estratégia de testes", "análise de risco" ou ao iniciar uma nova funcionalidade ou projeto.
---

# Plano de testes (ISTQB CTFL 4.0, cap. 5; ISO/IEC/IEEE 29119-3)

Gere/atualize `docs/PLANO_DE_TESTES.md` com as seções abaixo. Seja objetivo; remova seções que não se aplicam e diga por quê.

## Estrutura
1. **Identificação e escopo**: sistema, versão, o que está **dentro** e **fora** do escopo.
2. **Objetivos de teste**: ligados a objetivos de negócio e a riscos.
3. **Itens de teste e funcionalidades**: lista priorizada.
4. **Abordagem/estratégia**:
   - **Níveis**: componente, integração, sistema, aceite.
   - **Tipos**: funcional, não funcional (ISO 25010: adequação funcional, desempenho, compatibilidade, usabilidade, confiabilidade, segurança, manutenibilidade, portabilidade), confirmação, regressão.
   - **Técnicas** a usar (ver skill `qa-tecnicas-de-teste`).
   - **Pirâmide de automação**: priorize API/unidade; UI só para fluxos críticos.
5. **Análise de risco** (tabela): risco, probabilidade (1-3), impacto (1-3), exposição = P×I, mitigação/teste. Ordene os testes pela exposição.
6. **Critérios de entrada**: build disponível, ambiente estável, dados de teste, requisitos revisados.
7. **Critérios de saída/conclusão**: ex. 100% dos testes críticos executados, 0 defeitos críticos/altos abertos, ≥ 95% de passa, cobertura de requisitos acordada.
8. **Critérios de suspensão/retomada**: ex. ambiente fora do ar, bloqueio por defeito crítico.
9. **Ambiente e dados**: URLs, contas, massa de dados, ferramentas (Robot Framework, Selenium, Requests, GitHub Actions), restrições (conta compartilhada exige execução serial).
10. **Papéis e responsabilidades**.
11. **Cronograma e estimativa**: justifique (por analogia, proporção, três pontos).
12. **Métricas e relatórios**: ver skill `qa-metricas-e-relatorio`.
13. **Gestão de defeitos**: ver skill `qa-relatorio-de-defeitos`.
14. **Riscos do projeto e premissas**.

## Processo de teste (referência de atividades)
Planejamento → Monitoramento e controle → Análise → Modelagem → Implementação → Execução → Conclusão. Ao atualizar o plano, indique em qual atividade o trabalho está.

## Regras
- O plano é vivo: atualize quando o escopo, o risco ou o resultado dos testes mudar.
- Não invente prazos, nomes ou números: use `A definir` quando não souber e pergunte.
- Todo risco tem pelo menos um teste ou uma decisão explícita de aceitá-lo.
