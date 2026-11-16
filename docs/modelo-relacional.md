# Esquema relacional — sistema de streaming

Versão de 15/11/2026, baseada no conceitual e no modelo lógico revisado no brModelo. A imagem será adicionada pelo aluno.

## Notação

Cada expressão RELACAO(atributos) representa uma tabela. **Negrito** indica os atributos da chave primária (PK); # indica chave estrangeira (FK). Vários atributos em negrito na mesma relação formam juntos uma única PK composta. Os nomes foram padronizados sem acentos e com sublinhados para a futura implementação em MySQL.

## Relações

REGIAO(**id**, nome, pais)

CLIENTE(**id**, nome_completo, email, data_nascimento, data_cadastro, #id_regiao)

PLANO(**id**, nome, valor_mensal, qualidade_maxima, quantidade_dispositivos)

ASSINATURA(**id**, data_inicio, data_termino, #id_cliente, #id_plano)

FILME(**id**, titulo, sinopse, idioma_original, classificacao_indicativa, produtora, duracao, ano_lancamento)

SESSAO(**id**, data, hora_inicio, duracao, dispositivo, qualidade_usada, #id_cliente, #id_filme)

GENERO(**id**, tipo)

AVALIA(**#id_cliente**, **#id_filme**, data, nota)

FAVORITA(**#id_cliente**, **#id_filme**, data)

FILME_REGIAO(**#id_filme**, **#id_regiao**)

FILME_GENERO(**#id_filme**, **#id_genero**)

## Referências das chaves estrangeiras

Cada valor não nulo da FK deve existir na PK indicada.

| Chave estrangeira | Chave primária referenciada |
| --- | --- |
| CLIENTE.id_regiao | REGIAO.id |
| ASSINATURA.id_cliente | CLIENTE.id |
| ASSINATURA.id_plano | PLANO.id |
| SESSAO.id_cliente | CLIENTE.id |
| SESSAO.id_filme | FILME.id |
| AVALIA.id_cliente | CLIENTE.id |
| AVALIA.id_filme | FILME.id |
| FAVORITA.id_cliente | CLIENTE.id |
| FAVORITA.id_filme | FILME.id |
| FILME_REGIAO.id_filme | FILME.id |
| FILME_REGIAO.id_regiao | REGIAO.id |
| FILME_GENERO.id_filme | FILME.id |
| FILME_GENERO.id_genero | GENERO.id |

## Justificativa do mapeamento

As sete entidades do conceitual originaram sete relações. Nos relacionamentos 1:N, a FK fica no lado N: CLIENTE referencia REGIAO; ASSINATURA referencia CLIENTE e PLANO; SESSAO referencia CLIENTE e FILME.

Os quatro relacionamentos N:N originaram AVALIA, FAVORITA, FILME_REGIAO e FILME_GENERO. Os pares de FKs formam PKs compostas, impedindo associações repetidas. Data e nota permanecem nos relacionamentos aos quais pertencem.

AVALIA representa uma avaliação atual por cliente/filme: alterar a nota modifica o registro existente. FAVORITA representa a associação atual e a data em que foi criada. Não há histórico de alterações desses dois relacionamentos.

ASSINATURA e SESSAO possuem IDs próprios: um cliente pode retornar ao mesmo plano em outro período e assistir ao mesmo filme em várias sessões.

## Domínios e restrições para o DDL

- IDs, quantidade de dispositivos e ano de lançamento: inteiros.
- Datas: DATE; hora de início: TIME.
- Qualidade máxima do plano e qualidade usada na sessão: texto com valores padronizados. São, respectivamente, o limite permitido e a qualidade efetivamente utilizada.
- Valor mensal: o editor apresenta FLOAT por limitação dos tipos disponíveis. No DDL MySQL, usar DECIMAL(10,2).
- PKs são únicas e não nulas. Nas associativas, as FKs também são não nulas por integrarem a PK.
- Cada cliente referencia exatamente uma região; cada assinatura, um cliente e um plano; cada sessão, um cliente e um filme. Essas FKs devem ser obrigatórias.
- A exigência de pelo menos uma assinatura por cliente e de pelo menos uma região e um gênero por filme exige validação adicional: FKs sozinhas não garantem esses mínimos.

Comprimentos de textos, unidades de duração, demais domínios, unicidade de email e regras de vigência serão consolidados antes do DDL. As regras ainda propostas estão em [modelo-conceitual.md](modelo-conceitual.md).

## Situação da entrega

O esquema contém 11 relações e 13 referências de FKs. A revisão das dependências funcionais e a justificativa de 1FN, 2FN e 3FN exigidas no trabalho ainda estão pendentes. Este documento não é o script SQL de criação do banco.
