# Alternar entre computadores

## Primeira configuração

Repositório privado: https://github.com/caiowp1/sistema-de-streaming. No segundo computador, após a confirmação do primeiro envio:

1. Instalar o Git, caso ainda não esteja instalado, e autenticar a conta GitHub.
2. Clonar o repositório privado:

   ```sh
   git clone https://github.com/caiowp1/sistema-de-streaming.git
   ```
3. Adicionar a pasta clonada como projeto no Codex.
4. Pedir ao novo chat para ler README.md, ROTEIRO.md e STATUS.md.

## Antes de trabalhar

Na pasta do projeto, verificar se há alterações locais:

```sh
git status
```

Com a pasta sem alterações pendentes, atualizar:

```sh
git pull --ff-only
```

Se houver alterações ou o comando falhar, pedir ao Codex que examine a situação antes de continuar.

## Ao terminar

Atualizar STATUS.md com decisões, verificações e próximo passo. Revisar os arquivos antes de incluí-los em um commit:

```sh
git status
git diff
```

Pedir ao Codex para registrar as alterações pretendidas e enviá-las ao GitHub. Confirmar que o push terminou antes de trocar de computador. Não editar simultaneamente a mesma etapa nos dois computadores.

## O que é compartilhado

Arquivos registrados no Git: documentação, modelos, SQL, gerador, sementes e testes. O banco MySQL local, programas instalados, credenciais e conversas do Codex não são transferidos pelo Git. O banco será reconstruído em cada computador pelos scripts de criação e população quando existirem.

## Pedido sugerido ao abrir um chat

> Leia AGENTS.md, README.md, ROTEIRO.md e STATUS.md. Confira o estado do Git e retome a próxima etapa. Ao terminar, atualize STATUS.md e registre as decisões relevantes nos arquivos.
