# Roteiro do projeto

Atualizado em 19/11/2026. Planejamento de execução técnica individual, com possível apoio de colega no vídeo ainda a confirmar. Entrega em **02/12/2026 às 23h55**, com meta interna de conclusão em **30/11**.

O andamento verificado está em [STATUS.md](STATUS.md). A visão geral, regras de escopo e sincronização estão em [README.md](README.md). Este arquivo concentra metas e pendências, sem repetir os modelos ou o manual.

## Calendário original

| Período | Meta | Situação em 19/11 |
| --- | --- | --- |
| 13–16/11 | Modelo conceitual | Concluído |
| 17–20/11 | Esquema relacional, normalização e DDL | Implementados e testados |
| 21–24/11 | Gerador e primeiras consultas | Gerador implementado; consultas e cenários controlados pendentes |
| 25–27/11 | Dez consultas e verificação integrada | Pendente |
| 28–30/11 | PDF, pacote, ensaio e vídeo | Manual escrito; fechamento pendente |
| 01–02/12 | Reserva, correções e envio | Preservar essa margem |

## Checklist acadêmico

- [x] Modelo ER/EER com atributos e cardinalidades — 3,5 pontos.
- [x] Esquema relacional textual e justificativa da 1FN, 2FN e 3FN — 1,5 ponto.
- [x] DDL MySQL coerente com o esquema e verificações iniciais — 1,5 ponto.
- [x] Programa de geração/carga, arquivos semente e execução de volume no MySQL.
- [x] Manual do gerador escrito.
- [ ] Reproduzir integralmente criação, carga e verificações em Linux para concluir a verificação do procedimento do gerador — componente de 1,5 ponto.
- [ ] Implementar e validar as dez consultas obrigatórias — 2 pontos.
- [ ] Consolidar PDF com diagrama ER/EER, esquema relacional em texto, SQL de criação do banco vazio, consultas e manual.
- [ ] Preparar pacote tgz com fontes, dependências declaradas e arquivos semente. O fechamento do enunciado também aceita zip.
- [ ] Gravar vídeo de até cinco minutos: modelo, banco vazio, programa, carga, tabelas preenchidas e consultas.
- [ ] Conferir pacote e acesso ao vídeo; enviar PDF, fontes e link no Colabweb antes do prazo.

Os itens marcados registram artefatos produzidos e verificações documentadas; não representam nota garantida. Linguagem do gerador é livre, bibliotecas e IA para dados são permitidas; MySQL e dados minimamente realistas são requisitos do enunciado. PDFs originais permanecem fora do Git por preferência do aluno.

## Próxima etapa: consultas e cenários controlados

1. Períodos adotados: último mês = mês civil anterior completo; último trimestre = três meses civis anteriores completos. Com referência em 19/11/2026: outubro e agosto–outubro, respectivamente. A referência da demonstração deve ser ajustada para outros usos.
2. Na consulta 7, plano sem clientes ativos retorna contagem zero e média NULL. O máximo de dispositivos é propriedade fixa do plano; preço e limites não têm versionamento histórico.
3. Consultas escritas com filtros editáveis; verificar resultados e explicar cada linha. Interpretações regionais das consultas 5 e 8 estão no README.
4. Preparar dados pequenos com resultados conhecidos, em banco de teste separado: zero sessões, zero avaliações, média abaixo/igual/acima de 4, múltiplos gêneros, reassistidas, empates, clientes inativos, trocas/retorno de plano e fronteiras de datas.
5. Comparar respostas esperadas com o MySQL e executar as consultas na carga ampliada. Integridade da carga não substitui correção dos resultados.

## Organização e aprendizagem

Manter chats por entrega: coordenação, modelagem, lógico/DDL, população, consultas e fechamento. Os arquivos são a referência compartilhada; cada etapa termina com decisões, verificações e próximo passo no status. Histórico de edições pode ser consultado pelo Git.

O aluno iniciou com SQL básico (filtros, joins, inserções e atualizações). Explicar agregações, GROUP BY/HAVING, datas, subconsultas e funções de janela conforme aparecerem nas consultas, com exemplos pequenos. Não exigir um curso completo antes de avançar.

## Após a entrega: portfólio

Evoluir para catálogo regional, detalhes de filmes, favoritos, avaliações, histórico de consumo e planos, com painel de estatísticas. API, interface, autenticação e hospedagem serão escolhidas nessa fase. Consumo pode ser demonstrativo; reprodução real, cobrança e recomendação avançada exigem avaliação posterior de escopo. Usar material autorizado caso haja vídeo.
