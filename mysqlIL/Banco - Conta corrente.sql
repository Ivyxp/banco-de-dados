CREATE DATABASE bank;	

USE bank;

CREATE TABLE bancos (
             cod_bank INT NOT NULL AUTO_INCREMENT,
			  banco VARCHAR (45) NOT NULL,
			  CNPJ BIGINT NOT NULL UNIQUE,
              PRIMARY KEY (cod_bank)
                    );
CREATE TABLE correntista (
			  Id INT NOT NULL AUTO_INCREMENT,
              nome VARCHAR (45) NOT NULL, 
              conta INT NOT NULL UNIQUE, 
              cod_banco INT NOT NULL,
              PRIMARY KEY (Id), 
              CONSTRAINT fk_b_client
              FOREIGN KEY (cod_banco)
              REFERENCES bancos (cod_bank)
                          );
CREATE TABLE movimentacao (
              cod_mov INT NOT NULL AUTO_INCREMENT,
              deposito DECIMAL (10,2) NOT NULL,
                 saque DECIMAL (10,2) NOT NULL,
		      saldo_atual DECIMAL (10,2) NOT NULL,
                 mov_bank INT NOT NULL,
                 mov_user INT NOT NULL,
				PRIMARY KEY (cod_mov),
                  CONSTRAINT fk_mov
                FOREIGN KEY (mov_bank)
		  REFERENCES bancos (cod_bank),
                 CONSTRAINT fk_user
                 FOREIGN KEY (mov_user)
		  REFERENCES correntista (Id)
                             );

 INSERT INTO bancos VALUES (null, ' BRB ', 0000001);
 INSERT INTO bancos VALUES (null, ' Santader ', 0000002);
 INSERT INTO bancos VALUES (null, ' MP ', 0000003);
 INSERT INTO bancos VALUES (null, 'Next ', 0000004);
 
 INSERT INTO correntista VALUES (null, 'Pablo',188,0000004);
 INSERT INTO correntista VALUES (null, 'Tales',266,0000004);
 INSERT INTO correntista VALUES (null, 'Yuri',178,0000002);
 INSERT INTO correntista VALUES (null, 'Boquinha',122,0000003);
 
    -- Criação de Trigger
    
CREATE TRIGGER dinheiro BEFORE INSERT 
           ON movimentacao
   FOR EACH ROW 
SET new.saldo_atual = (new.deposito - new.saque);

INSERT INTO movimentacao VALUES (null,2000,1000,null,0000004,1);
INSERT INTO movimentacao VALUES (null,2000,1000,null,0000004,3);
INSERT INTO movimentacao VALUES (null,2000,1000,null,0000002,2);
INSERT INTO movimentacao VALUES (null,2000,1000,null,0000003,4);        
		SELECT * FROM movimentacao ;

		-- 1º Quantos Úsuarios cadastrados?
SELECT count(id) FROM correntista;
        -- 2º Quantos Bancos cadastrados?
SELECT count(cnpj) FROM bancos;
        -- 3º Quantas Transações efetuadas?
SELECT count(cod_mov) FROM movimentacao;
        -- 4º Qual o Total de transações efetuadas?
SELECT sum(saldo_atual+saque+deposito) FROM movimentacao;    
	   -- 5º Qual o total de saques efetuados?
SELECT sum(saque) FROM  movimentacao; 
       -- 6º Qual o total de deposito efetuados?
SELECT sum(deposito) FROM movimentacao;
       -- 7º Qual a media de depositos efetuados?
SELECT avg(deposito) FROM movimentacao;
       -- 8º Qual a media de saques efetuados?
SELECT avg(saque) FROM movimentacao;
	   -- 9º Qual a media dos saldos atualizados efetuados?
SELECT avg(saldo_atual) FROM movimentacao;
       -- 10º Qual a media das tranções efetuadas?
SELECT avg(deposito+saque+saldo_atual) FROM movimentacao;	
       -- 11º Qual o valor do maior saque?
SELECT max(saque) FROM movimentacao;
       -- 12º Qual o valor do maior deposito?
SELECT max(deposito) FROM movimentacao;
       -- 13º Qual a conta com maior valor de saldo atual?
SELECT nome, conta, banco,max(saldo_atual) AND min(saque)
FROM correntista, bancos, movimentacao;
       