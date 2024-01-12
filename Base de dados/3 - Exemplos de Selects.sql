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


