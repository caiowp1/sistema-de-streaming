"""Regiões, planos, gêneros, filmes e relações do catálogo."""
from decimal import Decimal
from sementes import ler_csv


def gerar_catalogo(rng, dados):
    for tabela, arquivo in (("regiao", "regioes.csv"), ("plano", "planos.csv"),
                            ("genero", "generos.csv")):
        dados[tabela] = [{"id": i, **linha} for i, linha in enumerate(ler_csv(arquivo), 1)]
        if not dados[tabela]:
            raise ValueError(f"Arquivo {arquivo} está vazio.")
    for plano in dados["plano"]:
        plano["valor_mensal"] = Decimal(plano["valor_mensal"])
        plano["quantidade_dispositivos"] = int(plano["quantidade_dispositivos"])

    generos = {genero["tipo"]: genero["id"] for genero in dados["genero"]}
    for indice, linha in enumerate(ler_csv("filmes.csv"), 1):
        nomes_generos = linha.pop("generos").split("|")
        for campo in ("classificacao_indicativa", "duracao", "ano_lancamento"):
            linha[campo] = int(linha[campo])
        dados["filme"].append({"id": indice, **linha})
        for nome in nomes_generos:
            dados["filme_genero"].append({"id_filme": indice, "id_genero": generos[nome]})
        # O primeiro filme está disponível em todas as regiões, garantindo catálogo para todos.
        regioes = dados["regiao"] if indice == 1 else rng.sample(
            dados["regiao"], rng.randint(1, len(dados["regiao"])))
        for regiao in regioes:
            dados["filme_regiao"].append({"id_filme": indice, "id_regiao": regiao["id"]})
    if not dados["filme"]:
        raise ValueError("Arquivo filmes.csv está vazio.")
