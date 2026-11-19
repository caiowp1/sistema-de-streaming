"""Ponto de entrada do gerador demonstrativo em memória."""
import random
from datetime import date
from faker import Faker
from catalogo import gerar_catalogo
from clientes import gerar_clientes
from sessoes import gerar_sessoes
from configuracao import DATA_REFERENCIA, QUANTIDADE_CLIENTES, QUANTIDADE_SESSOES, SEMENTE


def gerar_dados(semente=SEMENTE, quantidade_clientes=QUANTIDADE_CLIENTES,
                quantidade_sessoes=QUANTIDADE_SESSOES, referencia=DATA_REFERENCIA):
    if quantidade_clientes < 1 or quantidade_sessoes < 0 or referencia < date(2025, 1, 1):
        raise ValueError("Use clientes positivos, sessões não negativas e referência a partir de 2025.")
    rng = random.Random(semente)
    faker = Faker("pt_BR")
    faker.seed_instance(semente)
    dados = {nome: [] for nome in ("regiao", "plano", "genero", "filme", "cliente",
             "filme_genero", "filme_regiao", "assinatura", "sessao", "avalia", "favorita")}
    gerar_catalogo(rng, dados)
    gerar_clientes(dados, rng, faker, quantidade_clientes, referencia)
    gerar_sessoes(dados, rng, quantidade_sessoes, referencia)
    return dados


def main():
    dados = gerar_dados()
    print(f"Referência: {DATA_REFERENCIA} | semente: {SEMENTE}")
    for tabela, registros in dados.items():
        print(f"{tabela}: {len(registros)} registros")
        if registros:
            print(f"  exemplo: {registros[0]}")
    print("Dados gerados em memória; nenhuma alteração foi feita no MySQL.")


if __name__ == "__main__":
    main()
