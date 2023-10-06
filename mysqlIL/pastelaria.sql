create database pastelaria2;
use pastelaria2;

create  table estados(
    est_id int primary key auto_increment,
    est_nome varchar(100)
);

create table cidade(
    cid_id int primary key auto_increment,
    cid_nome varchar(100),
    cid_FK_estado int not null,
    foreign key(cid_FK_estado) references estados(est_id)
);

create table cliente (
    cli_id int primary key auto_increment,
    cli_nome_completo varchar(255),
    cli_nome_preferencia varchar(255),
    cli_cpf decimal(15),
    cli_data date,
    cli_tel decimal(11),
    cli_email varchar(255),
    cli_bairro varchar(150),
    cli_FK_cid int,
    foreign key(cli_FK_cid ) references cidade(cid_id)
);

create table categoria(
   cat_id int primary key auto_increment,
   cat_categoria varchar(120)
);

create table vendas(
   ven_id int primary key auto_increment,
   ven_data date,
   ven_total decimal,
   ven_cliente int,
   ven_status tinyint,
   foreign key(ven_cliente) references cliente(cli_id)
);

create table recebimento(
    rec_id int primary key auto_increment,
    rec_data date,
    rec_valor decimal(15,4),
    rec_fk_id_venda int,
    rec_fk_id_formapag int
);

create table forma_pagamentos(
    fpag_id int primary key auto_increment,
    fpag_nome varchar(30)
);

create table tipo (
    tp_id int primary key auto_increment,
    tp_tipo varchar(125)
);

create table sabor(
    sb_id int primary key auto_increment,
    sb_sabor varchar(255)
);

create table produto(
    prod_id int primary key auto_increment,
    prod_nome varchar(100),
    prod_preco float,
    prod_tamanho varchar(255),
    prod_FK_categoria int,
    prod_FK_tipo int,
    prod_FK_sabor int,
    foreign key(prod_FK_categoria ) references categoria(cat_id),
    foreign key(prod_FK_tipo) references tipo(tp_id),
    foreign key(prod_FK_sabor) references sabor(sb_id)
);

create table itens_venda(
    iven_id int primary key auto_increment,
    iven_valor float,
    iven_desconto decimal(15,4),
    iven_total decimal(15,4),
    iven_FK_produto int,
    iven_fk_venda int,
    foreign key(iven_FK_produto) references produto(prod_id),
    foreign key(iven_fk_venda) references vendas(ven_id)
);

create table estoque (
    est_id int primary key auto_increment,
    est_FK_prod int,
    estoque int,
    FOREIGN KEY (est_FK_prod) REFERENCES produto(prod_id)
);

create table pedido_realizado(
    pr_id int primary key auto_increment,
    pr_FK_cliente int,
    pr_FK_prod int,
    pr_FK_pag int,
    pr_data date,
    foreign key(pr_FK_cliente) references cliente(cli_id),
    foreign key(pr_FK_prod) references produto(prod_id),
    foreign key(pr_FK_pag) references forma_pagamentos(fpag_id)
);

INSERT INTO estados (est_nome)
VALUES ('São Paulo'),
       ('Rio de Janeiro'),
       ('Minas Gerais');
       
INSERT INTO cidade (cid_nome, cid_FK_estado)
VALUES ('São Paulo', 1),
       ('Campinas', 1),
       ('Rio de Janeiro', 2),
       ('Belo Horizonte', 3);
       
INSERT INTO cliente (cli_nome_completo, cli_nome_preferencia, cli_cpf, cli_data, cli_tel, cli_email, cli_bairro, cli_FK_cid)
VALUES ('João Silva', 'João', 12345678901, '1990-01-15', 999999999, 'joao@email.com', 'Centro', 1),
       ('Maria Santos', 'Maria', 98765432109, '1985-04-20', 888888888, 'maria@email.com', 'Copacabana', 3);
       
      
INSERT INTO cliente (cli_nome_completo, cli_nome_preferencia, cli_cpf, cli_data, cli_tel, cli_email, cli_bairro, cli_FK_cid)
VALUES ('Leticia Lima', 'Leticia', 31345678908, '2002-09-15', 777777777, 'leticia@email.com', 'Feira IV', 2);
       
INSERT INTO categoria (cat_categoria)
VALUES ('Pastel'),
       ('Refrigerante');
       
INSERT INTO tipo (tp_tipo)
VALUES ('Vegano'),
       ('Vegetariano'),
       ('Comun');
       
      
INSERT INTO tipo (tp_tipo)
VALUES ('Lata'),
       ('Vidro'),
       ('guarrafa');
       
       
INSERT INTO sabor (sb_sabor)
VALUES ('Queijo'),
       ('Frango'),
       ('Misto'),
       ('Queijo e presunto'),
       ('Palmito com queijo'); 
       
       
       
INSERT INTO sabor (sb_sabor)
VALUES ('Cola'),
       ('Limao'),
       ('Guarana'),
       ('Laranja'); 
       
             
INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria, prod_FK_tipo, prod_FK_sabor)
VALUES ('pastel de queijo', 5, 'media', 1, 3, 1);

            
INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria, prod_FK_tipo, prod_FK_sabor)
VALUES ('pastel de queijo', 5, 'media', 1, 1, 1);

INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria, prod_FK_sabor)
VALUES  ('goob', 6, '2L', 2,2);   


INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria,prod_FK_tipo ,prod_FK_sabor)
VALUES  ('iti', 3, '1L', 2, 2,4);   


INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria, prod_FK_tipo, prod_FK_sabor)
VALUES ('pastel de palmito', 6, 'pequeno', 1, 1, 10);


INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria, prod_FK_tipo, prod_FK_sabor)
VALUES ('pastel de palmito', 10, 'grande', 1, 1, 10);


INSERT INTO produto (prod_nome, prod_preco, prod_tamanho, prod_FK_categoria, prod_FK_tipo, prod_FK_sabor)
VALUES ('Pastel de Queijo', 3.50, 'Grande', 1, 3, 1),
       ('Pastel de Carne', 4.00, 'Grande', 1, 3, 2),
       ('Pastel de Presunto', 3.50, 'Grande', 1, 3, 3),
       ('Pastel de Frango', 4.00, 'Grande', 1, 3, 4),
       ('Pastel de Calabresa', 4.00, 'Grande', 1, 3, 5),
       ('Coca-Cola', 5.00, 'Lata', 2, 3, 2),
       ('Guaraná', 4.50, 'Lata', 2, 3, 3);

    
INSERT INTO forma_pagamentos (fpag_nome)
VALUES ('Cartão de Crédito'),
       ('Dinheiro'),
       ('Pix');
       
 
INSERT INTO estoque (est_FK_prod, estoque)
VALUES (1, 10),
       (2, 15),
       (3, 5),
       (4, 8),
       (5, 3),
       (6, 20),
       (7, 18);      
       
       
INSERT INTO pedido_realizado(pr_FK_cliente, pr_FK_prod, pr_FK_pag, pr_data)
VALUE (1, 1, 3,"2023-09-29" );
      
INSERT INTO vendas(ven_data, ven_total, ven_cliente, ven_status)
VALUE ("2023-09-29", 3, 1, 1);
      
INSERT INTO itens_venda(iven_valor, iven_desconto, iven_total, iven_FK_produto, iven_fk_venda)
VALUE (5, 1, 15,2,1 );


INSERT INTO itens_venda (iven_valor, iven_desconto, iven_total, iven_FK_produto, iven_fk_venda)
VALUES (3.50, 0.00, 3.50, 1, 1),
       (4.00, 0.00, 4.00, 2, 1),
       (5.00, 0.00, 5.00, 6, 2);


#******************* SELECTS

SELECT COUNT(*) AS total_pasteis_veganos
FROM itens_venda iv
JOIN produto p ON iv.iven_FK_produto = p.prod_id
JOIN vendas v ON iv.iven_fk_venda = v.ven_id
JOIN cliente c ON v.ven_cliente = c.cli_id
WHERE p.prod_FK_tipo = 1
  AND c.cli_data <= DATE_SUB(CURDATE(), INTERVAL 18 YEAR); 
  
  
  
SELECT 
    MONTH(pr_data) AS mes,
    cli_nome_completo,
    COUNT(*) AS numero_pedidos
FROM pedido_realizado 
JOIN cliente ON cli_id = pr_FK_cliente
WHERE YEAR(pr_data) = YEAR(CURDATE())
GROUP BY mes, cli_nome_completo
ORDER BY numero_pedidos DESC;


SELECT prod_nome, sb_sabor AS ingredientes
FROM produto
JOIN sabor ON sb_id = prod_FK_sabor
WHERE prod_FK_sabor = 1 OR prod_FK_sabor = 9;


SELECT SUM(prod_preco) AS valor_venda_total
FROM produto;


SELECT pr.pr_id, pr.pr_data
FROM pedido_realizado pr
JOIN itens_venda iv1 ON iv1.iven_fk_venda = pr.pr_id
JOIN produto p1 ON p1.prod_id = iv1.iven_FK_produto
JOIN categoria c1 ON c1.cat_id = p1.prod_FK_categoria
JOIN itens_venda iv2 ON iv2.iven_fk_venda = pr.pr_id
JOIN produto p2 ON p2.prod_id = iv2.iven_FK_produto
JOIN categoria c2 ON c2.cat_id = p2.prod_FK_categoria
WHERE c1.cat_categoria = 'Pastel' AND c2.cat_categoria = 'Refrigerante';
  
  
SELECT prod_nome, COUNT(iven_id) AS quantidade_vendas
FROM produto 
JOIN itens_venda ON iven_FK_produto = prod_id
GROUP BY prod_id, prod_nome
ORDER BY quantidade_vendas ASC;
