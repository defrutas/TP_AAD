CREATE TABLE "TP_AAD".paciente (
    num_utente INT PRIMARY KEY,
    nome VARCHAR(255),
    idade INT,
    email VARCHAR(255)
);

CREATE TABLE "TP_AAD".medico (
    num_registo INT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE "TP_AAD".consulta (
    id_consulta INT PRIMARY KEY,
    id_paciente INT, -- Chave estrangeira referenciando a tabela paciente
    id_medico INT, -- Chave estrangeira referenciando a tabela medico
    exame VARCHAR(255),
    data DATE,
    hora TIME,
    prescricao VARCHAR(255),
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES "TP_AAD".paciente (num_utente),
    CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES "TP_AAD".medico (num_registo)
);
