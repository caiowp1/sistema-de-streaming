# Estado do projeto

Atualizado em **21/11/2026**. Este arquivo resume o estado atual; registros detalhados anteriores estão no histórico do Git. Calendário e checklist em [ROTEIRO.md](ROTEIRO.md); regras de escopo e sincronização em [README.md](README.md).

## Concluído

- Modelo conceitual revisado, esquema textual com 11 relações e 13 referências de FKs e normalização até a 3FN documentados.
- DDL MySQL em sql/criacao.sql com 11 tabelas; ordem das PKs de AVALIA/FAVORITA alinhada ao esquema: (id_cliente, id_filme).
- Gerador Python dividido em configuração, leitura de sementes, catálogo, clientes/assinaturas, sessões, geração e carga MySQL. CSV de regiões, planos, gêneros e 500 filmes fictícios.
- Carga com conferência de tabelas vazias, mapeamento dos IDs efetivos, SQL parametrizado, commit e rollback. Senha solicitada no terminal.
- requirements.txt e docs/manual-gerador.md preparados. Ambiente registrado: Python 3.14; versões das bibliotecas em requirements.txt.
- Dez consultas escritas em sql/consultas.sql conforme o enunciado, com filtros editáveis e referência demonstrativa de 19/11/2026.
- Manual ampliado com instruções de criação, carga, verificações e consultas no Linux; consultas formatadas conforme o texto fornecido pelo aluno.

## Evidências registradas

As execuções MySQL abaixo foram realizadas pelo aluno no Workbench e registradas nas etapas anteriores; não foram repetidas nesta reorganização documental.

- MySQL 8.0.46: criação das 11 tabelas confirmada; CHECK rejeitou preço zero, qualidade inválida, nota 6 e término anterior ao início. FK, email único e PK composta rejeitaram os casos inválidos testados. Valores válidos, término NULL e AUTO_INCREMENT foram observados.
- Primeira carga de 20 clientes e 150 sessões: contagens das 11 tabelas conferidas no MySQL; 12 verificações retornaram zero problemas.
- Carga ampliada em sistema_streaming_catalogo: SELECT confirmou **500 filmes, 1.000 clientes e 50.000 sessões**. As 12 verificações executadas no banco retornaram zero problemas.
- Demais contagens da carga ampliada informadas pelo programa: 5 regiões, 3 planos, 8 gêneros, 508 associações filme-gênero, 1.518 filme-região, 1.333 assinaturas, 2.021 avaliações e 1.997 favoritos. Essas contagens não foram todas conferidas individualmente por SELECT.
- Nessa execução local: geração em 5,71 s e inserção/commit em 26,09 s; são medidas de uma execução, não benchmark comparativo.
- Após a organização do gerador, a geração em memória reproduziu as contagens e a inserção também foi verificada com conexão simulada.
- Após a reorganização, o aluno executou a carga real em sistema_streaming: o programa informou commit concluído, 500 filmes, 1.000 clientes e 50.000 sessões. SELECTs e verificações dessa nova carga ainda não foram confirmados nesta conversa.

## Limites e pendências

- O script atual de verificação exige seleção explícita do banco. Checa mínimos de associação, cronologia, sobreposição de assinaturas, vigência, disponibilidade, qualidade, duração e a regra de uma sessão por cliente/dia. Não prova cobertura de todas as consultas.
- Sobreposição de assinaturas, vigência/disponibilidade das sessões e comparação de qualidade não são garantidas pelo DDL: o gerador e as verificações cobrem essas regras no escopo adotado.
- Catálogo sintético com fórmulas narrativas repetidas; não contém obras reais. A geração aleatória não assegura por si só cenários de fronteira ou resultados conhecidos.
- Consultas ainda não executadas ou validadas em MySQL nesta etapa; faltam cenários controlados e execução na carga ampliada. Mês anterior e três meses anteriores são períodos civis completos; plano sem ativos retorna contagem zero e média NULL. A troca considera a assinatura imediatamente anterior, mesmo após intervalo, e exige planos diferentes. Preço e limite do plano não têm histórico.
- Procedimento completo do manual em Linux ainda não executado. PDF final, pacote de fontes e vídeo pendentes.
- Preservar os bancos existentes ao preparar testes; cópias antigas de scripts específicos de teste foram removidas. Usar sql/criacao.sql e sql/verificacao_carga.sql atuais.

## Próximo passo

Validar as dez consultas no MySQL com cenários pequenos de resultado conhecido e executar na carga ampliada; reproduzir o manual em Linux. Depois consolidar relatório, pacote e vídeo até a meta interna de 30/11.

## Verificação desta etapa

Consultas conferidas contra o texto fornecido pelo aluno; manual revisado contra os scripts existentes. Não houve nova execução das consultas, do gerador ou do MySQL. A tentativa de acessar WSL neste ambiente retornou acesso negado; a execução em Linux permanece pendente.
