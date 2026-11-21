# Manual de execução do gerador e das consultas

O programa lê os CSV de `seeds/`, gera dados fictícios e os insere no MySQL. O catálogo contém 500 filmes sintéticos. A referência da carga é 19/11/2026 e a semente numérica é 10, definidas em `scripts/configuracao.py`. Para reproduzir a carga, mantenha os mesmos arquivos, versões, parâmetros e ambiente Python.

## 1. Requisitos no Linux

Tenha Python 3 com suporte a `venv` e `pip`, MySQL 8 e o cliente de linha de comando `mysql`. A execução anterior registrada usou MySQL 8.0.46 e Python 3.14; as dependências Python estão em `requirements.txt`. É necessário acesso a uma instância MySQL em `127.0.0.1:3306`, com um usuário que possa criar o banco e suas tabelas e inserir dados.

Abra um terminal na pasta do projeto, onde ficam `requirements.txt`, `scripts/` e `sql/`. Se o projeto estiver em outro local, use `cd` para acessá-lo. Os comandos abaixo são executados nessa pasta.

Crie um ambiente virtual **no Linux** e instale as dependências:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

O ambiente virtual não é transferido pelo Git; crie-o em cada computador. Se já existir um ambiente de outro sistema na pasta, use outra pasta para o ambiente Linux e ajuste os caminhos dos comandos.

## 2. Criar o banco vazio

O arquivo `sql/criacao.sql` cria o banco `sistema_streaming` e 11 tabelas. Confira antes se esse banco já existe; o script não o apaga nem o substitui:

```bash
mysql -h 127.0.0.1 -P 3306 -u USUARIO -p -e "SHOW DATABASES LIKE 'sistema_streaming';"
```

Substitua `USUARIO` pelo usuário MySQL e informe a senha quando solicitada. Se o banco já existir, preserve-o e escolha uma instância de teste vazia ou adapte uma cópia do script para outro nome; não apague dados existentes. Para criar o banco quando o nome estiver livre:

```bash
mysql -h 127.0.0.1 -P 3306 -u USUARIO -p < sql/criacao.sql
```

Confira as tabelas e seus mecanismos:

```bash
mysql -h 127.0.0.1 -P 3306 -u USUARIO -p -e "SHOW TABLE STATUS FROM sistema_streaming;"
```

Devem existir 11 tabelas e todas devem usar `InnoDB`, necessário para o rollback da carga. O usuário deve conseguir conectar por TCP com senha; uma conta configurada apenas para autenticação por socket precisa de configuração apropriada no MySQL.

## 3. Gerar e carregar

Com as 11 tabelas vazias, execute:

```bash
.venv/bin/python scripts/carga_mysql.py --clientes 1000 --sessoes 50000
```

Digite o usuário e a senha MySQL quando solicitados. A senha não aparece ao digitar; não a coloque em comandos ou arquivos. O programa conecta em `127.0.0.1:3306` e usa `sistema_streaming` por padrão. Para outro banco já criado com as mesmas tabelas, acrescente `--banco NOME`.

A carga termina com `Carga concluída` e informa contagens e tempos. O programa exige tabelas vazias, faz uma transação e executa rollback em caso de erro. Não execute duas cargas simultâneas. Sem os parâmetros de volume, gera 20 clientes e 150 sessões. Consulte outras opções com:

```bash
.venv/bin/python scripts/carga_mysql.py --help
```

No Windows, use `.\.venv\Scripts\python.exe` no lugar de `.venv/bin/python`.

## 4. Verificar a carga

Confira o volume diretamente no banco:

```bash
mysql -h 127.0.0.1 -P 3306 -u USUARIO -p sistema_streaming -e "SELECT (SELECT COUNT(*) FROM filme) AS filmes, (SELECT COUNT(*) FROM cliente) AS clientes, (SELECT COUNT(*) FROM sessao) AS sessoes;"
```

Para a carga ampliada, o esperado é 500 filmes, 1.000 clientes e 50.000 sessões. Execute as 12 verificações selecionando o banco na conexão:

```bash
mysql -h 127.0.0.1 -P 3306 -u USUARIO -p sistema_streaming < sql/verificacao_carga.sql
```

Cada contagem de problemas deve ser zero. A referência do SQL deve corresponder a `DATA_REFERENCIA` em `scripts/configuracao.py`. Se houver erro ou contagem diferente, examine o resultado antes de continuar. Essas verificações de integridade não comprovam, por si só, a correção das consultas.

## 5. Executar as consultas

Abra `sql/consultas.sql` em um editor ou no Workbench. Ajuste os filtros indicados nos comentários: IDs de região, gênero, e-mail e datas. Para encontrar valores existentes, conecte ao banco e execute, por exemplo:

```sql
SELECT * FROM regiao;
SELECT * FROM genero;
SELECT nome_completo, email FROM cliente LIMIT 10;
```

No Workbench, selecione `sistema_streaming` e execute cada consulta separadamente. No terminal, abra uma sessão com `mysql -h 127.0.0.1 -P 3306 -u USUARIO -p sistema_streaming` e cole a consulta desejada. O e-mail de exemplo não corresponde necessariamente a um cliente cadastrado.

As consultas 7, 8 e 10 usam a referência demonstrativa de 19/11/2026. Último mês significa o mês civil anterior completo; último trimestre, os três meses civis anteriores completos. Ajuste todas as ocorrências da referência na consulta quando necessário. A consulta 5 conta sessões globais dos filmes disponíveis na região; a 8 conta sessões de clientes residentes na região.

## Situação da verificação

Este procedimento está documentado, mas ainda precisa ser reproduzido integralmente em Linux. As dez consultas também precisam ser executadas e conferidas com resultados conhecidos e na carga ampliada.
