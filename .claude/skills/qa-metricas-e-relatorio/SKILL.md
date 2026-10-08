---
name: qa-metricas-e-relatorio
description: Coleta métricas de teste e escreve relatório de progresso e de conclusão (test summary report) no padrão ISTQB/ISO 29119-3, a partir dos resultados do Robot Framework. Use ao pedir "relatório de testes", "métricas", "status de qualidade" ou "go/no-go".
---

# Métricas e relatórios (ISTQB CTFL 4.0 §5.3; ISO/IEC/IEEE 29119-3)

## Fonte dos dados
`output.xml` / `results/**/output.xml` do Robot (use `python -m robot.rebot` para consolidar, p.ex. `rebot --outputdir results/all --output all.xml results/*/output.xml`), issues do GitHub (`gh issue list --label bug --json number,state,title,labels`) e `docs/CENARIOS.md`.

## Métricas
- **Execução**: total, passou, falhou, não executado, % passa, tempo.
- **Cobertura**: requisitos com caso (%), requisitos cobertos por automação (%), riscos mitigados.
- **Defeitos**: abertos × fechados, por severidade, por módulo, idade média, taxa de reabertura, eficácia de detecção (achados em teste ÷ total).
- **Automação**: flakiness, tempo de manutenção, % automatizado.
- **Tendência**: compare com a execução anterior.

## Relatório de conclusão (modelo)
1. **Resumo e recomendação** (go / no-go / go com ressalvas) no topo, em 3 linhas.
2. Escopo testado e o que **não** foi testado.
3. Resultados vs. critérios de saída do plano (tabela com atendido/não).
4. Métricas e tendência.
5. Defeitos abertos relevantes (com links).
6. Riscos residuais.
7. Lições aprendidas (alimentam `docs/APRENDIZADOS.md`).

## Regras
- Números sempre com a fonte e a data/hora; não arredonde para favorecer.
- Reporte o que está ruim com a mesma clareza do que está bom; não esconda falhas ou testes pulados.
- Uma métrica sem decisão associada é ruído: diga o que ela implica.
