# Esquema relacional e normalização — sistema de streaming

Versão de 15/11/2026. Base: modelo conceitual, modelo lógico revisado no brModelo e material do professor 06 - As Formas Normais.pdf, páginas 3–12.

## Notação

RELACAO(atributos) representa uma tabela. **Negrito** indica PK; # indica FK. Vários atributos em negrito formam uma única PK composta. Os nomes foram padronizados sem acentos e com sublinhados para a implementação MySQL. Na análise, X → Y significa que X determina funcionalmente Y; essa seta não indica uma FK.

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

| Chave estrangeira | PK referenciada |
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

As sete entidades originaram sete relações. Nas relações 1:N, a FK fica no lado N: CLIENTE referencia REGIAO; ASSINATURA referencia CLIENTE e PLANO; SESSAO referencia CLIENTE e FILME.

Os quatro relacionamentos N:N originaram AVALIA, FAVORITA, FILME_REGIAO e FILME_GENERO. Os pares de FKs formam PKs compostas, impedindo associações repetidas. Data e nota permanecem nos relacionamentos aos quais pertencem.

AVALIA guarda uma avaliação atual por cliente/filme; alterar a nota modifica o registro. FAVORITA guarda a associação atual e sua data de criação, sem histórico de alterações. ASSINATURA e SESSAO possuem IDs próprios: um cliente pode retornar ao mesmo plano em outro período e assistir ao mesmo filme em várias sessões.

## Premissas da normalização

A normalização depende das regras do domínio; adicionar uma coluna id não prova que uma tabela está normalizada. A análise considera:

- Cada atributo guarda um valor por registro. Produtora e idioma original são únicos por filme neste escopo. Coproduções ou vários idiomas exigiriam rever essa decisão.
- Nomes de região não são globalmente únicos: o mesmo nome pode ocorrer em países distintos. Cada id identifica uma região de um país. Não se presume nome → pais.
- Títulos, nomes, datas, preços e qualidades podem se repetir. Não se presumem dependências como qualidade_maxima → valor_mensal ou produtora → idioma_original.
- Nota e data da avaliação dependem do par cliente/filme. A data do favorito também depende do par.
- Preço e limites são propriedades do plano. Duração assistida e qualidade usada pertencem à sessão.
- Se email for obrigatório e único, será uma chave candidata alternativa de CLIENTE. Essa regra ainda será consolidada no DDL e não altera a conclusão abaixo.

## Dependências funcionais

X → Y significa: registros com o mesmo valor de X devem ter o mesmo valor de Y. A tabela lista dependências geradoras relevantes, sem enumerar todas as triviais e derivadas.

| Relação | Dependência funcional |
| --- | --- |
| REGIAO | id → nome, pais |
| CLIENTE | id → nome_completo, email, data_nascimento, data_cadastro, id_regiao |
| PLANO | id → nome, valor_mensal, qualidade_maxima, quantidade_dispositivos |
| ASSINATURA | id → data_inicio, data_termino, id_cliente, id_plano |
| FILME | id → titulo, sinopse, idioma_original, classificacao_indicativa, produtora, duracao, ano_lancamento |
| SESSAO | id → data, hora_inicio, duracao, dispositivo, qualidade_usada, id_cliente, id_filme |
| GENERO | id → tipo |
| AVALIA | (id_cliente, id_filme) → data, nota |
| FAVORITA | (id_cliente, id_filme) → data |
| FILME_REGIAO | Apenas os atributos da PK; nenhuma dependência não trivial adicional assumida |
| FILME_GENERO | Apenas os atributos da PK; nenhuma dependência não trivial adicional assumida |

Com email obrigatório e único, acrescenta-se CLIENTE.email → id e demais atributos de CLIENTE. O determinante é uma chave candidata, portanto essa dependência não viola a 3FN.

## Primeira Forma Normal — 1FN

A 1FN exige atributos atômicos e ausência de grupos repetitivos. Todas as relações possuem PK e cada campo guarda um único valor no domínio adotado. Nome completo e sinopse são valores textuais únicos, mesmo contendo várias palavras.

Vários gêneros e regiões de um filme são representados por linhas em FILME_GENERO e FILME_REGIAO. Não se guardam listas como “Drama, Comédia” em FILME, nem colunas genero1, genero2 e genero3. Avaliações, favoritos, assinaturas e sessões também possuem registros próprios.

Assim, as 11 relações atendem à 1FN. Repetir uma FK em linhas diferentes é permitido e não viola essa forma normal.

## Segunda Forma Normal — 2FN

A 2FN exige a 1FN e ausência de dependência parcial de atributo não primo em relação a qualquer chave candidata. Atributo primo é aquele que participa de alguma chave candidata.

REGIAO, CLIENTE, PLANO, ASSINATURA, FILME, SESSAO e GENERO possuem chave simples id. Sob as dependências adotadas não há chaves candidatas compostas com dependências parciais; eventual email único também será chave simples.

Em AVALIA, nota e data dependem do par (id_cliente, id_filme). Um cliente avalia filmes diferentes; um filme recebe avaliações de clientes diferentes. Nenhum dos identificadores isoladamente determina nota ou data. Em FAVORITA, a data também depende do par completo.

FILME_REGIAO e FILME_GENERO contêm somente atributos das próprias chaves; não há atributos não primos com dependência parcial.

Logo, as 11 relações atendem à 2FN. Colocar titulo em AVALIA seria uma violação: esse atributo dependeria somente de id_filme. O título já está corretamente em FILME.

## Terceira Forma Normal — 3FN

A 3FN exige a 2FN e elimina dependências transitivas inadequadas. Formalmente, em cada dependência não trivial X → A, X deve ser uma superchave ou A deve ser atributo primo.

Nas dependências adotadas, todos os determinantes não triviais são chaves. Não há dependência entre atributos não chave que viole esse critério.

| Relações | Justificativa |
| --- | --- |
| CLIENTE e REGIAO | Nome e país da região ficam em REGIAO. CLIENTE guarda apenas id_regiao, evitando repetir dados geográficos. Em REGIAO, nome não determina país sob as premissas adotadas. |
| ASSINATURA e PLANO | Nome, preço e limites ficam em PLANO. ASSINATURA guarda a referência e os dados do período, sem copiar propriedades do plano. |
| SESSAO e FILME | Título e duração do filme ficam em FILME; SESSAO guarda os dados da reprodução. Duração assistida pode diferir da duração do filme. |
| GENERO e FILME_GENERO | O tipo do gênero fica em GENERO, sem repetição em cada associação. |
| AVALIA e FAVORITA | Data e nota dependem do par completo. Não se assume dependência entre data e nota. |
| FILME_REGIAO | Contém apenas o par de identificadores da associação. |

Um plano pode permitir várias qualidades de reprodução; qualidade usada não é uma cópia da qualidade máxima. A regra que limita a reprodução pelo plano é uma validação de negócio. Guardar país ou produtora como texto, por si só, não exige criar tabelas adicionais: isso dependeria de outras propriedades e dependências.

As 11 relações atendem à 3FN sob as premissas explicitadas. Não foi necessária decomposição adicional; o mapeamento já separou os fatos relevantes.

## Domínios e restrições para o DDL

- IDs, quantidade de dispositivos e ano de lançamento: inteiros. Datas: DATE; hora de início: TIME.
- Qualidade máxima e qualidade usada: texto com valores padronizados.
- Valor mensal: FLOAT no editor pelas opções disponíveis; no DDL MySQL, usar DECIMAL(10,2).
- PKs são únicas e não nulas. FKs das associativas são não nulas por integrarem as PKs.
- Cliente referencia uma região; assinatura, um cliente e um plano; sessão, um cliente e um filme. Essas FKs devem ser obrigatórias.
- Pelo menos uma assinatura por cliente e pelo menos uma região e um gênero por filme exigem validação adicional: FKs sozinhas não garantem esses mínimos.

Normalização não substitui CHECK, UNIQUE, NOT NULL nem regras de negócio. Comprimentos de textos, unidades de duração, limites da nota, unicidade de email e vigência serão consolidados antes do DDL. As regras ainda propostas estão em [modelo-conceitual.md](modelo-conceitual.md).

## Resultado

Esquema com 11 relações e 13 referências de FKs validado até a 3FN sob as dependências e premissas documentadas. O desenho permanece estruturalmente igual. Não houve decomposição adicional, portanto não foi introduzida nova junção a verificar quanto à perda de informação. Próximo passo: consolidar domínios e regras pendentes e implementar o DDL MySQL.
