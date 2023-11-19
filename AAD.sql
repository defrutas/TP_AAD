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
    id_paciente INT, -- chave estrangeira de paciente
    id_medico INT, --- chave estrangeira de medico
    exame VARCHAR(255),
    data DATE,
    hora TIME,
    prescricao VARCHAR(255),
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES "TP_AAD".paciente (num_utente),
    CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES "TP_AAD".medico (num_registo)
);

CREATE TABLE "TP_AAD".formulario (
    id_formulario INT PRIMARY KEY,
    id_paciente INT, -- chave estrangeira de paciente
    indicacoes TEXT,
    marcacao DATE,

    CONSTRAINT fk_paciente_formulario FOREIGN KEY (id_paciente) REFERENCES "TP_AAD".paciente (num_utente)
);

CREATE TABLE "TP_AAD".registo_clinico (
    id_registo INT PRIMARY KEY,
    id_paciente INT, -- chave estrangeira de paciente 
    id_medico INT, -- chave estrangeira do medico
    doencas TEXT,
    historico_consultas TEXT,
    historico_prescricao TEXT,
    ultima_atualizacao TIMESTAMP,
    CONSTRAINT fk_paciente_registo_clinico FOREIGN KEY (id_paciente) REFERENCES "TP_AAD".paciente (num_utente),
    CONSTRAINT fk_medico_registo_clinico FOREIGN KEY (id_medico) REFERENCES "TP_AAD".medico (num_registo)
);

