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
