"""Sessões com assinatura vigente e disponibilidade regional."""
from datetime import timedelta, time
from configuracao import QUALIDADES


def gerar_sessoes(dados, rng, quantidade_sessoes, referencia):
    # Uma sessão por cliente por dia evita sobreposição e respeita o limite de dispositivos.
    disponiveis = {(r["id_regiao"], r["id_filme"]) for r in dados["filme_regiao"]}
    planos = {p["id"]: p for p in dados["plano"]}
    assinaturas = {c["id"]: [] for c in dados["cliente"]}
    for assinatura in dados["assinatura"]:
        assinaturas[assinatura["id_cliente"]].append(assinatura)
    candidatos = []
    for cliente in dados["cliente"]:
        for dias in range(1, 366):
            dia = referencia - timedelta(days=dias)
            for assinatura in assinaturas[cliente["id"]]:
                if assinatura["data_inicio"] <= dia and (assinatura["data_termino"] is None or dia < assinatura["data_termino"]):
                    candidatos.append((cliente, dia, assinatura))
                    break
    if quantidade_sessoes > len(candidatos):
        raise ValueError(f"Há apenas {len(candidatos)} dias disponíveis para sessões.")
    for cliente, dia, assinatura in rng.sample(candidatos, quantidade_sessoes):
        plano = planos[assinatura["id_plano"]]
        filmes = [f for f in dados["filme"] if (cliente["id_regiao"], f["id"]) in disponiveis
                  and f["ano_lancamento"] <= dia.year]
        filme = rng.choice(filmes)
        dados["sessao"].append({"id": len(dados["sessao"]) + 1, "id_cliente": cliente["id"],
            "id_filme": filme["id"], "data": dia, "hora_inicio": time(rng.randrange(8, 22), rng.randrange(60)),
            "duracao": rng.randint(1, filme["duracao"]), "dispositivo": rng.choice(["TV", "Celular", "Computador"]),
            "qualidade_usada": rng.choice(QUALIDADES[:QUALIDADES.index(plano["qualidade_maxima"]) + 1])})
