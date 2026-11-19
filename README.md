# Sistema de streaming

Trabalho de Banco de Dados com evolução planejada para aplicação de portfólio.

- **SGBD:** MySQL; execução local registrada com MySQL 8.0.46.
- **Entrega:** 02/12/2026 às 23h55 (America/Manaus).
- **Estado:** modelos e DDL concluídos; gerador implementado e carga de 500 filmes, 1.000 clientes e 50.000 sessões verificada no MySQL. Consultas e reprodução integral em Linux pendentes.

## Documentação

| Arquivo | Finalidade |
| --- | --- |
| [ROTEIRO.md](ROTEIRO.md) | Calendário e checklist da entrega |
| [STATUS.md](STATUS.md) | Resultados verificados, limitações e próximo passo |
| [Modelo conceitual](docs/modelo-conceitual.md) | Entidades, atributos, relacionamentos e cardinalidades |
| [Modelo relacional](docs/modelo-relacional.md) | Relações, chaves e normalização até a 3FN |
| [Manual do gerador](docs/manual-gerador.md) | Instalação, carga e verificações |
| [AGENTS.md](AGENTS.md) | Orientações para continuar o trabalho com o Codex |

Os modelos e o manual foram preservados nesta organização. Menções antigas a próximas etapas nesses documentos devem ser confrontadas com o estado atual em STATUS.md. Regras operacionais consolidadas e interpretações das consultas estão abaixo; convenções ainda pendentes estão no roteiro.

## Código e dados

- [sql/criacao.sql](sql/criacao.sql): criação do banco vazio e das 11 tabelas.
- [sql/verificacao_carga.sql](sql/verificacao_carga.sql): 12 verificações; selecionar explicitamente o banco antes de executar.
- `scripts/`: gerador Python e carga transacional pelo MySQL Connector/Python.
- `seeds/`: CSV de regiões, planos, gêneros e 500 filmes fictícios.
- [requirements.txt](requirements.txt): versões das dependências.

A instalação e os comandos de execução estão no manual. A carga exige tabelas vazias e não deve ser executada simultaneamente por dois processos. O SQL de criação não apaga um banco existente.

## Regras e limites do escopo

- Cliente mantém id como PK e email obrigatório e único. Avaliações e favoritos guardam uma associação atual por cliente/filme; alterar nota não cria histórico de avaliações. Remover e favoritar novamente corresponde a uma nova data.
- Assinaturas preservam histórico: na troca, encerrar o período anterior e inserir outro registro, sem excluir a assinatura antiga ou substituir seu plano. Vigência inclui início e exclui término; término NULL representa período aberto. Cliente ativo tem assinatura vigente na data de referência. Retornar a um plano anterior deve ser outro período; esse cenário ainda precisa ser conferido nos testes das consultas.
- Região de residência é fixa no escopo e pertence a um país. Disponibilidade de catálogo e consumo são fatos distintos. Filmes podem ter vários gêneros; seus minutos entram em cada gênero associado, portanto somar os grupos pode exceder o tempo total assistido.
- Consulta 5: hipótese adotada de consumo global dos filmes disponíveis em Y, incluindo títulos com zero sessões no mês. Consulta 8: consumo dos clientes residentes em Y. Essas interpretações devem ser explicitadas no relatório.
- Nota inteira de 1 a 5; durações em minutos e positivas; preços e limite de dispositivos positivos, sem planos gratuitos. Qualidades ordenadas: SD, HD, FULL_HD, 4K.
- O DDL garante chaves e restrições locais. Coerência entre registros/tabelas (sobreposição de assinaturas, vigência, disponibilidade e limite de qualidade) é produzida pelo gerador e conferida por verificações, não garantida integralmente pelo DDL.
- O gerador atual usa referência 19/11/2026 e semente 10; os padrões são 20 clientes e 150 sessões, com volume configurável na carga. A carga ampliada usa 1.000 clientes e 50.000 sessões. Versões, CSV, parâmetros e ambiente devem ser mantidos para reprodução.
- Sessões são sorteadas nos 365 dias anteriores à referência, em dias de assinatura vigente, com filmes disponíveis e já lançados, qualidade permitida e duração entre 1 e a duração do filme. Uma sessão por cliente por dia simplifica a simultaneidade. Avaliações/favoritos têm pares únicos e datas a partir do cadastro; assistir antes de avaliar não é uma exigência adotada.
- CSV semente fornece dados-base; semente numérica controla aleatoriedade. O catálogo é sintético, com fórmulas narrativas repetidas. Há 5 regiões em 2 países, 3 planos e 8 gêneros. A escala é uma escolha acadêmica; o professor não fixou um número mínimo explícito.
- Usar uma referência temporal comum nas consultas e verificações. Não calcular uma referência diferente por cliente, filme ou filtro. A interpretação de último mês/trimestre ainda precisa ser consolidada; ver ROTEIRO.md.

## Alternar entre computadores

Repositório privado: [caiowp1/sistema-de-streaming](https://github.com/caiowp1/sistema-de-streaming).

Na primeira utilização em outro computador, com Git instalado e acesso autenticado:

```sh
git clone https://github.com/caiowp1/sistema-de-streaming.git
```

Abra a pasta clonada como projeto no Codex. Antes de começar, execute `git status`; se não houver alterações pendentes, execute `git pull --ff-only`. Se houver alterações locais ou conflito, preserve os arquivos e examine a situação antes de atualizar.

Ao terminar, atualize STATUS.md e revise `git status` e `git diff`. Registre apenas os arquivos pretendidos em um commit e envie com `git push`. Confirme o envio antes de trocar de computador; evite editar a mesma etapa simultaneamente nos dois.

O Git transfere os arquivos registrados. Chats do Codex, credenciais, ambientes virtuais, programas instalados e banco MySQL local não são transferidos. O banco de cada computador precisa ser criado e populado conforme o manual. Não publique senhas ou tokens.

Pedido para retomar em outro chat:

> Leia AGENTS.md, README.md, ROTEIRO.md e STATUS.md. Confira o Git e retome o próximo passo. Ao terminar, atualize o status e registre as decisões relevantes.
