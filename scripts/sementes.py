"""Leitura de arquivos semente."""
import csv
from configuracao import PASTA_SEEDS


def ler_csv(nome):
    with (PASTA_SEEDS / nome).open(encoding="utf-8-sig", newline="") as arquivo:
        return list(csv.DictReader(arquivo))
