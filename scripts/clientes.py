"""Clientes, assinaturas, avaliações e favoritos."""
from datetime import date, timedelta


def data_aleatoria(rng, inicio, fim):
    return inicio + timedelta(days=rng.randrange((fim - inicio).days + 1))


def gerar_clientes(dados, rng, faker, quantidade_clientes, referencia):
    for i in range(1, quantidade_clientes + 1):
        cadastro = data_aleatoria(rng, date(2021, 1, 1), date(2024, 1, 1))
        cliente = {"id": i, "id_regiao": rng.choice(dados["regiao"])["id"],
                   "nome_completo": faker.name(), "email": f"cliente{i}@exemplo.com",
                   "data_nascimento": data_aleatoria(rng, date(1946, 1, 1), date(2002, 12, 31)),
                   "data_cadastro": cadastro}
        dados["cliente"].append(cliente)
        # Uma parte troca de plano; outra termina a assinatura e fica inativa.
        troca = i % 3 == 0 and len(dados["plano"]) > 1
        inicio = cadastro
        fim = referencia - timedelta(days=90) if troca else None
        primeiro = rng.choice(dados["plano"])
        dados["assinatura"].append({"id": len(dados["assinatura"]) + 1, "id_cliente": i,
                                    "id_plano": primeiro["id"], "data_inicio": inicio, "data_termino": fim})
        if troca:
            outro = rng.choice([p for p in dados["plano"] if p["id"] != primeiro["id"]])
            dados["assinatura"].append({"id": len(dados["assinatura"]) + 1, "id_cliente": i,
                                        "id_plano": outro["id"], "data_inicio": fim,
                                        "data_termino": referencia - timedelta(days=15) if i % 6 == 0 else None})
        elif i % 5 == 0:
            dados["assinatura"][-1]["data_termino"] = referencia - timedelta(days=15)

        filmes = rng.sample(dados["filme"], rng.randint(0, min(4, len(dados["filme"]))))
        for filme in filmes:
            dados["avalia"].append({"id_cliente": i, "id_filme": filme["id"],
                                    "data": data_aleatoria(rng, cadastro, referencia), "nota": rng.randint(1, 5)})
        for filme in rng.sample(dados["filme"], rng.randint(0, min(4, len(dados["filme"])))):
            dados["favorita"].append({"id_cliente": i, "id_filme": filme["id"],
                                      "data": data_aleatoria(rng, cadastro, referencia)})
