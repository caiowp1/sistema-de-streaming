-- Selecione o banco desejado no Workbench antes de executar o script.
-- Cada contagem deve ser zero.
-- A referência deve acompanhar DATA_REFERENCIA em scripts/configuracao.py.
SET @referencia = '2026-11-19';

SELECT 'cliente sem assinatura' AS verificacao, COUNT(*) AS problemas
FROM cliente c
WHERE NOT EXISTS (SELECT 1 FROM assinatura a WHERE a.id_cliente = c.id)

UNION ALL
SELECT 'assinatura antes do cadastro', COUNT(*)
FROM assinatura a JOIN cliente c ON c.id = a.id_cliente
WHERE a.data_inicio < c.data_cadastro

UNION ALL
SELECT 'assinaturas sobrepostas', COUNT(*)
FROM assinatura a JOIN assinatura b ON a.id_cliente = b.id_cliente AND a.id < b.id
WHERE (b.data_termino IS NULL OR a.data_inicio < b.data_termino)
  AND (a.data_termino IS NULL OR b.data_inicio < a.data_termino)

UNION ALL
SELECT 'sessao sem assinatura vigente', COUNT(*)
FROM sessao s
WHERE NOT EXISTS (
    SELECT 1 FROM assinatura a
    WHERE a.id_cliente = s.id_cliente AND a.data_inicio <= s.data
      AND (a.data_termino IS NULL OR s.data < a.data_termino)
)

UNION ALL
SELECT 'filme indisponivel na regiao', COUNT(*)
FROM sessao s JOIN cliente c ON c.id = s.id_cliente
WHERE NOT EXISTS (
    SELECT 1 FROM filme_regiao fr
    WHERE fr.id_filme = s.id_filme AND fr.id_regiao = c.id_regiao
)

UNION ALL
SELECT 'qualidade acima do plano', COUNT(*)
FROM sessao s JOIN assinatura a ON a.id_cliente = s.id_cliente
    AND a.data_inicio <= s.data AND (a.data_termino IS NULL OR s.data < a.data_termino)
JOIN plano p ON p.id = a.id_plano
WHERE FIELD(s.qualidade_usada, 'SD', 'HD', 'FULL_HD', '4K') >
      FIELD(p.qualidade_maxima, 'SD', 'HD', 'FULL_HD', '4K')

UNION ALL
SELECT 'sessao fora dos limites de data ou duracao', COUNT(*)
FROM sessao s JOIN filme f ON f.id = s.id_filme
WHERE s.data >= @referencia OR YEAR(s.data) < f.ano_lancamento
   OR s.duracao <= 0 OR s.duracao > f.duracao

UNION ALL
SELECT 'mais de uma sessao no dia por cliente', COUNT(*)
FROM (SELECT id_cliente, data FROM sessao GROUP BY id_cliente, data HAVING COUNT(*) > 1) repetidas

UNION ALL
SELECT 'filme sem genero', COUNT(*) FROM filme f
WHERE NOT EXISTS (SELECT 1 FROM filme_genero fg WHERE fg.id_filme = f.id)

UNION ALL
SELECT 'filme sem regiao', COUNT(*) FROM filme f
WHERE NOT EXISTS (SELECT 1 FROM filme_regiao fr WHERE fr.id_filme = f.id)

UNION ALL
SELECT 'avaliacao anterior ao cadastro', COUNT(*)
FROM avalia a JOIN cliente c ON c.id = a.id_cliente WHERE a.data < c.data_cadastro

UNION ALL
SELECT 'favorito anterior ao cadastro', COUNT(*)
FROM favorita f JOIN cliente c ON c.id = f.id_cliente WHERE f.data < c.data_cadastro;
