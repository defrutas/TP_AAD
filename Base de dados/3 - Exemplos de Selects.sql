--Dados das consultas de cada doente
SELECT
  D.nome AS nome_doente,
  D.email AS email_doente,
  C.data AS data_consulta,
  C.hora AS tempo_consulta,
  C.avaliacao AS avaliacao
FROM
  "TP_AAD".Doente D
JOIN "TP_AAD".Consulta C ON D.num_utente = C.Doente_num_utente
WHERE
  C.data = (SELECT MAX(data) FROM "TP_AAD".Consulta WHERE Doente_num_utente = D.num_utente);

--Numero de consultas de cada medico
SELECT
  M.nome AS medico_nome,
  COUNT(C.id_consulta) AS numero_de_consultas
FROM
  "TP_AAD".Medico M
LEFT JOIN "TP_AAD".Consulta C ON M.cod_cedula = C.Medico_cod_cedula
GROUP BY
  M.nome;

--Doentes com as suas prescricoes e doencas
SELECT
  D.nome AS nome_paciente,
  R.doencas AS doencas,
  P.nom_prescricao AS nome_prescricao
FROM
  "TP_AAD".Doente D
JOIN "TP_AAD".Registro_Clinico R ON D.num_utente = R.Doente_num_utente
JOIN "TP_AAD".Prescricao P ON R.id_registro = P.Registro_Clinicoid_registro;

--Todas as consultas com doentes e doutores incluindo dados dos sensores durante a consulta
SELECT
  D.nome AS patient_name,
  M.nome AS doctor_name,
  C.data AS consultation_date,
  Da.temperatura_med AS dados_temperature,
  Da.freq_cardiaca_med AS dados_freq_cardiaca,
  Da.freq_respiratoria_med AS dados_freq_respiratoria
FROM
  "TP_AAD".Consulta C
JOIN "TP_AAD".Doente D ON C.Doente_num_utente = D.num_utente
JOIN "TP_AAD".Medico M ON C.Medico_cod_cedula = M.cod_cedula
JOIN "TP_AAD".Dados Da ON D.Sensoresid_dados = Da.id_dados
JOIN "TP_AAD".Sensor S ON Da.id_sensor = S.id_sensor;

--Niveis de stress de cada paciente e a suas avaliacoes medicas correspondentes
SELECT
  D.nome AS nome_doente,
  F.nivel_stress AS nivel_stress,
  C.avaliacao AS avaliacao
FROM
  "TP_AAD".Ficha F
JOIN "TP_AAD".Consulta C ON F.Consulta_id_consulta = C.id_consulta
JOIN "TP_AAD".Doente D ON C.Doente_num_utente = D.num_utente
WHERE
  F.nivel_stress IS NOT NULL;

--Dados da consulta com os doentes e meidcos
SELECT
    C.id_consulta,
    C.exame,
    C.data,
    C.hora,
    C.prescricao,
    C.avaliacao,
    D.num_utente,
    D.nome AS paciente_nome,
    M.nome AS medico_nome
FROM "TP_AAD".Consulta C
JOIN "TP_AAD".Doente D ON C.Doente_num_utente = D.num_utente
LEFT JOIN "TP_AAD".Medico M ON C.Medico_cod_cedula = M.cod_cedula;

--Registos clinicos associados a doenstes e medicos
SELECT
    RC.id_registro,
    RC.doencas,
    D.num_utente,
    D.nome AS paciente_nome,
    M.nome AS medico_nome
FROM "TP_AAD".Registro_Clinico RC
JOIN "TP_AAD".Doente D ON RC.Doente_num_utente = D.num_utente
LEFT JOIN "TP_AAD".Medico M ON RC.Medico_cod_cedula = M.cod_cedula;

--informacao do doente com a ultima consulta
WITH LatestConsultation AS (
    SELECT
        D.num_utente,
        MAX(C.data) AS latest_date
    FROM "TP_AAD".Doente D
    JOIN "TP_AAD".Consulta C ON D.num_utente = C.Doente_num_utente
    GROUP BY D.num_utente
)
SELECT
    D.num_utente,
    D.nome,
    D.idade,
    C.exame AS latest_exame,
    C.data AS latest_data
FROM "TP_AAD".Doente D
LEFT JOIN LatestConsultation LC ON D.num_utente = LC.num_utente
LEFT JOIN "TP_AAD".Consulta C ON LC.num_utente = C.Doente_num_utente AND LC.latest_date = C.data;

--doentes com o seu registo clinico e as suas prescricoes
SELECT
    D.num_utente,
    D.nome AS patient_name,
    RC.id_registro,
    RC.doencas,
    P.id_prescricao,
    P.nom_prescricao
FROM "TP_AAD".Doente D
JOIN "TP_AAD".Registro_Clinico RC ON D.num_utente = RC.Doente_num_utente
LEFT JOIN "TP_AAD".Prescricao P ON RC.id_registro = P.Registro_Clinicoid_registro;

--doutores e os dados de stress dos seus pacientes
SELECT
    M.cod_cedula,
    M.nome AS doctor_name,
    AVG(F.nivel_stress) AS avg_stress_level
FROM "TP_AAD".Medico M
JOIN "TP_AAD".Ficha F ON M.cod_cedula = F.Medico_cod_cedula
GROUP BY M.cod_cedula, M.nome;

-- Doentes com dados de sensores que excedem as médias críticas
SELECT
    D.num_utente,
    D.nome AS patient_name,
    DS.id_dados,
    DS.temperatura_med AS avg_temperatura,
    DS.freq_cardiaca_med AS avg_freq_cardiaca,
    DS.freq_respiratoria_med AS avg_freq_respiratoria
FROM "TP_AAD".Doente D
JOIN "TP_AAD".Dados DS ON D.Sensoresid_dados = DS.id_dados
WHERE
    DS.temperatura_med > 38.5 OR
    DS.freq_cardiaca_med > 100 OR
    DS.freq_respiratoria_med > 20;






