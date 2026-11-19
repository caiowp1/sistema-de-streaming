# Manual do gerador

O gerador lê os arquivos CSV de `seeds/`, cria dados fictícios em memória e os
insere no MySQL. O catálogo contém 500 filmes sintéticos; as sinopses dos
filmes adicionais seguem fórmulas repetidas. Configuração inicial: 20 clientes,
150 sessões, semente 10 e referência 19/11/2026. A data e a semente ficam em
`scripts/configuracao.py`. Para reproduzir uma carga, mantenha as mesmas
versões, arquivos de sementes, parâmetros e ambiente Python.

## Preparação no Linux

Com Python 3, pip e MySQL instalados, na pasta do projeto:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

Execute `sql/criacao.sql` em uma instância MySQL. Ele cria o banco
`sistema_streaming`; esse nome não pode existir previamente. Use uma instância
ou banco vazio e preserve dados já existentes. As tabelas precisam usar InnoDB
para o rollback da carga funcionar.

## Gerar e carregar

Com o MySQL disponível em `127.0.0.1:3306`:

```bash
.venv/bin/python scripts/carga_mysql.py --clientes 1000 --sessoes 50000
```

No Windows, substitua `.venv/bin/python` por `.\.venv\Scripts\python.exe`.
O programa pergunta usuário e senha no terminal; não grave a senha nos arquivos.
Use `--banco NOME` para um banco já criado com as mesmas 11 tabelas. A carga
exige todas as tabelas vazias; se alguma contiver registros, é interrompida.
Não execute cargas concorrentes nesse banco. Os parâmetros `--clientes` e
`--sessoes` são opcionais. Veja todos com `--help`.

As tabelas são inseridas em ordem de dependência. Os IDs gerados pelo MySQL são
usados nas referências; se houver erro na inserção, a transação é desfeita.
A execução informa contagens e tempos. Em `scripts/gerador.py`, é possível
gerar e inspecionar uma amostra em memória sem conexão com o banco.

## Verificar

Selecione explicitamente o banco carregado no Workbench e execute todo o
`sql/verificacao_carga.sql`. As contagens de problemas devem ser zero; a data
de referência do SQL deve ser igual à de `scripts/configuracao.py`. Para
conferir o volume, por exemplo:

```sql
SELECT (SELECT COUNT(*) FROM cliente) AS clientes,
       (SELECT COUNT(*) FROM filme) AS filmes,
       (SELECT COUNT(*) FROM sessao) AS sessoes;
```

Essas verificações não substituem a conferência dos resultados das consultas.
O procedimento Linux ainda precisa ser executado integralmente nesse ambiente.
