# Sistema de streaming

Projeto de Banco de Dados com evolução planejada para aplicação de portfólio.

- SGBD exigido: MySQL.
- Entrega acadêmica: 02/12/2026 às 23h55 (America/Manaus).
- Estado: banco MySQL de 11 tabelas e gerador implementados; carga de 500 filmes, 1.000 clientes e 50.000 sessões verificada no MySQL. Consultas e reprodução do procedimento em Linux ainda estão pendentes.

Modelo atual: [entidades, atributos, cardinalidades e regras](docs/modelo-conceitual.md). Esquema e normalização: [modelo relacional](docs/modelo-relacional.md). Script: [criação do banco](sql/criacao.sql).

Gerador: [manual de instalação, carga e verificação](docs/manual-gerador.md). Os dados-base ficam em `seeds/` e o código em `scripts/`.

Leia [ROTEIRO.md](ROTEIRO.md) para requisitos, calendário e pendências e [STATUS.md](STATUS.md) para retomar o trabalho em outro computador ou chat.

Consulte [SINCRONIZACAO.md](SINCRONIZACAO.md) para o fluxo entre computadores. O Git compartilha os arquivos registrados; o histórico de conversas do Codex e o banco MySQL local precisam ser tratados separadamente.
