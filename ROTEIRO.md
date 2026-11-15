# Sistema de streaming — roteiro do projeto

## Objetivo

Entregar o trabalho de Banco de Dados com uma base verificável e evoluí-la para uma aplicação de portfólio. Primeiro consolidar o domínio, implementar o banco MySQL e demonstrar sua correção; depois construir os fluxos de produto sobre a mesma base.

Estado em 13/11/2026: planejamento inicial. Entrega em 02/12/2026 (quarta-feira), às 23h55, conforme informado pelo aluno; fuso de referência America/Manaus. Planejar execução técnica individual. Possível apoio de colega no vídeo, ainda não confirmado. Nenhuma implementação foi iniciada por este roteiro.

Conhecimento informado: curso introdutório de SQL de três horas, cobrindo SELECT, filtros, ordenação, joins, unions, inserções, atualizações e uso de subconsultas em atualizações. Não presumir domínio dos tópicos apenas por terem sido vistos. Nenhuma linguagem de programação escolhida até aqui.

## Calendário proposto e aprendizagem

Datas são metas de planejamento, sujeitas à disponibilidade diária do aluno. Meta interna: material pronto em 30/11, com 01/12 e 02/12 reservados para correções e envio.

| Período | Foco | Resultado verificável |
| --- | --- | --- |
| 13 a 16/11 | Requisitos e modelo conceitual | Atributos, cardinalidades, regras e diagrama consolidados |
| 17 a 20/11 | Modelo lógico, normalização e DDL | Banco vazio criado no MySQL e coerente com o esquema |
| 21 a 24/11 | Gerador e consultas iniciais | Carga reproduzível e cenários pequenos com respostas conhecidas |
| 25 a 27/11 | Dez consultas e verificação integrada | Consultas corretas, parâmetros e casos de borda documentados |
| 28 a 30/11 | Documentação, ensaio e vídeo | PDF, fontes, manual e vídeo prontos |
| 01 a 02/12 | Reserva e entrega | Revisão final e envio antes das 23h55 de 02/12 |

Documentar cada etapa ao executá-la; o período final serve para consolidar e revisar. Iniciar o contato com o colega responsável pelo vídeo antes da semana final e fornecer roteiro, comandos e resultados esperados. Até confirmar esse apoio, reservar tempo para gravação pelo próprio aluno.

Estudo associado às entregas:

- Modelagem: cardinalidades, identificadores e regras de negócio.
- Esquema e DDL: dependências funcionais, 1FN/2FN/3FN, tipos, PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL e CHECK.
- Consultas: COUNT, SUM, AVG, GROUP BY, HAVING, tratamento de NULL, datas, EXISTS/NOT EXISTS, subconsultas e comparação entre registros do histórico. CTEs e funções de janela entram quando ajudarem a expressar as consultas.
- Gerador: aprender apenas os fundamentos necessários da linguagem escolhida, leitura de arquivos, funções, geração controlada de dados e conexão com MySQL.

Abordagem didática: explicar a regra, construir um exemplo pequeno, pedir ao aluno que interprete o resultado e então ampliar. Garantir que o aluno consiga explicar o código e as escolhas. Evitar exigir um curso completo de linguagem antes de produzir os artefatos.

Aplicação de portfólio: iniciar a implementação após a entrega acadêmica. Até lá, preservar organização e decisões que facilitem essa evolução. Não incluir API/interface como dependência da entrega de 02/12.

## Fontes e contexto recuperado

- Descrição do problema: PDF fornecido, duas páginas, com domínio e dez consultas obrigatórias.
- Descrição do trabalho: PDF fornecido, duas páginas, com metodologia, pesos e entrega.
- Claude: chat “Roteiro de projeto” lido pela interface. Acesso ao restante do projeto falhou na navegação.
- Claude: trecho do chat “modelagem” fornecido pelo aluno, com as decisões recentes. Mensagens anteriores e memória do projeto ainda não foram recuperadas.

Os enunciados estabelecem os requisitos acadêmicos. Sugestões anteriores do Claude e decisões deste roteiro são propostas de execução, não exigências adicionais do professor.

## Requisitos acadêmicos confirmados

| Entrega técnica | Peso | Critério para concluir |
| --- | --- | --- |
| Modelo ER/EER | 3,5 | Diagrama com entidades, atributos, identificadores, relacionamentos e cardinalidades; cobertura do domínio e das dez consultas |
| Esquema relacional | 1,5 | Texto das relações, chaves e justificativa da 1FN, 2FN e 3FN |
| Implementação no SGBD | 1,5 | MySQL; criação do banco vazio coerente com o esquema relacional |
| Programa de população | 1,5 | Programa/scripts em linguagem de programação, dados sintéticos minimamente realistas e arquivos de texto semente |
| Consultas | 2,0 | Dez consultas em SQL do SGBD, executadas sobre os dados gerados |

Entregáveis finais: PDF com diagrama, esquema relacional em texto, SQL de criação do banco vazio, consultas e manual do gerador; pacote de fontes (o documento menciona tgz e, no fechamento, tgz/zip); link de vídeo de até cinco minutos. Adotar tgz atende às duas passagens. Manual deve considerar Linux com MySQL instalado e configurado de forma padrão.

O vídeo deve mostrar: modelo, banco criado e vazio, explicação breve do gerador, execução da carga, tabelas preenchidas e execução das consultas. A data de entrega está no Colabweb e não foi informada nos PDFs. Equipe: no máximo três pessoas. Não foi fixado um número de registros: definir escala justificável pelo domínio e documentá-la.

## Organização dos chats

Este chat funciona como coordenação e roteiro. Preservar o chat de modelagem e os quatro chats técnicos propostos no Claude. Não criar todos antecipadamente; abrir cada um quando houver entrada suficiente.

| Chat | Entrada | Saída | Condição de passagem |
| --- | --- | --- | --- |
| Coordenação / roteiro | Enunciados, situação atual, prazo | Este roteiro, decisões, pendências e prioridades | Atualizar ao concluir marcos |
| Modelagem | Enunciados e modelo inicial | MER/EER, atributos, cardinalidades, regras e dicionário de dados | Explicar como o modelo responde às dez consultas |
| Modelo lógico + DDL | Modelo conceitual consolidado | Relações em texto, normalização e SQL de criação | Criar banco vazio e conferir chaves/restrições |
| Popular o banco | DDL e cenários exigidos pelas consultas | Gerador, sementes textuais, parâmetros e manual | Carga válida, reproduzível e com cobertura dos cenários |
| Consultas SQL | Esquema, dados e interpretação das perguntas | Dez consultas, parâmetros e evidências de resultado | Comparar com resultados conhecidos e validar limites |
| Fechamento | Artefatos técnicos validados | PDF, pacote, roteiro do vídeo e revisão da entrega | Reproduzir o procedimento documentado em Linux |

Na fase de portfólio, abrir os chats Produto/API e Interface/Demonstração quando os respectivos escopos estiverem definidos. A quantidade pode ser ajustada pela complexidade.

## Como preservar contexto entre chats

Os arquivos do projeto serão a referência comum. Cada chat deve começar lendo o roteiro, as decisões registradas e os artefatos de entrada. Não presumir que o histórico de outro chat esteja disponível.

Cada encerramento de etapa registra: o que foi concluído, arquivos produzidos, verificações realizadas, decisões tomadas, pendências e próximo passo. Mudanças em nomes, chaves ou regras precisam atualizar os artefatos afetados antes da passagem.

Estrutura sugerida para a implementação futura:

```text
ROTEIRO.md
docs/          requisitos, decisões, dicionário, modelos e relatório
sql/           criação do banco e consultas separadas
scripts/       gerador e comandos auxiliares
seeds/         arquivos de texto usados pelo gerador
tests/         cenários controlados e verificações de integridade/consultas
app/           aplicação da fase de portfólio
```

## Estado da modelagem e pendências

Base recebida: plano, usuário, filme, região, sessão, gênero e assinatura. Relacionamentos: usuário realiza assinatura; assinatura se refere a plano; usuário inicia sessão; sessão exibe filme; filme pertence a gênero; usuário favorita filme; usuário avalia filme; usuário pertence a região; filme está disponível em região.

Essa base é um ponto de partida, não um diagrama final validado. Resolver no chat de modelagem:

1. Atributos, identificadores e cardinalidades mínimas e máximas de cada relação.
2. Favorito: data obrigatória para consulta 2 e no máximo um registro por usuário/filme. Avaliação: nota e unicidade do par, preservando alteração da nota. Relacionamentos com atributos ou entidades associativas podem representar esses fatos; não é obrigatório que os dois tenham a mesma representação gráfica.
3. Assinatura: períodos, significado de término ausente, troca de plano, eventual retorno ao mesmo plano e regra sobre períodos sobrepostos.
4. Sessão: um usuário e um filme por evento, início, duração em minutos, dispositivo e qualidade efetivamente utilizada. Reassistir deve gerar outra sessão.
5. País e região: definir o significado geográfico e sua relação, evitando duplicação contraditória.
6. Gênero: decidir se cada filme tem um ou vários; documentar efeito nas somas por gênero.
7. Separar disponibilidade regional do catálogo de consumo regional. Na consulta 5, esclarecer se o consumo é global dos títulos disponíveis em Y ou apenas de clientes de Y; na 8, explicitar como determinar a região do consumo. Mudanças de residência exigiriam decisão adicional caso se queira preservar localização histórica.
8. Definir “ativo”, “último mês” e “último trimestre”; usar data de referência controlada nos testes para a demonstração não depender do dia de execução.
9. Consulta 7: esclarecer a média solicitada, pois o máximo de dispositivos é uma propriedade do plano e tende a ser constante dentro de cada grupo de plano.

## Sequência de execução

1. Recuperar contexto relevante restante e levantar requisitos e ambiguidades; prazo e execução individual já informados.
2. Finalizar o modelo conceitual e documentar as hipóteses adotadas.
3. Produzir esquema relacional e DDL coerentes. Escolher a versão do MySQL considerando o ambiente de avaliação.
4. Criar um conjunto pequeno de dados com respostas conhecidas; desenvolver o gerador com escala configurável e geração reproduzível. Semente aleatória e arquivos textuais semente têm funções distintas; prever ambos.
5. Implementar consultas e validar resultados, inclusive zeros, ausência de avaliações, reassistidas, mudanças de plano, limites de datas e empates do ranking.
6. Executar o procedimento de criação, carga e consultas a partir do manual; revisar entrega acadêmica e produzir os materiais finais.
7. Consolidar uma versão acadêmica identificável antes de evoluir funcionalidades de produto.

## Evolução para portfólio — proposta inicial

Direção: aplicação de catálogo e análise de consumo. Reutilizar as regras e consultas para demonstrar decisões reais de engenharia de dados e produto.

Primeira versão navegável:

- Consultar catálogo por região e gênero, abrir detalhes do filme.
- Adicionar/remover favoritos e criar/alterar avaliação.
- Consultar sessões e histórico de consumo; registrar sessões demonstrativas.
- Mostrar plano e histórico de mudanças.
- Exibir painel com ranking regional, horas por gênero e distribuição de qualidade.

Reprodução real de vídeo, cobrança e recomendação avançada ficam para uma avaliação posterior de escopo. O primeiro marco usa consumo simulado identificado como tal. Caso se inclua vídeo, usar material autorizado.

Qualidade demonstrável: documentação das escolhas, integridade no banco, fluxos de API com validação e transações onde necessárias, testes das regras centrais, execução reproduzível e apresentação pública do projeto com imagens e demonstração. Medir consultas e justificar índices conforme os dados e acessos implementados.

Stack de API/interface, autenticação, hospedagem e ferramentas serão escolhidas depois de conhecer experiência, objetivo de aprendizado e prazo. O MySQL já está determinado pelo trabalho. Não construir a aplicação nesta etapa de planejamento.

## Próxima ação

Completar o contexto da modelagem e iniciar a definição de atributos e cardinalidades. O restante do histórico pode ser anexado em texto ou PDF; priorizar decisões, justificativas e dúvidas que não aparecem no trecho já recebido. Disponibilidade diária ainda não informada; usar o calendário como meta inicial, sem presumir carga horária disponível.
