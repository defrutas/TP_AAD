-- Criar tabela Sensor
CREATE TABLE "TP_AAD".Sensor (
    id_sensor integer PRIMARY KEY,
    temperatura float,
    freq_cardiaca integer,
    freq_respiratoria integer
);

-- Criar tabela Dados
CREATE TABLE "TP_AAD".Dados (
    id_dados integer PRIMARY KEY,
    temperatura_med float,
    freq_cardiaca_med integer,
    freq_respiratoria_med integer,
    id_sensor integer REFERENCES "TP_AAD".Sensor(id_sensor) ON DELETE SET NULL
);

-- Criar tabela Doente
CREATE TABLE "TP_AAD".Doente (
    num_utente integer PRIMARY KEY,
    nome varchar(100),
    idade integer,
    email varchar(100),
    Sensoresid_dados integer REFERENCES "TP_AAD".Dados(id_dados) ON DELETE SET NULL
);

-- Criar tabela Ficha
CREATE TABLE "TP_AAD".Ficha (
    id_ficha integer PRIMARY KEY,
    nivel_stress integer,
    Medico_cod_cedula integer,
    Consulta_id_consulta integer
	-- As chaves estrangeiras para Medico e Consulta sao adicionadas mais tarde depois de criar essas tabelas
);

-- Criar tabela Medico
CREATE TABLE "TP_AAD".Medico (
    cod_cedula integer PRIMARY KEY,
    nome varchar(100),
    email varchar(100),
    Fichaid_ficha integer REFERENCES "TP_AAD".Ficha(id_ficha) ON DELETE SET NULL
);

-- Dicionar chave estrangeira em Ficha que faz referencia a Medico
ALTER TABLE "TP_AAD".Ficha ADD CONSTRAINT fk_medico FOREIGN KEY (Medico_cod_cedula) REFERENCES "TP_AAD".Medico(cod_cedula) ON DELETE SET NULL;

-- Criar tabela Consulta
CREATE TABLE "TP_AAD".Consulta (
    id_consulta integer PRIMARY KEY,
    exame varchar(100),
    data date,
    hora timestamp,
    prescricao varchar(100),
    avaliacao varchar(100),
    Doente_num_utente integer REFERENCES "TP_AAD".Doente(num_utente) ON DELETE CASCADE,
    Medico_cod_cedula integer REFERENCES "TP_AAD".Medico(cod_cedula) ON DELETE SET NULL
);

-- Addicionar chave estrangeira em Ficha que faz referencia a Consulta
ALTER TABLE "TP_AAD".Ficha ADD CONSTRAINT fk_consulta FOREIGN KEY (Consulta_id_consulta) REFERENCES "TP_AAD".Consulta(id_consulta) ON DELETE SET NULL;

-- Criar tabela Registo Clinico
CREATE TABLE "TP_AAD".Registro_Clinico (
    id_registro integer PRIMARY KEY,
    doencas varchar(100),
    Doente_num_utente integer REFERENCES "TP_AAD".Doente(num_utente) ON DELETE CASCADE,
    Medico_cod_cedula integer REFERENCES "TP_AAD".Medico(cod_cedula) ON DELETE SET NULL
);

-- Criar tabela Prescricao
CREATE TABLE "TP_AAD".Prescricao (
    id_prescricao integer PRIMARY KEY,
    nom_prescricao VARCHAR(20),
    Registro_Clinicoid_registro integer REFERENCES "TP_AAD".Registro_Clinico(id_registro) ON DELETE CASCADE
);
