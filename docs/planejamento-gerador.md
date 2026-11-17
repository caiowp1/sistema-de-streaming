# Planejamento do gerador — 17/11/2026

## Base e estado das decisões

Enunciados relidos integralmente (duas páginas cada): descrição do problema e descrição da entrega, fornecidos pelo aluno em 17/11. PDFs permanecem fora do repositório conforme preferência registrada.

Confirmado nos enunciados: MySQL; linguagem do gerador livre; uso permitido de bibliotecas de terceiros e IA para dados; arquivos de texto semente; volume minimamente realista, sem número mínimo explícito; manual para Linux com MySQL instalado. Python/Faker, PHP/FakerPHP, Java/JavaFaker e JavaScript/Faker são sugestões do professor, não obrigações.

Este documento registra confirmação do aluno para histórico e propostas para os pontos ainda em discussão. Não indica que o gerador já foi implementado.

## Assinaturas — histórico confirmado

O aluno concorda com períodos sem sobreposição desde que a assinatura anterior seja preservada. Adotar início incluído e término excluído: inicio <= data e (termino IS NULL ou data < termino). Datas são DATE no esquema atual, portanto mudanças ocorrem na fronteira de um dia.

Ao trocar de plano em 10/11: preencher data_termino da assinatura anterior com 10/11 e inserir outra com data_inicio = 10/11, novo id e novo plano. Não excluir o registro anterior nem substituir seu id_plano. Períodos encerrados permanecem consultáveis. Retorno a um plano antigo gera outra assinatura. O gerador deve produzir esse histórico e conferir ausência de sobreposição; o DDL atual não garante essa regra entre linhas.

## Região nas consultas

Interpretação proposta pelo aluno para a consulta 5 e adotada como hipótese documentada: Y filtra o catálogo (FILME_REGIAO); contar todas as sessões desses filmes no mês informado, independentemente da residência do cliente. Incluir filmes disponíveis com zero sessões. Não afirmar que o enunciado elimina toda ambiguidade: confirmar com o professor se houver orientação adicional.

Consulta 8 é diferente: filtrar consumo de clientes residentes em Y e ordenar minutos, depois quantidade de sessões. País é atributo da região e não define, por si só, se o consumo é global. Residência permanece fixa no escopo.

## Tempo — proposta para validação

Usar uma data de referência única, explícita e compartilhada entre geração, consultas e verificações. Em uso normal, a data atual; na demonstração reproduzível, uma data configurada e registrada no resumo da carga.

A sugestão do aluno de usar o último registro pode servir para escolher essa data de demonstração, derivando uma vez da maior data de sessão da carga completa. Não calcular datas máximas por cliente, filme, filtro ou tabela em cada consulta; isso mudaria o período comparado. Não usar id ou ordem de inserção como substitutos da data do evento. Em tabela vazia, exigir referência explícita ou usar data atual, documentando a escolha.

Derivar a referência da carga deve ser identificado como relógio da demonstração, não como definição obrigatória de “último mês” pelo professor. Preferência de implementação: receber referência explícita no gerador e reutilizá-la nas consultas; assim até clientes inativos são avaliados no mesmo instante.

Proposta ainda a consolidar: último mês = mês civil anterior completo; último trimestre = três meses civis anteriores completos (janela móvel mensal), distinguindo de trimestre civil anterior e de últimos 90 dias. Exemplo com referência 17/11/2026: mês [01/10/2026, 01/11/2026); três meses [01/08/2026, 01/11/2026). Expor limites nas consultas e no manual.

## Linguagem e ferramentas — recomendação, ainda não confirmada pelo aluno

Python + Faker + MySQL Connector/Python. Faker para dados pessoais fictícios e localizados; arquivos de texto CSV/JSON para regiões, gêneros, planos e metadados de filmes; lógica Python para relações e cronologia. O conector insere os dados no MySQL com parâmetros e transação. Não é necessário introduzir ORM.

Referências oficiais:

- https://faker.readthedocs.io/en/master/
- https://dev.mysql.com/doc/connector-python/en/quick-installation-guide.html

Arquivos semente contêm dados-base; semente numérica controla a aleatoriedade. São coisas distintas. Fixar versões das dependências e parâmetros para repetir a carga.

## Escala inicial proposta

Proposta de demonstração acadêmica, não mínimo exigido nem tentativa de reproduzir volume de produção global: 3 planos, aproximadamente 12 gêneros, 10 regiões em 5 países, 500 filmes, 1.000 clientes e 50.000 sessões distribuídas em 12 meses. Assinaturas, favoritos e avaliações variam conforme os perfis. Escala configurável; complementar com um conjunto pequeno de resultados conhecidos.

## Realismo e verificações

- Cadastro anterior ou igual ao início da primeira assinatura; sessões na vigência de assinatura, antes da data de referência e não anteriores ao lançamento do filme.
- Clientes têm uma ou mais assinaturas históricas; incluir ativos, inativos, trocas e retorno a plano anterior, sem apagar histórico.
- Selecionar filmes disponíveis na região do cliente e qualidade dentro do limite do plano vigente; respeitar limite simultâneo quando houver sessões sobrepostas, ou gerar agenda sem sobreposição por cliente como simplificação explícita.
- Duração positiva, com visualizações completas e parciais; nessa carga cada sessão terá no máximo a duração do filme, e reassistidas serão novas sessões.
- Cada filme tem pelo menos um gênero e uma região; nem todos os filmes disponíveis em todas as regiões. Sessões não uniformes entre filmes, clientes e meses.
- Metadados coerentes nos filmes; evitar que títulos e sinopses sejam apenas palavras aleatórias sem sentido.
- Clientes sem favoritos/avaliações; pares únicos; favoritos e avaliações datados a partir do cadastro. Avaliações seguem a escala 1–5; não assumir obrigação de assistir antes de avaliar, pois essa regra não está no enunciado.
- Incluir filmes sem sessões no período, filmes sem avaliações, média abaixo/igual/acima de 4, zero consumo em regiões/períodos e empates no ranking.
- Verificar dados após inserção: integridade, cronologia, vigência, disponibilidade, qualidade, sobreposição e cobertura das consultas. Gerar resumo de contagens e parâmetros utilizados.

## Próximo passo

Consolidar convenções de tempo, linguagem e escala; preparar sementes e implementar o gerador por etapas, primeiro cadastros e depois histórico e consumo. Não há gerador nem dependências instaladas por este planejamento. O script DDL com chaves reordenadas ainda precisa ser verificado no MySQL em banco de teste separado ou vazio, sem descartar dados existentes.
