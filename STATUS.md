# Estado do projeto

Atualizado em **19/11/2026**. Este arquivo resume o estado atual; registros detalhados anteriores estão no histórico do Git. Calendário e checklist em [ROTEIRO.md](ROTEIRO.md); regras de escopo e sincronização em [README.md](README.md).

## Concluído

- Modelo conceitual revisado, esquema textual com 11 relações e 13 referências de FKs e normalização até a 3FN documentados.
- DDL MySQL em sql/criacao.sql com 11 tabelas; ordem das PKs de AVALIA/FAVORITA alinhada ao esquema: (id_cliente, id_filme).
- Gerador Python dividido em configuração, leitura de sementes, catálogo, clientes/assinaturas, sessões, geração e carga MySQL. CSV de regiões, planos, gêneros e 500 filmes fictícios.
- Carga com conferência de tabelas vazias, mapeamento dos IDs efetivos, SQL parametrizado, commit e rollback. Senha solicitada no terminal.
- requirements.txt e docs/manual-gerador.md preparados. Ambiente registrado: Python 3.14; versões das bibliotecas em requirements.txt.

## Evidências registradas

As execuções MySQL abaixo foram realizadas pelo aluno no Workbench e registradas nas etapas anteriores; não foram repetidas nesta reorganização documental.

- MySQL 8.0.46: criação das 11 tabelas confirmada; CHECK rejeitou preço zero, qualidade inválida, nota 6 e término anterior ao início. FK, email único e PK composta rejeitaram os casos inválidos testados. Valores válidos, término NULL e AUTO_INCREMENT foram observados.
- Primeira carga de 20 clientes e 150 sessões: contagens das 11 tabelas conferidas no MySQL; 12 verificações retornaram zero problemas.
- Carga ampliada em sistema_streaming_catalogo: SELECT confirmou **500 filmes, 1.000 clientes e 50.000 sessões**. As 12 verificações executadas no banco retornaram zero problemas.
- Demais contagens da carga ampliada informadas pelo programa: 5 regiões, 3 planos, 8 gêneros, 508 associações filme-gênero, 1.518 filme-região, 1.333 assinaturas, 2.021 avaliações e 1.997 favoritos. Essas contagens não foram todas conferidas individualmente por SELECT.
- Nessa execução local: geração em 5,71 s e inserção/commit em 26,09 s; são medidas de uma execução, não benchmark comparativo.
- Após a organização do gerador, a geração em memória reproduziu as contagens e a inserção foi verificada com conexão simulada; a carga real não foi repetida após essa organização.

## Limites e pendências

- O script atual de verificação exige seleção explícita do banco. Checa mínimos de associação, cronologia, sobreposição de assinaturas, vigência, disponibilidade, qualidade, duração e a regra de uma sessão por cliente/dia. Não prova cobertura de todas as consultas.
- Sobreposição de assinaturas, vigência/disponibilidade das sessões e comparação de qualidade não são garantidas pelo DDL: o gerador e as verificações cobrem essas regras no escopo adotado.
- Catálogo sintético com fórmulas narrativas repetidas; não contém obras reais. A geração aleatória não assegura por si só cenários de fronteira ou resultados conhecidos.
- Dez consultas obrigatórias e cenários controlados ainda não implementados. Períodos relativos e resultado para plano sem ativos precisam ser consolidados na etapa de consultas.
- Procedimento completo do manual em Linux ainda não executado. PDF final, pacote de fontes e vídeo pendentes.
- Preservar os bancos existentes ao preparar testes; cópias antigas de scripts específicos de teste foram removidas. Usar sql/criacao.sql e sql/verificacao_carga.sql atuais.

## Próximo passo

Implementar as dez consultas com parâmetros e cenários pequenos de resultado conhecido; em paralelo, reproduzir o manual em Linux. Depois consolidar relatório, pacote e vídeo até a meta interna de 30/11.

## Organização documental desta etapa

README reúne visão geral, regras úteis do antigo planejamento e sincronização; ROTEIRO concentra calendário e checklist; STATUS guarda resultados e pendências atuais. SINCRONIZACAO.md e docs/planejamento-gerador.md foram incorporados e removidos. AGENTS.md orienta a manutenção desse formato. Modelos e manual preservados sem edição; código, sementes e banco não foram alterados.

Verificação desta etapa: referências locais dos Markdown válidas; git diff --check sem erros; modelos, imagens e manual idênticos à versão anterior. Não houve nova execução do gerador nem do MySQL nesta revisão documental.
