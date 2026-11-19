# Atualização — 19/11/2026, organização do gerador

- Removidas as cópias SQL específicas de bancos de teste e o roteiro de teste de desempenho; resultados foram mantidos nos registros históricos abaixo. Permanecem o DDL único sql/criacao.sql e sql/verificacao_carga.sql, que requer seleção explícita do banco antes da execução.
- Adicionados requirements.txt com versões instaladas e docs/manual-gerador.md com instalação, carga e verificação; README atualizado. Código permanece dividido em configuração, sementes, catálogo, clientes, sessões, geração e carga MySQL. Nenhum banco foi alterado nesta organização.
- Após a organização, geração de 500 filmes, 1.000 clientes e 50.000 sessões reproduziu as contagens anteriores; inserção verificada com conexão simulada. Carga real não foi repetida.
- Próximos passos: verificar integralmente o manual em Linux e validar as dez consultas. Referências a scripts removidos nos registros abaixo são históricas.

---

# Atualização — 19/11/2026, verificações do catálogo ampliado

- O aluno executou sql/verificacao_catalogo.sql no Workbench sobre sistema_streaming_catalogo. Todas as 12 contagens de problemas retornaram zero para a carga de 500 filmes, 1.000 clientes e 50.000 sessões.
- A verificação cobre as regras listadas no script, não garante cobertura de todos os cenários das dez consultas. Permanecem a documentação do gerador, a reprodução em Linux e a validação dos cenários das consultas.

---

# Atualização — 19/11/2026, carga do catálogo ampliado no MySQL

- O aluno carregou sistema_streaming_catalogo e confirmou via SELECT 1.000 clientes, 500 filmes e 50.000 sessões. O programa informou geração em 5,71 s e inserção/commit em 26,09 s nesta execução local.
- Demais contagens informadas pelo programa: 5 regiões, 3 planos, 8 gêneros, 508 relações filme-gênero, 1.518 filme-região, 1.333 assinaturas, 2.021 avaliações e 1.997 favoritos. A saída de sql/verificacao_catalogo.sql ainda não foi apresentada; conferir antes de considerar as regras validadas no banco.

---

# Atualização — 19/11/2026, preparação do teste do catálogo ampliado

- Preparados sql/criacao_catalogo.sql e sql/verificacao_catalogo.sql para testar a carga com 500 filmes no banco separado sistema_streaming_catalogo. A criação e a carga nesse banco ainda dependem de execução pelo aluno.

---

# Atualização — 19/11/2026, catálogo ampliado

- seeds/filmes.csv ampliado de 12 para 500 filmes fictícios, preservando os 12 originais; 488 títulos e sinopses adicionais foram criados por combinações de temas, lugares e descrições. Isso é dado sintético e tem repetição de fórmulas narrativas, não um catálogo de obras reais.
- Conferidos unicidade dos títulos e limites de tamanho. Geração em memória com 500 filmes, 1.000 clientes e 50.000 sessões concluída; verificados vigência, disponibilidade, limite de qualidade, duração e ano de lançamento das sessões.
- As cargas existentes no MySQL continuam com 12 filmes; a carga ampliada ainda não foi inserida nem verificada no SGBD. Próximo passo: testar em banco vazio separado e conferir as regras e os tempos, sem apagar os bancos existentes.

---

# Atualização — 19/11/2026, contagens do teste de volume confirmadas

- Consulta direta no Workbench ao banco sistema_streaming_desempenho confirmou 1.000 clientes, 12 filmes e 50.000 sessões. As demais contagens continuam sendo as informadas pelo programa.
- Próximos passos: ampliar o catálogo atualmente limitado a 12 filmes, preparar cenários para as consultas e concluir manual e verificação de execução em Linux.

---

# Atualização — 19/11/2026, teste de volume no MySQL

- No banco separado sistema_streaming_desempenho, o aluno executou carga de 1.000 clientes e 50.000 sessões: geração em 1,22 s; inserção e commit em 31,99 s. São tempos de uma execução local, não benchmark comparativo.
- Programa informou 5 regiões, 3 planos, 8 gêneros, 12 filmes, 1.000 clientes, 20 relações filme-gênero, 38 filme-região, 1.333 assinaturas, 50.000 sessões, 2.036 avaliações e 2.031 favoritos. Essas contagens foram exibidas pelo programa, não conferidas individualmente por SELECT.
- Aluno executou sql/verificacao_desempenho.sql no Workbench: as 12 verificações retornaram zero problemas. Próximos passos: conferir contagens diretamente no banco; ampliar catálogo e cenários; documentar manual e testar procedimento Linux. Preservar ambos os bancos existentes.

---

# Atualização — 19/11/2026, preparação do teste de volume

- Carga aceita parâmetros de banco, clientes e sessões e informa tempos separados de geração e inserção/commit. Configuração de teste: 1.000 clientes e 50.000 sessões, ainda com apenas 12 filmes de semente.
- Criados sql/criacao_desempenho.sql e sql/verificacao_desempenho.sql para banco separado; procedimento em docs/teste-desempenho.md. Geração em memória produziu 1.000 clientes e 50.000 sessões em cerca de 1,26 s neste ambiente, com um par cliente/dia por sessão.
- Ainda não foi executada a carga de volume no MySQL, nem medidas a inserção e verificações dessa carga. Próximo passo: aluno executar o procedimento no banco de desempenho e registrar resultados. O catálogo de 500 filmes proposto no planejamento permanece pendente.

---

# Atualização — 19/11/2026, levantamento inicial de cenários

- Conferida em memória a geração com a configuração atual: 1 filme sem avaliações, 5 filmes sem sessões em outubro/2026, 2 clientes sem favoritos, 6 clientes com mais de uma assinatura e 42 pares cliente/filme com reassistidas. São contagens do gerador reproduzido, não uma nova consulta direta ao MySQL.
- A presença casual de casos não substitui cenários pequenos com resultados conhecidos; ainda faltam casos controlados, testes de fronteira e empates, revisão de escala/desempenho e manual Linux. Preservar a primeira carga ao testar em banco separado.

---

# Atualização — 19/11/2026, verificações da primeira carga

- O aluno executou sql/verificacao_carga.sql no Workbench; as 12 contagens de problemas foram zero, incluindo sobreposição de assinaturas, vigência de sessões, disponibilidade regional, qualidade, duração e cobertura de gêneros/regiões.
- Primeira carga pequena validada nas verificações implementadas. Isso não conclui a etapa: faltam escala e catálogo ampliados, cenários controlados com respostas conhecidas para as consultas, testes adicionais e manual de execução no Linux. Preservar a carga existente ao preparar novos testes.

---

# Atualização — 19/11/2026, contagens conferidas no MySQL

- O aluno executou contagens no Workbench e confirmou as 11 tabelas com os mesmos valores anunciados pela carga: 5, 3, 8, 12, 20, 20, 38, 26, 150, 48 e 51, respectivamente para região, plano, gênero, filme, cliente, filme-gênero, filme-região, assinatura, sessão, avaliação e favorito.
- Criado sql/verificacao_carga.sql para conferir regras entre registros e tabelas; sua execução no MySQL ainda está pendente. Próximo passo: executar e analisar as contagens de problemas.

---

# Atualização — 19/11/2026, primeira execução da carga

- O aluno executou scripts/carga_mysql.py contra o MySQL local; o programa informou carga concluída: 5 regiões, 3 planos, 8 gêneros, 12 filmes, 20 clientes, 20 relações filme-gênero, 38 filme-região, 26 assinaturas, 150 sessões, 48 avaliações e 51 favoritos.
- As contagens exibidas são dos dados enviados pelo programa. A confirmação direta no banco e as verificações SQL de integridade ainda estão pendentes. Próximo passo: conferir as 11 tabelas no Workbench e validar regras de negócio.

---

# Atualização — 19/11/2026, preparação da carga MySQL

- O aluno consultou no Workbench: regiao, plano, cliente e sessao têm zero registros. As demais tabelas ainda não foram observadas diretamente.
- Criado scripts/carga_mysql.py: confere as 11 tabelas vazias, insere por ordem de dependência, mapeia IDs AUTO_INCREMENT retornados pelo MySQL e usa commit/rollback. Senha é solicitada na execução, sem registro em arquivo.
- Teste simulado verificou quantidade de inserções, mapeamento de IDs, commit e rollback em erros; ainda não houve execução real contra o MySQL nem verificação de integridade após carga. A execução real é o próximo passo.

---

# Atualização — 19/11/2026, geração modular em memória

- O gerador agora produz registros para as 11 tabelas em memória; módulos separados para configuração, leitura de sementes, catálogo, clientes/assinaturas e sessões. Arquivos de exercício ler_planos.py e ler_regioes.py removidos a pedido do aluno.
- Adicionadas sementes de gêneros e 12 filmes fictícios. Com a configuração inicial são gerados 20 clientes e 150 sessões; referência e semente estão em scripts/configuracao.py. Os IDs são provisórios e servem apenas para relacionar os dados em memória.
- Verificados execução, repetibilidade, vigência das sessões, disponibilidade regional, qualidade, duração e unicidade dos pares de avaliações/favoritos. Uma sessão por cliente por dia simplifica o limite de dispositivos. Ainda não há inserção no MySQL nem verificação integrada no SGBD.
- Próximos passos: conexão e carga transacional usando IDs efetivos, escala e catálogo ampliados, cenários controlados das consultas, validação integrada e manual Linux. A etapa do gerador permanece em andamento.

---

# Atualização — 19/11/2026, início do gerador

- Ambiente Python 3.14 configurado pelo aluno; Faker 40.54.0 e mysql-connector-python 26.10.0 instalados no ambiente virtual. A pasta .venv está ignorada pelo Git.
- Arquivos semente iniciais seeds/regioes.csv e seeds/planos.csv; scripts/gerador.py lê ambos por uma função comum e gera cinco clientes em memória. Data de referência 19/11/2026, semente 10 e quantidade configuráveis no início do arquivo. Região é um dicionário temporário, não uma chave do banco.
- Execução local concluída; duas execuções com os mesmos parâmetros geraram saída idêntica. Nenhuma conexão ou inserção no MySQL foi realizada. Os dados e e-mails são provisórios; garantir unicidade contra dados existentes na carga.
- Próximo passo: completar sementes e gerador para as 11 tabelas, incluindo histórico, sessões coerentes, cenários conhecidos, transação, verificações e manual Linux. Esta etapa ainda não está concluída.

---

# Atualização — 17/11/2026, preparação do gerador

- Dois enunciados relidos. Linguagem livre, bibliotecas permitidas, MySQL e arquivos de texto semente; nenhum número mínimo de registros explícito.
- Aluno confirmou preservação do histórico de assinaturas na troca de plano: encerrar o período anterior e inserir outro registro, sem excluir a assinatura antiga.
- Interpretação da consulta 5 sugerida pelo aluno: consumo global dos filmes disponíveis em Y. Consulta 8 continua regional pela residência dos clientes.
- Planejamento em docs/planejamento-gerador.md: convenção de vigência, interpretação regional, propostas para data de referência, Python/Faker/conector MySQL, escala e coerência dos cenários. Propostas de linguagem, escala e períodos relativos ainda não são decisões confirmadas pelo aluno.
- Próximo passo: consolidar essas propostas e implementar o gerador. Ainda não há código de população nem instalação de dependências nesta etapa.

---

# Atualização — 17/11/2026, ordem das chaves reconciliada

- Ajustado sql/criacao.sql: AVALIA e FAVORITA usam a ordem (id_cliente, id_filme) nas colunas, na PK composta e na apresentação das FKs, conforme docs/modelo-relacional.md. Referências e regra de unicidade do par preservadas.
- Verificação: diff do SQL conferido e git diff --check sem erros. O script alterado não foi reexecutado no MySQL; bancos já criados não são modificados pela edição do arquivo.
- Próximo passo: completar verificações relevantes e planejar o gerador e os cenários das consultas. A divergência de ordem mencionada no registro histórico abaixo foi resolvida no arquivo.

---

# Atualização — 17/11/2026, criação e testes iniciais do banco

- Script de criação em [sql/criacao.sql](sql/criacao.sql), transcrito do script apresentado pelo aluno; contém somente a criação do banco e das 11 tabelas. MySQL local: 8.0.46. O aluno executou a criação no Workbench e `SHOW TABLES` confirmou as 11 tabelas.
- Testes observados no Workbench: preço zero, qualidade ULTRA, nota 6 e término anterior ao início rejeitados por CHECK; preço positivo, nota 5 e término NULL aceitos. FK rejeitou cliente com região inexistente e aceitou região existente; UNIQUE rejeitou email repetido; PK composta rejeitou avaliação duplicada. AUTO_INCREMENT gerou identificadores.
- Após os testes com dados, o aluno informou que recriou o banco executando o arquivo salvo no Workbench, sem erros; `SHOW TABLES` confirmou novamente as 11 tabelas. O script não contém dados. Para executá-lo, o banco de mesmo nome não deve existir. O conteúdo das tabelas após a recriação não foi conferido individualmente.
- Decisão para a entrega: manter as 11 tabelas e simplificar as regras entre registros/tabelas; o gerador deverá produzir dados coerentes e verificações deverão conferir as regras. Sobreposição de assinaturas, vigência, disponibilidade regional e limite de qualidade não são garantidos pelo DDL atual. Limites de vigência ainda precisam ser definidos. Não há planos gratuitos.
- A ordem da PK de AVALIA e FAVORITA no SQL executado é (id_filme, id_cliente); o esquema textual apresenta a ordem inversa. Ambas impedem pares duplicados, mas a diferença de ordem deve ser reconciliada e testada antes da entrega.
- Próximo passo: reconciliar a ordem das chaves com o esquema textual, completar verificações relevantes e planejar o gerador, suas regras e cenários para as consultas.

---

# Decisões aprovadas — 15/11/2026, preparação do DDL

Este registro consolida as regras aprovadas pelo aluno e prevalece sobre menções anteriores a essas mesmas regras como pendentes, inclusive no conceitual e no esquema relacional. Não significa que o DDL já foi implementado.

| Item | Regra aprovada |
| --- | --- |
| Identificação do cliente | CLIENTE.id permanece como PK. Todas as FKs existentes continuam referenciando esse id. |
| Email | Obrigatório e único (NOT NULL e UNIQUE), chave candidata alternativa. Pode ser alterado sem mudar as referências ao cliente. |
| Avaliação | Nota inteira de 1 a 5; uma avaliação atual por par cliente/filme. |
| Duração | Duração de filme e sessão em minutos, com valores positivos. |
| Qualidade | Valores SD, HD, FULL_HD e 4K, ordenados nessa sequência para validar limites. |
| Assinatura | Término pode ser nulo; quando preenchido, deve ser posterior ao início. |
| Troca de plano | Novo registro no histórico de assinaturas; não permitir períodos sobrepostos para o mesmo cliente. |
| Cliente ativo | Possui assinatura vigente na data de referência. |
| Sessão | Exige assinatura vigente, filme disponível na região do cliente e qualidade usada dentro do limite do plano. |
| Região do consumo | Região de residência do cliente, considerada fixa no escopo acadêmico. |

A confirmação de email como chave candidata alternativa não altera a validação até a 3FN: email determina os demais atributos de CLIENTE e é uma chave. Cliente.id continua sendo a chave primária escolhida.

Próximo passo: preparar o DDL MySQL com essas regras e definir sua forma de implementação. Sobreposição de assinaturas, vigência, disponibilidade e comparação de qualidade exigem validações além das FKs. Tamanhos dos campos e versão do MySQL de avaliação ainda serão definidos/conferidos; convenção exata dos limites dos intervalos de vigência será explicitada na implementação. Demais ambiguidades das consultas registradas no conceitual permanecem pendentes.

---


# Atualização — 15/11/2026, normalização até a 3FN

Este registro tem precedência sobre os estados históricos abaixo.

- Análise de 1FN, 2FN e 3FN concluída em [docs/modelo-relacional.md](docs/modelo-relacional.md), junto ao esquema textual.
- Base: 06 - As Formas Normais.pdf do professor, páginas 3–12. Registradas dependências funcionais das 11 relações, chaves simples e compostas, premissas e justificativas.
- Resultado: as 11 relações atendem à 3FN sob as dependências documentadas. Não foi necessária decomposição adicional nem alteração estrutural do desenho.
- Premissas: uma produtora e um idioma original por filme; nome de região não globalmente único; avaliação e favorito atuais por par cliente/filme. Eventual email obrigatório e único será chave candidata alternativa. Mudanças nessas regras exigem reavaliar a análise.
- Imagem dos modelos enviada pelo aluno, conforme informado nesta sessão.
- Próximo passo: consolidar domínios e regras pendentes do conceitual, definir restrições e produzir o DDL MySQL. Normalização não substitui essas validações.
- Banco, gerador e consultas ainda não implementados.

---


# Atualização — 15/11/2026, esquema relacional

Este registro tem precedência sobre os estados históricos abaixo.

- Esquema relacional em texto publicado em [docs/modelo-relacional.md](docs/modelo-relacional.md), com 11 relações, PKs simples e compostas, 13 referências de FKs e justificativa do mapeamento 1:N e N:N.
- Conferidos os atributos e as chaves com o modelo lógico revisado no brModelo. Qualidade é textual, ano de lançamento é inteiro e quantidade de dispositivos permanece em Plano.
- Valor mensal será DECIMAL(10,2) no DDL MySQL; FLOAT no desenho decorre das opções disponíveis no editor.
- A imagem conceitual já existe em docs/image.png. O aluno adicionará a imagem do modelo relacional em docs. PDFs permanecem fora do repositório.
- Publicação realizada pela interface web do GitHub: a integração recusou gravação com HTTP 403 e o Git no terminal falhou por rede.
- Próximo passo: revisar dependências funcionais e justificar 1FN, 2FN e 3FN, consolidar domínios e regras pendentes do conceitual e então produzir o DDL MySQL.
- Banco, gerador, consultas SQL e aplicação ainda não implementados. A normalização ainda não foi concluída.

---


# Estado do projeto

## Estado atual — 15/11/2026, após revisão do modelo

- Modelo conceitual revisado: Cliente possui 1 a N assinaturas; Plano tem id, nome e valor mensal; Avalia tem nota e data.
- Referência atual: docs/modelo-conceitual.md, com atributos, cardinalidades, representação Mermaid, cobertura das dez consultas e regras ainda propostas.
- A imagem original permanece no chat e ainda precisa ser incorporada ao repositório. Os PDFs ficam fora do GitHub por preferência do aluno.
- Repositório clonado e autenticado neste computador pelo GitHub Desktop, na branch main acompanhando origin/main.
- Pasta atual: C:\Users\Caio\Documents\Codex\2026-11-15\new-chat\repo\sistema-de-streaming. Usar esta cópia Git para continuar, em vez da cópia anterior em work/sistema-de-streaming.
- A integração GitHub recusou gravação com HTTP 403; o Git do terminal apresentou falha de rede. A clonagem pelo Desktop funcionou; usar o Desktop para enviar e verificar os commits.
- Próxima etapa: esquema relacional em texto e normalização até a 3FN. Consolidar regras propostas de vigência, unicidade, residência e interpretação das consultas antes do DDL MySQL.
- Ainda não há esquema relacional, banco ou aplicação implementados.

Os registros abaixo preservam o histórico anterior à revisão e à clonagem neste computador; o estado atual acima tem precedência.

Atualizado em 15/11/2026.

## Concluído

- Dois enunciados acadêmicos lidos no computador original.
- Roteiro, calendário e organização dos chats registrados em ROTEIRO.md.
- Base inicial recebida do Claude: plano, usuário, filme, região, sessão, gênero e assinatura; favoritos e avaliações como relacionamentos com atributos.
- Preparados arquivos de orientação para alternar entre computadores.
- Repositório privado criado e primeiro commit enviado ao GitHub: https://github.com/caiowp1/sistema-de-streaming.
- Branch main configurada para acompanhar origin/main; primeiro commit e4415ac.

## Em andamento

- Repositório Git local inicializado na branch main; gravações em .git exigem autorização do ambiente.
- Conector GitHub conectado, mas acesso ao novo repositório ainda não confirmado (consulta retornou 404). Envio pelo Git funcionou.
- Pasta ativa em 15/11: C:\Users\caioc\Documents\ChatGPT\sistema de streaming. Os seis arquivos de orientação foram copiados da pasta anterior, preservando os originais.

## Próximas ações

1. Clonar o repositório no computador principal e abrir a pasta no Codex.
2. Completar atributos, cardinalidades e regras de negócio; ver pendências em ROTEIRO.md.

## Contexto necessário

Execução técnica planejada como individual; possível ajuda de colega no vídeo. Aluno fez curso introdutório de SQL; nenhuma linguagem para o gerador escolhida. Arquivos PDF do enunciado permanecem em Downloads no computador original e ainda não foram copiados para este repositório. O histórico completo do Claude não foi recuperado; decisões recebidas estão no roteiro. Chats do Codex não são incluídos pelo Git.
