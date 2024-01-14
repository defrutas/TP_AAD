-- Inserir dados na tabela Sensor
INSERT INTO "TP_AAD".Sensor (id_sensor, temperatura, freq_cardiaca, freq_respiratoria) VALUES
(1, 36.5, 70, 16),
(2, 37.2, 80, 18),
(3, 36.8, 65, 20),
(4, 37.5, 85, 22);

-- Inserir dados na tabela Dados
INSERT INTO "TP_AAD".Dados (id_dados, temperatura_med, freq_cardiaca_med, freq_respiratoria_med, id_sensor) VALUES
(1, 36.7, 72, 17, 1),
(2, 37.0, 78, 19, 2),
(3, 36.9, 68, 21, 3),
(4, 37.3, 82, 20, 4);


-- Inserir dados na tabela Doente
INSERT INTO "TP_AAD".Doente (num_utente, nome, idade, email, Sensoresid_dados) VALUES
(12345, 'João Silva', 30, 'joaosilva@example.com', 1),
(67890, 'Maria Souza', 25, 'mariasouza@example.com', 2),
(34567, 'Carlos Teixeira', 40, 'carlosteixeira@example.com', 3),
(45678, 'Ana Gomes', 35, 'anagomes@example.com', 4);


-- Inserir dados na tabela Ficha
-- Note: Inserir depois de `Medico` and `Consulta` porque tem chaves estrangeiras dessas tabelas.

-- Inserir dados na tabela Medico
INSERT INTO "TP_AAD".Medico (cod_cedula, nome, email) VALUES
(111, 'Dr. Ana Pereira', 'anapereira@example.com'),
(222, 'Dr. Lucas Martins', 'lucasmartins@example.com'),
(333, 'Dr. Sofia Cardoso', 'sofiacardoso@example.com'),
(444, 'Dr. Miguel Neto', 'miguelneto@example.com');


-- Inserir dados na tabela Consulta
INSERT INTO "TP_AAD".Consulta (id_consulta, exame, data, hora, prescricao, avaliacao, Doente_num_utente, Medico_cod_cedula) VALUES
(1, 'Exame de sangue', '2024-01-10', '2024-01-10 09:00:00', 'Vitamin D', 'Normal', 12345, 111),
(2, 'Raio X', '2024-01-11', '2024-01-11 14:00:00', 'Calcium', 'Fratura detectada', 67890, 222),
(3, 'Eletrocardiograma', '2024-02-15', '2024-02-15 10:30:00', 'Beta-blocker', 'Batimentos irregulares', 34567, 333),
(4, 'Teste de esforço', '2024-02-20', '2024-02-20 11:00:00', 'Rehydration', 'Bom desempenho', 45678, 444);


-- Inserir dados na tabela Ficha
INSERT INTO "TP_AAD".Ficha (id_ficha, nivel_stress, Medico_cod_cedula, Consulta_id_consulta) VALUES
(1, 5, 111, 1),
(2, 3, 222, 2),
(3, 4, 333, 3),
(4, 2, 444, 4);

-- Inserir dados na tabela Registo Clinico
INSERT INTO "TP_AAD".Registro_Clinico (id_registro, doencas, Doente_num_utente, Medico_cod_cedula) VALUES
(1, 'Hipertensão', 12345, 111),
(2, 'Asma', 67890, 222),
(3, 'Diabetes', 34567, 333),
(4, 'Colesterol Alto', 45678, 444);

-- Inserir dados na tabela Prescricao
INSERT INTO "TP_AAD".Prescricao (id_prescricao, nom_prescricao, Registro_Clinicoid_registro) VALUES
(1, 'Benuron', 1),
(2, 'Brufen', 2),
(3, 'Ilvico', 3),
(4, 'Brufen', 4);


