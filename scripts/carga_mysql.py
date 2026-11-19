"""Carga transacional dos dados gerados em um banco MySQL vazio."""
import argparse
from getpass import getpass
from time import perf_counter

import mysql.connector

from gerador import gerar_dados


# A ordem respeita as chaves estrangeiras: pais antes de dependentes.
TABELAS = {
    "regiao": ("pais", "nome"),
    "plano": ("nome", "valor_mensal", "quantidade_dispositivos", "qualidade_maxima"),
    "genero": ("tipo",),
    "filme": ("titulo", "classificacao_indicativa", "idioma_original", "produtora", "duracao", "sinopse", "ano_lancamento"),
    "cliente": ("id_regiao", "nome_completo", "data_nascimento", "data_cadastro", "email"),
    "filme_genero": ("id_filme", "id_genero"),
    "filme_regiao": ("id_filme", "id_regiao"),
    "assinatura": ("id_plano", "id_cliente", "data_inicio", "data_termino"),
    "sessao": ("id_cliente", "id_filme", "data", "hora_inicio", "duracao", "dispositivo", "qualidade_usada"),
    "avalia": ("id_cliente", "id_filme", "data", "nota"),
    "favorita": ("id_cliente", "id_filme", "data"),
}
REFERENCIAS = {"id_regiao": "regiao", "id_plano": "plano", "id_genero": "genero",
               "id_filme": "filme", "id_cliente": "cliente"}
COM_ID = {"regiao", "plano", "genero", "filme", "cliente", "assinatura", "sessao"}


def carregar(conexao, dados):
    """Insere tudo em uma transação, ou desfaz a carga em caso de erro."""
    cursor = conexao.cursor()
    mapas = {tabela: {} for tabela in COM_ID}
    try:
        for tabela in TABELAS:
            cursor.execute(f"SELECT EXISTS(SELECT 1 FROM `{tabela}` LIMIT 1)")
            if cursor.fetchone()[0]:
                raise ValueError(f"A tabela {tabela} não está vazia. Nenhum dado foi inserido.")

        for tabela, colunas in TABELAS.items():
            nomes = ", ".join(f"`{coluna}`" for coluna in colunas)
            parametros = ", ".join(["%s"] * len(colunas))
            sql = f"INSERT INTO `{tabela}` ({nomes}) VALUES ({parametros})"
            for registro in dados[tabela]:
                valores = tuple(mapas[REFERENCIAS[campo]][registro[campo]]
                                if campo in REFERENCIAS else registro[campo] for campo in colunas)
                cursor.execute(sql, valores)
                if tabela in COM_ID:
                    mapas[tabela][registro["id"]] = cursor.lastrowid
        conexao.commit()
    except Exception:
        conexao.rollback()
        raise
    finally:
        cursor.close()


def main():
    parser = argparse.ArgumentParser(description="Gera e carrega dados em um banco vazio.")
    parser.add_argument("--banco", default="sistema_streaming", help="nome do banco MySQL")
    parser.add_argument("--clientes", type=int, default=20, help="quantidade de clientes")
    parser.add_argument("--sessoes", type=int, default=150, help="quantidade de sessões")
    args = parser.parse_args()
    print("Carga inicial: as 11 tabelas precisam estar vazias.")
    print(f"Banco: {args.banco} | clientes: {args.clientes} | sessões: {args.sessoes}")
    usuario = input("Usuário MySQL [root]: ").strip() or "root"
    senha = getpass("Senha MySQL: ")
    conexao = mysql.connector.connect(host="127.0.0.1", port=3306, user=usuario,
                                     password=senha, database=args.banco, autocommit=False)
    try:
        inicio = perf_counter()
        dados = gerar_dados(quantidade_clientes=args.clientes, quantidade_sessoes=args.sessoes)
        fim_geracao = perf_counter()
        carregar(conexao, dados)
        fim_carga = perf_counter()
        print(f"Geração: {fim_geracao - inicio:.2f} s | inserção e commit: {fim_carga - fim_geracao:.2f} s")
        print("Carga concluída:")
        for tabela, registros in dados.items():
            print(f"  {tabela}: {len(registros)}")
    finally:
        conexao.close()


if __name__ == "__main__":
    main()
