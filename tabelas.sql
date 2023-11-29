-- Secção para a criação das tabelas conforme o diagrama entidade relação

CREATE TABLE "TP_AAD".sensores(
	id_dados INT PRIMARY KEY,
	temperatura REAL,
	freq_cardiaca INT,
	freq_respiratoria INT
);

CREATE TABLE "TP_AAD".doente (
    num_utente INT PRIMARY KEY,
    nome VARCHAR(255),
    idade INT,
    email VARCHAR(255),
	id_sensor INT, -- Chave estrangeira referenciando a tabela sensores
	CONSTRAINT fk_sensores FOREIGN KEY (id_sensor) REFERENCES "TP_AAD".sensores (id_dados)
);

CREATE TABLE "TP_AAD".medico (
    cod_cedula INT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
	ficha_tecnica INT, -- Chave estrangeira referenciando a tabela ficha
	CONSTRAINT fk_ficha FOREIGN KEY (ficha_tecnica) REFERENCES "TP_AAD".ficha (id_ficha)
);

CREATE TABLE "TP_AAD".consulta (
    id_consulta INT PRIMARY KEY,
    id_paciente INT, -- Chave estrangeira referenciando a tabela paciente
    id_medico INT, -- Chave estrangeira referenciando a tabela medico
    exame VARCHAR(255),
    data_consulta DATE,
    hora TIME,
    prescricao VARCHAR(255),
	avaliacao VARCHAR(255),
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES "TP_AAD".doente (num_utente),
    CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES "TP_AAD".medico (cod_cedula)
);

CREATE TABLE "TP_AAD".registo_clinico(
	id_registo INT PRIMARY KEY,
	doencas VARCHAR(255),
	historico_consultas VARCHAR(255),
	historico_prescricao VARCHAR(255),
	id_doente INT, -- Chave estrangeira referenciando a tabela doente
	id_medico INT, -- Chave estrangeira referenciando a tabela medico
	CONSTRAINT fk_doente FOREIGN KEY (id_doente) REFERENCES "TP_AAD".doente (num_utente),
	CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES "TP_AAD".medico (cod_cedula)
);

CREATE TABLE "TP_AAD".ficha(
	id_ficha INT PRIMARY KEY,
	nivel_stress INT,
	id_medico INT, -- Chave estrangeira referenciando a tabela medico
	consulta_id INT, -- Chave estrangeira referenciando a tabela consulta
	CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES "TP_AAD".medico (cod_cedula),
	CONSTRAINT fk_consulta FOREIGN KEY (consulta_id) REFERENCES "TP_AAD".consulta (id_consulta)
);

-- Secção para eliminação de tabelas

DROP TABLE "TP_AAD".consulta;
DROP TABLE "TP_AAD".medico;
DROP TABLE "TP_AAD".doente;
DROP TABLE "TP_AAD".registo_clinico;
DROP TABLE "TP_AAD".ficha CASCADE;

