USE sistema_streaming;

-- 1. Filmes disponíveis na região escolhida.
SELECT
	fi.id,
    fi.titulo
FROM filme fi
JOIN filme_regiao fr
	ON fr.id_filme = fi.id
JOIN regiao r
	ON r.id = fr.id_regiao
WHERE r.id = 1
-- Troque 1 pelo ID da região desejada. Consulte: SELECT * FROM regiao;
ORDER BY fi.titulo, fi.id;

-- 2. Favoritos do cliente, do mais recente para o mais antigo.
SELECT
	c.nome_completo,
    c.email,
    fi.titulo,
    f.data AS 'favoritou em'
FROM cliente c
JOIN favorita f
	ON c.id = f.id_cliente
JOIN filme fi
	ON fi.id = f.id_filme
WHERE c.email = 'clienteY@exemplo.com'
-- Troque o e-mail pelo e-mail cadastrado do cliente desejado.
ORDER BY f.data DESC, fi.titulo, fi.id;

-- 3. Filmes do gênero com média de todas as avaliações igual ou superior a 4.
SELECT
	fi.id,
    fi.titulo,
    AVG(a.nota) AS media_avaliacoes
FROM filme fi
JOIN filme_genero fg
	ON fg.id_filme = fi.id
JOIN genero g
	ON g.id = fg.id_genero
JOIN avalia a
	ON a.id_filme = fi.id
WHERE g.tipo = 'Drama'
-- Troque Drama pelo gênero desejado. Consulte: SELECT * FROM genero;
GROUP BY fi.id, fi.titulo
HAVING AVG(a.nota) >= 4
ORDER BY fi.titulo, fi.id;

-- 4. Filmes sem sessões no período, incluindo as duas datas.
SELECT fi.id, fi.titulo
FROM filme fi
WHERE NOT EXISTS (
    SELECT 1 FROM sessao s
    WHERE s.id_filme = fi.id
      AND s.data BETWEEN '2026-10-01' AND '2026-10-31'
    -- Troque as datas pelo início e fim do período desejado.
)
ORDER BY fi.titulo, fi.id;

-- 5. Sessões globais dos filmes disponíveis na região, inclusive filmes sem sessões.
SELECT
	fi.id,
	fi.titulo,
    COUNT(s.id) AS total_visualizacoes,
	COALESCE(SUM(s.duracao), 0) AS minutos_assistidos
FROM filme fi
JOIN filme_regiao fr
	ON fr.id_filme = fi.id
JOIN regiao r
	ON r.id = fr.id_regiao
LEFT JOIN sessao s
	ON s.id_filme = fi.id
    AND s.data >= '2026-10-01' AND s.data < '2026-11-01'
    -- Troque pelas datas de início do mês e início do mês seguinte.
WHERE r.id = 1
-- Troque 1 pelo ID da região desejada.
GROUP BY fi.id, fi.titulo
ORDER BY fi.titulo, fi.id;

-- 6. Horas assistidas pelo cliente em cada gênero, incluindo as duas datas.
-- Um filme com mais de um gênero contribui para cada gênero associado.
SELECT
	g.tipo AS genero,
	SUM(s.duracao) / 60.0 AS horas_assistidas
FROM cliente c
JOIN sessao s
	ON s.id_cliente = c.id
JOIN filme_genero fg
	ON fg.id_filme = s.id_filme
JOIN genero g
	ON g.id = fg.id_genero
WHERE c.email = 'clienteY@exemplo.com'
  AND s.data BETWEEN '2026-10-01' AND '2026-10-31'
-- Troque o e-mail e as datas pelo cliente e período desejados.
GROUP BY g.id, g.tipo
ORDER BY horas_assistidas DESC, g.tipo;

-- 7. Clientes com assinatura vigente na data de referência, por plano.
-- O limite é fixo por plano; sem clientes ativos, a média é NULL.
SELECT
	p.id,
	p.nome,
    COUNT(DISTINCT a.id_cliente) AS clientes_ativos,
	AVG(CASE WHEN a.id IS NOT NULL THEN p.quantidade_dispositivos END) AS media_dispositivos
FROM plano p
LEFT JOIN assinatura a
	ON a.id_plano = p.id
    AND a.data_inicio <= '2026-11-19'
    AND (a.data_termino IS NULL OR a.data_termino > '2026-11-19')
    -- Troque as duas datas pela mesma data de referência desejada.
GROUP BY p.id, p.nome
ORDER BY p.id;

-- 8. Cinco filmes com mais minutos assistidos por residentes da região.
-- Último mês = mês civil anterior completo à data de referência.
SELECT
	fi.id,
    fi.titulo,
	SUM(s.duracao) AS minutos_assistidos,
	COUNT(*) AS total_sessoes
FROM sessao s
JOIN cliente c
	ON c.id = s.id_cliente
JOIN filme fi
	ON fi.id = s.id_filme
WHERE c.id_regiao = 1
  AND s.data >= DATE_FORMAT(DATE_SUB('2026-11-19', INTERVAL 1 MONTH), '%Y-%m-01')
  AND s.data < DATE_FORMAT('2026-11-19', '%Y-%m-01')
-- Troque 1 pelo ID da região e as duas datas pela mesma referência desejada.
GROUP BY fi.id, fi.titulo
ORDER BY minutos_assistidos DESC, total_sessoes DESC, fi.id
LIMIT 5;

-- 9. Percentual de sessões do cliente em cada qualidade no período.
SELECT
	s.qualidade_usada,
	COUNT(*) AS total_sessoes,
	100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS percentual
FROM sessao s
JOIN cliente c
	ON c.id = s.id_cliente
WHERE c.email = 'clienteY@exemplo.com'
  AND s.data BETWEEN '2026-10-01' AND '2026-10-31'
-- Troque o e-mail e as datas pelo cliente e período desejados.
GROUP BY s.qualidade_usada
ORDER BY total_sessoes DESC, s.qualidade_usada;

-- 10. Trocas de plano nos três meses civis completos anteriores à referência.
-- O plano anterior é a assinatura imediatamente anterior no histórico do cliente.
WITH historico AS (
    SELECT a.*,
           LAG(a.id_plano) OVER (PARTITION BY a.id_cliente ORDER BY a.data_inicio, a.id) AS plano_anterior,
           LAG(a.data_inicio) OVER (PARTITION BY a.id_cliente ORDER BY a.data_inicio, a.id) AS inicio_anterior,
           LAG(a.data_termino) OVER (PARTITION BY a.id_cliente ORDER BY a.data_inicio, a.id) AS termino_anterior
    FROM assinatura a
)
SELECT
	c.id,
	c.nome_completo,
    c.email,
       anterior.nome AS plano_anterior, h.inicio_anterior, h.termino_anterior,
       novo.nome AS novo_plano, h.data_inicio AS inicio_novo, h.data_termino AS termino_novo
FROM historico h
JOIN cliente c
	ON c.id = h.id_cliente
JOIN plano anterior
	ON anterior.id = h.plano_anterior
JOIN plano novo
	ON novo.id = h.id_plano
WHERE h.plano_anterior <> h.id_plano
  AND h.data_inicio >= DATE_FORMAT(DATE_SUB('2026-11-19', INTERVAL 3 MONTH), '%Y-%m-01')
  AND h.data_inicio < DATE_FORMAT('2026-11-19', '%Y-%m-01')
-- Troque as duas datas pela mesma data de referência desejada.
ORDER BY h.data_inicio DESC, c.id, h.id;
