# Aprendizados do projeto

Memória do agente `automatizador-qa`. Entradas curtas; corrija em vez de duplicar.

## 2026-10-08 - Sintaxe BDD e nomes de keywords
- Contexto: várias chamadas falharam com "No keyword with name 'When ...' found".
- Aprendizado/regra: o Robot ignora o prefixo Given/When/Then/And/But só na chamada. Se a keyword foi definida COM o prefixo no nome (ex.: `And I click on Login`), a chamada precisa usar exatamente o mesmo prefixo. Keywords novas devem ser definidas sem prefixo.
- Como aplicar: antes de rodar, execute `python -m robot --dryrun` (sem abrir navegador).

## 2026-10-08 - Variáveis do Robot ignoram maiúsculas/minúsculas
- Contexto: `${Cvc}` (argumento embutido) sobrescreveu a variável global `${CVC}` (locator) e o teste procurou o elemento "12".
- Aprendizado/regra: nomes de variáveis são case-insensitive. Argumentos de keyword não podem ter o mesmo nome (ignorando caixa) de variáveis globais de locator.
- Como aplicar: use sufixos como `_Value` nos argumentos. Cuidado com `--skiponfailure`: ele esconde erros do próprio teste; confira o motivo do SKIP.

## 2026-10-08 - Barra invertida em expressões Evaluate
- Contexto: `re.sub(r'\D', ...)` virou `D` dentro do `.robot`.
- Aprendizado/regra: o Robot consome `\`. Prefira classes sem barra, como `[^0-9]`.

## 2026-10-08 - Locator de logout quebrado (monitor do CI, run 37842985004)
- Contexto: 4 testes web (CN005, CN007, CN008, CN009) falharam com "Element 'css:a[href="/logoutt"]' not visible".
- Causa: typo em `${Logout_Link}` (`/logoutt`) em `TesteCadastro/Resourse.robot`. O último run da master passava, então não era mudança do site (classe A: teste quebrado).
- Aprendizado/regra: quando vários testes falham com a MESMA mensagem de locator, procure o `git diff` da variável de locator antes de inspecionar o site. O link correto é `a[href="/logout"]`.
- Como aplicar: comparar com o último run verde da master (`gh run list --branch master`) para separar teste quebrado de mudança do site.
