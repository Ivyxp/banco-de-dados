create database evento;

use evento;

-- Tabela de Eventos
CREATE TABLE Eventos (
    eve_id INT PRIMARY KEY,
    eve_nome VARCHAR(100),
    eve_data DATE,
    eve_localizacao VARCHAR(100),
    eve_descricao TEXT,
    eve_organizador VARCHAR(100)
);

-- Tabela de Participantes
CREATE TABLE Participantes (
    part_id INT PRIMARY KEY,
	part_nome VARCHAR(100),
	part_endereco VARCHAR(100),
	part_email VARCHAR(100),
	part_telefone VARCHAR(20),
	part_empresa_afiliacao VARCHAR(100),
	part_eventos_FK INT,
    FOREIGN KEY (part_eventos_FK) REFERENCES Eventos(eve_id)
);

-- Tabela de Palestrantes
CREATE TABLE Palestrantes (
    pales_id INT PRIMARY KEY,
    pales_nome VARCHAR(100),
    pales_biografia TEXT,
    pales_area_especializacao VARCHAR(100),
    pales_evento_FK INT,
    FOREIGN KEY (pales_evento_FK) REFERENCES Eventos(eve_id)
);

-- Tabela de Patrocinadores
CREATE TABLE Patrocinadores (
    patro_id INT PRIMARY KEY,
	patro_nome_empresa VARCHAR(100),
	patro_contato VARCHAR(100),
	patro_tipo_patrocinio VARCHAR(100),
	patro_evento_FK INT,
    FOREIGN KEY (patro_evento_FK ) REFERENCES Eventos(eve_id)
);

-- Tabela de Inscrições
CREATE TABLE Inscricoes (
    inscri_id INT PRIMARY KEY,
	inscri_participante_FK INT,
	inscri_evento_FK INT,
	inscri_data_inscricao DATE,
	inscri_status_pagamento VARCHAR(20),
    FOREIGN KEY (inscri_participante_FK) REFERENCES Participantes(part_id),
    FOREIGN KEY (inscri_evento_FK) REFERENCES Eventos(eve_id)
);

-- Tabela de Sessões
CREATE TABLE Sessoes (
    sessao_id INT PRIMARY KEY,
	sessao_titulo VARCHAR(100),
	sessao_descricao TEXT,
	sessao_horario TIME,
	sessao_evento_FK INT,
    FOREIGN KEY (sessao_evento_FK) REFERENCES Eventos(eve_id)
);

-- Tabela de Feedback dos Participantes
CREATE TABLE Feedback (
    fb_id INT PRIMARY KEY,
    fb_sessao_FK INT,
    fb_participante_FK INT,
    fb_pontuacao INT,
    FB_comentario TEXT,
    FOREIGN KEY ( fb_sessao_FK ) REFERENCES Sessoes(sessao_id),
    FOREIGN KEY (fb_participante_FK) REFERENCES Participantes(part_id)
);

-- Tabela de Organizadores
CREATE TABLE Organizadores (
    organizador_id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20),
    evento_id INT,
    FOREIGN KEY (evento_id) REFERENCES Eventos(eve_id)
);

-- Tabela de Locais
CREATE TABLE Locais (
    local_id INT PRIMARY KEY,
	local_nome VARCHAR(100),
	local_endereco VARCHAR(100),
	local_capacidade INT
);

-- Tabela de Categorias de Eventos
CREATE TABLE Categorias (
    cat_id INT PRIMARY KEY,
    cat_nome VARCHAR(100)
);

-- Tabela de Relacionamento entre Eventos e Categorias
CREATE TABLE Eventos_Categorias (
    ec_evento_FK INT,
    ec_cat_FK INT,
    PRIMARY KEY (ec_evento_FK, ec_cat_FK),
    FOREIGN KEY (ec_evento_FK) REFERENCES Eventos(eve_id),
    FOREIGN KEY (ec_cat_FK) REFERENCES Categorias(cat_id )
);

#***************************************************************

INSERT INTO Eventos (eve_id, eve_nome, eve_data, eve_localizacao, eve_descricao, eve_organizador)
VALUES (1, 'Conferência de Tecnologia', '2023-10-15', 'Centro de convenções', 'Uma conferência sobre as últimas tendências em tecnologia.', 'l corp');


INSERT INTO Participantes (part_id, part_nome, part_endereco, part_email, part_telefone, part_empresa_afiliacao, part_eventos_FK)
VALUES (1, 'João Silva', 'Rua Principal 123', 'joao.silva@email.com', '123456789', 'planeta diario', 1);


INSERT INTO Palestrantes (pales_id, pales_nome, pales_biografia, pales_area_especializacao, pales_evento_FK)
VALUES (1, 'Maria Souza', 'Especialista em Inteligência Artificial com mais de 10 anos de experiência.', 'Inteligência Artificial', 1);


INSERT INTO Patrocinadores (patro_id, patro_nome_empresa, patro_contato, patro_tipo_patrocinio, patro_evento_FK)
VALUES (1, 'magazine luiza', 'patrocinio@magalu.com', 'Patrocinador Ouro', 1);

INSERT INTO Inscricoes (inscri_id, inscri_participante_FK, inscri_evento_FK, inscri_data_inscricao, inscri_status_pagamento)
VALUES (1, 1, 1, '2023-09-30', 'Pago');

#**************************************************************

CREATE VIEW ParticipantesInscritos AS
SELECT part_nome, part_email, eve_nome AS evento
FROM Participantes 
JOIN Eventos ON part_eventos_FK = eve_id;

CREATE VIEW PalestrantesPorEvento AS
SELECT eve_nome AS evento, pales_nome AS palestrante, pales_area_especializacao
FROM Palestrantes 
JOIN Eventos ON pales_evento_FK= eve_id;

CREATE VIEW InscricoesPagas AS
SELECT inscri_id, part_nome AS participante, eve_nome AS evento
FROM Inscricoes 
JOIN Participantes ON inscri_participante_FK = part_id
JOIN Eventos ON inscri_evento_FK = eve_id
WHERE inscri_status_pagamento = 'Pago';

CREATE VIEW PatrocinadoresEvento AS
SELECT patro_nome_empresa AS patrocinadores, patro_nome_empresa, patro_tipo_patrocinio, eve_nome AS evento
FROM Patrocinadores 
JOIN Eventos ON patro_evento_FK = eve_id;

#**************************************

delimiter //

CREATE TRIGGER atualizar_quantidade_participantes_evento
AFTER INSERT
ON Participantes
FOR EACH ROW
BEGIN
    UPDATE Eventos
    SET quantidade_participantes = (
        SELECT COUNT(*) FROM Participantes WHERE part_eventos_FK = NEW.part_eventos_FK
    )
    WHERE eve_id = NEW.part_eventos_FK;
END;

//

delimiter //

CREATE TRIGGER calcular_media_feedback_sessao
AFTER INSERT
ON Feedback
FOR EACH ROW
BEGIN
    UPDATE Sessoes
    SET media_pontuacao = (
        SELECT AVG(fb_pontuacao) FROM Feedback WHERE fb_sessao_FK = NEW.fb_sessao_FK
    )
    WHERE sessao_id = NEW.fb_sessao_FK;
END;

//

delimiter //
 
 CREATE TRIGGER atualizar_quantidade_patrocinadores_evento
AFTER INSERT
ON Patrocinadores
FOR EACH ROW
BEGIN
    UPDATE Eventos
    SET quantidade_patrocinadores = (
        SELECT COUNT(*) FROM Patrocinadores WHERE patro_evento_FK = NEW.patro_evento_FK
    )
    WHERE eve_id = NEW.patro_evento_FK;
END;

//

delimiter //

CREATE TRIGGER atualizar_capacidade_disponivel_local
AFTER INSERT
ON Inscricoes
FOR EACH ROW
BEGIN
    UPDATE Locais
    SET capacidade_disponivel = capacidade - 1
    WHERE local_id = (SELECT eve_localizacao FROM Eventos WHERE eve_id = NEW.inscri_evento_FK);
END;
//