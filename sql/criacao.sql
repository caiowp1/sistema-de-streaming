CREATE DATABASE sistema_streaming;
USE sistema_streaming;

CREATE TABLE regiao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(100) NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_regiao INT NOT NULL,
    FOREIGN KEY (id_regiao) REFERENCES regiao (id),
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_cadastro DATE NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE
);

CREATE TABLE filme (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(50) NOT NULL,
    classificacao_indicativa INT NOT NULL,
    idioma_original VARCHAR(50) NOT NULL,
    produtora VARCHAR(50) NOT NULL,
    duracao INT NOT NULL CHECK (duracao > 0),
    sinopse VARCHAR(250) NOT NULL,
    ano_lancamento INT NOT NULL
);

CREATE TABLE sessao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    id_filme INT NOT NULL,
    FOREIGN KEY (id_filme) REFERENCES filme (id),
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    duracao INT NOT NULL CHECK (duracao > 0),
    dispositivo VARCHAR(50) NOT NULL,
    qualidade_usada VARCHAR(7) NOT NULL
        CHECK (qualidade_usada IN ('SD', 'HD', 'FULL_HD', '4K'))
);

CREATE TABLE plano (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_mensal DECIMAL(10,2) NOT NULL CHECK (valor_mensal > 0),
    quantidade_dispositivos INT NOT NULL CHECK (quantidade_dispositivos > 0),
    qualidade_maxima VARCHAR(7) NOT NULL
        CHECK (qualidade_maxima IN ('SD', 'HD', 'FULL_HD', '4K'))
);

CREATE TABLE assinatura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_plano INT NOT NULL,
    FOREIGN KEY (id_plano) REFERENCES plano (id),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    data_inicio DATE NOT NULL,
    data_termino DATE NULL,
    CHECK (data_termino IS NULL OR data_termino > data_inicio)
);

CREATE TABLE genero (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE filme_genero (
    id_filme INT NOT NULL,
    id_genero INT NOT NULL,
    PRIMARY KEY (id_filme, id_genero),
    FOREIGN KEY (id_filme) REFERENCES filme (id),
    FOREIGN KEY (id_genero) REFERENCES genero (id)
);

CREATE TABLE filme_regiao (
    id_filme INT NOT NULL,
    id_regiao INT NOT NULL,
    PRIMARY KEY (id_filme, id_regiao),
    FOREIGN KEY (id_filme) REFERENCES filme (id),
    FOREIGN KEY (id_regiao) REFERENCES regiao (id)
);

CREATE TABLE avalia (
    id_filme INT NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_filme, id_cliente),
    FOREIGN KEY (id_filme) REFERENCES filme (id),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    data DATE NOT NULL,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5)
);

CREATE TABLE favorita (
    id_filme INT NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_filme, id_cliente),
    FOREIGN KEY (id_filme) REFERENCES filme (id),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    data DATE NOT NULL
);
