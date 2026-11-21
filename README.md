# Sistema de streaming

Projeto de banco de dados para uma plataforma de streaming de filmes. O repositório contém a modelagem, a criação do banco MySQL, um gerador de dados fictícios e consultas para explorar catálogo, assinaturas e consumo.

## Funcionalidades

- Cadastro de clientes, regiões, filmes, gêneros e planos.
- Catálogo com disponibilidade de filmes por região.
- Histórico de assinaturas e mudanças de plano.
- Registro de sessões de visualização, favoritos e avaliações.
- Consultas de consumo, preferências, avaliações e planos.
- Geração e carga transacional de dados de exemplo.

O projeto reúne o banco de dados e suas ferramentas de carga e consulta; não inclui uma aplicação de reprodução de vídeo.

## Tecnologias e requisitos

- MySQL 8; criação e carga já executadas com MySQL 8.0.46.
- Python 3 com `venv` e `pip`; ambiente de referência com Python 3.14.
- Dependências Python listadas em [requirements.txt](requirements.txt).

## Estrutura

| Caminho | Conteúdo |
| --- | --- |
| [docs/modelo-conceitual.md](docs/modelo-conceitual.md) | Entidades, relacionamentos e cardinalidades |
| [docs/modelo-relacional.md](docs/modelo-relacional.md) | Esquema relacional e normalização |
| [docs/manual-gerador.md](docs/manual-gerador.md) | Instruções detalhadas de instalação, carga e consultas |
| [sql/criacao.sql](sql/criacao.sql) | Criação do banco e das 11 tabelas |
| [sql/consultas.sql](sql/consultas.sql) | Consultas com filtros ajustáveis |
| [sql/verificacao_carga.sql](sql/verificacao_carga.sql) | Verificações de integridade da carga |
| `scripts/` | Gerador de dados e carga no MySQL |
| `seeds/` | CSV de regiões, planos, gêneros e filmes fictícios |

## Como executar

Crie um ambiente virtual Python, instale as dependências e execute `sql/criacao.sql` no MySQL para criar o banco vazio `sistema_streaming`. Em seguida, execute o gerador a partir da pasta do projeto:

```bash
.venv/bin/python scripts/carga_mysql.py --clientes 1000 --sessoes 50000
```

No Windows, use `.\.venv\Scripts\python.exe` no lugar de `.venv/bin/python`. O programa solicita usuário e senha no terminal e conecta em `127.0.0.1:3306`. A carga exige que todas as tabelas estejam vazias; não execute duas cargas simultaneamente. O script de criação não apaga bancos existentes.

Para instruções completas de preparação, verificação e execução das consultas, consulte o [manual](docs/manual-gerador.md). O procedimento completo em Linux ainda precisa ser reproduzido; as consultas precisam ser validadas com cenários de resultado conhecido e na carga ampliada.

## Dados e regras

O catálogo contém 500 filmes fictícios. A carga ampliada gera 1.000 clientes e 50.000 sessões; sem parâmetros, o gerador usa 20 clientes e 150 sessões. A referência padrão é 19/11/2026 e a semente numérica é 10, configuradas em [scripts/configuracao.py](scripts/configuracao.py).

- Avaliações e favoritos registram a associação atual de cada cliente com cada filme.
- Assinaturas mantêm histórico; o início da vigência é inclusivo e o término é exclusivo. Término `NULL` representa um período aberto.
- Um filme pode ter vários gêneros. Seu tempo assistido é contabilizado em cada gênero associado.
- A consulta 5 considera o consumo global dos filmes disponíveis na região selecionada; a consulta 8 considera sessões de clientes residentes nessa região.
- Nas consultas de demonstração, último mês significa o mês civil anterior completo e último trimestre significa os três meses civis anteriores completos. Ajuste a data de referência conforme necessário.
- O esquema garante chaves e restrições locais; regras entre registros, como sobreposição de assinaturas e disponibilidade de filmes, são tratadas pelo gerador e verificadas pelo script de integridade.
