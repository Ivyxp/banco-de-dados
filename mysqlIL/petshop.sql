create database Petshop_IM;

use Petshop_IM;


CREATE TABLE clientes (
    cli_id INT AUTO_INCREMENT PRIMARY KEY,
    cli_nome VARCHAR(100),
    cli_endereco VARCHAR(80),
    cli_cpf DECIMAL(15),
    cli_tel DECIMAL(15),
    cli_bairro VARCHAR(80),
    cli_num_casa VARCHAR(10)
);

CREATE TABLE raca (
    raca_id INT AUTO_INCREMENT PRIMARY KEY,
    raca_nome VARCHAR(80)
);

CREATE TABLE animais (
    ani_id INT AUTO_INCREMENT PRIMARY KEY,
    ani_nome VARCHAR(80),
    ani_idade INT,
    ani_sexo VARCHAR(15),
    animal_fk_cliente INT NOT NULL,
    animal_fk_raca INT NOT NULL,
    FOREIGN KEY (animal_fk_cliente) REFERENCES clientes(cli_id),
    FOREIGN KEY (animal_fk_raca) REFERENCES raca(raca_id)
);

CREATE TABLE vacinas (
    vaci_id INT AUTO_INCREMENT PRIMARY KEY,
    vaci_nome VARCHAR(100),
    vaci_quant INT,
    vaci_prazo INT
);

CREATE TABLE ordem_servico (
    ordS_id INT AUTO_INCREMENT PRIMARY KEY,
    ordS_serv DATE,
    ordS_total FLOAT,
    ordS_serv_fk_animal INT NOT NULL,
    FOREIGN KEY (ordS_serv_fk_animal) REFERENCES animais(ani_id)
);

CREATE TABLE produto_servico (
    prodS_id INT AUTO_INCREMENT PRIMARY KEY,
    prodS_nome VARCHAR(100),
    prodS_custo float,
    prodS_serv_tipo VARCHAR(80)
);

CREATE TABLE i_ordem_servico (
    i_ordem_servico_id INT AUTO_INCREMENT PRIMARY KEY,
    i_ord_serv_fk_prod_serv INT NOT NULL,
    i_ord_serv_fk_ordem_serv INT NOT NULL,
    i_ordem_serv_quant FLOAT,
    i_ordem_serv_valor FLOAT,
    FOREIGN KEY (i_ord_serv_fk_prod_serv) REFERENCES produto_servico(prodS_id),
    FOREIGN KEY (i_ord_serv_fk_ordem_serv) REFERENCES ordem_servico(ordS_id)
);

CREATE TABLE vacinas_aplicadas (
    vacina_aplicada INT AUTO_INCREMENT PRIMARY KEY,
    vacina_ap_fk_vacina INT NOT NULL,
    vacina_ap_fk_animal INT NOT NULL,
    FOREIGN KEY (vacina_ap_fk_vacina) REFERENCES vacinas(vaci_id),
    FOREIGN KEY (vacina_ap_fk_animal) REFERENCES animais(ani_id)
);

CREATE TABLE fpagamento (
    fpagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    fpagamento_nome VARCHAR(70)
);

CREATE TABLE funcionarios (
    func_id INT AUTO_INCREMENT PRIMARY KEY,
    func_nome VARCHAR(100),
    func_comissao FLOAT
);

CREATE TABLE recebimento (
    recebimento_id INT AUTO_INCREMENT PRIMARY KEY,
    rec_data DATE,
    rec_valor DECIMAL(15, 4),
    rec_fk_codigo_fpagamento INT NOT NULL,
    rec_fk_ordemservico INT NOT NULL,
    FOREIGN KEY (rec_fk_codigo_fpagamento) REFERENCES fpagamento(fpagamento_id),
    FOREIGN KEY (rec_fk_ordemservico) REFERENCES ordem_servico(ordS_id)
);

create table estoque (
	est_id int primary key auto_increment,
    est_FK_prodServ int,
    estoque float,
	FOREIGN KEY (est_FK_prodServ) REFERENCES ordem_servico(ordS_id)
);

create table lucro (
	lucro_id int primary key auto_increment,
    lucro_FK_prodServ int,
    lucro float,
    FOREIGN KEY (lucro_FK_prodServ) REFERENCES ordem_servico(ordS_id)
);
#----------------------------------------------------------------------
create table agendamento(
	agen_id int primary key auto_increment,
    agen_dia date,
    agen_FK_animal int,
    agen_servico varchar(150),
    foreign key(agen_FK_animal) references animais(ani_id)
);

create table ranking(
	ranki_id int primary key auto_increment,
    ranki_FK_ani int,
    ranki_total float,
    foreign key ( ranki_FK_ani) references animais(ani_id)
);

create table animal_historico(
	his_id int primary key auto_increment,
    his_FK_ani int,
    hist_data date,
    hist_historico varchar(150),
    foreign key (his_FK_ani) references animais(ani_id)
);

create table logss(
	loggs_id int primary key auto_increment,
    logss_obs varchar(250),
	loggs_data_hora DATE
);
#-----------------------------------------------------------------

#INSERINDO EM RACA
INSERT INTO raca (raca_nome) VALUES
    ("Sianes"), ("Pitbull"), ("Laranja");
    
#Clientes 
INSERT INTO clientes(cli_nome, cli_endereco, cli_cpf, cli_bairro) VALUE ("Ana", "caminho y", 1234567890, "sobradinho"); 
INSERT INTO clientes(cli_nome, cli_endereco, cli_cpf, cli_bairro) VALUE ("leila", "caminhoX", 1234567891, "SIM"), ("Duda", "telegrafo", 1234567892, "centro");


#Animais
INSERT INTO animais(ani_nome, ani_idade, ani_sexo, animal_fk_cliente, animal_fk_raca) VALUE ("Nina", 3, "Feminino", 1, 1);
INSERT INTO animais(ani_nome, ani_idade, ani_sexo, animal_fk_cliente, animal_fk_raca) VALUE ("pou", 2, "Feminino", 1, 3); 
INSERT INTO animais(ani_nome, ani_idade, ani_sexo, animal_fk_cliente, animal_fk_raca) VALUE ("kitty", 4, "Feminino", 1, 1);

#Ordem do Serviço 
INSERT INTO ordem_servico(ordS_serv, ordS_total, ordS_serv_fk_animal) VALUE ("2023-08-22", 12.00, 1); 
INSERT INTO ordem_servico(ordS_serv, ordS_total, ordS_serv_fk_animal) VALUE ("2023-08-23", 22.00, 1);

#PRODUTO SERVICO
INSERT INTO produto_servico(prodS_nome, prodS_serv_tipo) VALUE ("Sabonete", "Produto"); 
INSERT INTO produto_servico(prodS_nome, prodS_serv_tipo) VALUE ("Banho", "Serviço");

#Item Ordem 
 INSERT INTO i_ordem_servico(i_ord_serv_fk_prod_serv, i_ord_serv_fk_ordem_serv, i_ordem_serv_quant, i_ordem_serv_valor) value (2, 1, 2, 32); 
 insert into i_ordem_servico(i_ord_serv_fk_prod_serv, i_ord_serv_fk_ordem_serv, i_ordem_serv_quant, i_ordem_serv_valor) VALUE (2, 1, 4, 21);
 INSERT INTO i_ordem_servico(i_ord_serv_fk_prod_serv, i_ord_serv_fk_ordem_serv, i_ordem_serv_quant, i_ordem_serv_valor) VALUE (1, 2, 3, 44);


#vacinas
INSERT INTO vacinas (vaci_nome, vaci_quant, vaci_prazo) VALUES
    ('V8',  7, 50);

INSERT INTO vacinas_aplicadas (vacina_ap_fk_vacina, vacina_ap_fk_animal) VALUES
    (1, 1);

INSERT INTO fpagamento (fpagamento_nome) VALUES
    ('Cartão de Crédito'),
    ('Dinheiro');


INSERT INTO funcionarios (func_nome, func_comissao) VALUES
    ('Pedro Santos', 0.03),
    ('Ana Silva', 0.03);


INSERT INTO recebimento (rec_data, rec_valor, rec_fk_codigo_fpagamento, rec_fk_ordemservico) VALUES
    ("2023-08-22", 20000, 1, 1 ),
    ("2023-08-21", 1500, 2, 1);


SELECT vaci_nome, vaci_prazo
FROM vacinas
WHERE MONTH(vaci_prazo) = MONTH(CURRENT_DATE()) + 1;

SELECT COUNT(*) AS ordS_total
FROM ordem_servico
WHERE MONTH(ordS_serv) = MONTH(CURRENT_DATE());

#CRIANDO UMA VIEW PARA VACINAS
CREATE VIEW ProdutosVencimento AS
SELECT vaci_nome, vaci_prazo
FROM vacinas
WHERE MONTH(vaci_prazo) = MONTH(CURRENT_DATE()) + 1;

#INSERINDO AUTOMATICAMENTE
insert into estoque (est_FK_prodServ, estoque) select prodS_id, 0 from produto_servico;

#PARA VISUALIZAR A VIEW
SELECT * FROM ProdutosVencimento;

#CRIANDO UM TRIGGER
create trigger tgr_ItensVendas_Insert_BaixaEstoque after insert
on i_ordem_servico
for each row
update estoque set estoque = estoque - new.i_ordem_serv_quant
where est_FK_prodServ = new.i_ord_serv_fk_prod_serv;


create trigger tgr_ItensVendas_Delete_Volta_estoque after delete
on  i_ordem_servico
for each row
update estoque set estoque = estoque + old.i_ordem_serv_quant
where est_FK_prodServ = old.i_ord_serv_fk_prod_serv;

#APAGAR
drop trigger tgr_ItensVendas_Delete_Volta_estoque;

INSERT INTO i_ordem_servico(i_ord_serv_fk_prod_serv, i_ord_serv_fk_ordem_serv, i_ordem_serv_quant, i_ordem_serv_valor) VALUE (1, 2, 3, 50);


#Criar uma Trigger para disparar o logs nas interações de INSERT, UPDATE, DELETE das tabelas principais:  Produto-Serviço, Ordem de serviço, Vacinas Aplicadas.

# LOGS DE PRODUTO SERVICO-----------------
 delimiter //
CREATE TRIGGER Trigger_LogsInsert
AFTER INSERT ON produto_servico
FOR EACH ROW
BEGIN
   INSERT INTO Loggs (logss_obs, loggs_data_hora) VALUES ('Ação realizada na tabela Produto servico',  NOW());
END;
//

delimiter //
CREATE TRIGGER Trigger_Loggs_Update
AFTER UPDATE ON Produto_Servico
FOR EACH ROW
BEGIN
  INSERT INTO Logs (logss_obs, loggs_data_hora) VALUES ('Atualização realizada na tabela Produto servico', NOW());
END;
//

delimiter //
CREATE TRIGGER Trigger_Loggs_Delete
AFTER DELETE ON Produto_Servico
FOR EACH ROW
BEGIN
  INSERT INTO Logs (logss_obs, loggs_data_hora) VALUES ('Exclusão realizada na tabela Produto servico', NOW());
END;
//

# LOGS DE ORDEM SERVICO-----------------
 delimiter //
CREATE TRIGGER Trigger_LogsInsert
AFTER INSERT ON ordem_servico
FOR EACH ROW
BEGIN
   INSERT INTO Loggs (logss_obs, loggs_data_hora) VALUES ('Ação realizada na tabela Produto servico',  NOW());
END;
//

delimiter //
CREATE TRIGGER Trigger_Loggs_Update
AFTER UPDATE ON ordem_servico
FOR EACH ROW
BEGIN
  INSERT INTO Logs (logss_obs, loggs_data_hora) VALUES ('Atualização realizada na tabela Produto servico', NOW());
END;
//

delimiter //
CREATE TRIGGER Trigger_Loggs_Delete
AFTER DELETE ON ordem_servico
FOR EACH ROW
BEGIN
  INSERT INTO Logs (logss_obs, loggs_data_hora) VALUES ('Exclusão realizada na tabela Produto servico', NOW());
END;
//

# LOGS DE VACINA APLICADAS-----------------
 delimiter //
CREATE TRIGGER Trigger_LogsInsert
AFTER INSERT ON vacinas_aplicadas
FOR EACH ROW
BEGIN
   INSERT INTO Loggs (logss_obs, loggs_data_hora) VALUES ('Ação realizada na tabela Produto servico',  NOW());
END;
//

delimiter //
CREATE TRIGGER Trigger_Loggs_Update
AFTER UPDATE ON vacinas_aplicadas
FOR EACH ROW
BEGIN
  INSERT INTO Logs (logss_obs, loggs_data_hora) VALUES ('Atualização realizada na tabela Produto servico', NOW());
END;
//

delimiter //
CREATE TRIGGER Trigger_Loggs_Delete
AFTER DELETE ON vacinas_aplicadas
FOR EACH ROW
BEGIN
  INSERT INTO Logs (logss_obs, loggs_data_hora) VALUES ('Exclusão realizada na tabela Produto servico', NOW());
END;
//

#ANIMAL HISTORICO--------------
delimiter //
CREATE TRIGGER Trigger_Animal_HisInsert
AFTER INSERT ON  vacinas_aplicadas
FOR EACH ROW
BEGIN
  INSERT INTO animal_historico (his_FK_ani, hist_data, hist_historico) VALUES (1, NOW(), 'acao realizada');
END;
//

#AGENDAMENTO ------------
delimiter //
CREATE TRIGGER Trigger_AgendamentoInsert
AFTER INSERT ON animais
FOR EACH ROW
BEGIN
  INSERT INTO agendamento (agen_dia, agen_FK_animal, agen_servico) VALUES (CURDATE(), 1, 'banho');
END;
//

#VIEWS ------------------------------------------------
#CRIANDO UMA VIEW Criar uma View  que retorna os animais agendados da semana.
create view aniAgendados as 
select *
from agendamento
WHERE agen_dia >= CURDATE() AND agen_dia < CURDATE() + INTERVAL 7 DAY;


#Criar uma View que retorna o Ranking dos animais que mais consumiram no Petshop no mês.
CREATE VIEW rankingMes AS
SELECT ranki_FK_ani, SUM(ranki_total) AS total_consumo
FROM ranking
GROUP BY ranki_FK_ani
ORDER BY total_consumo DESC;

#Criar uma View que retorna os logs.
CREATE VIEW logss AS
SELECT *
FROM logss;
#--------------------------------------------------------------------------------------------------





