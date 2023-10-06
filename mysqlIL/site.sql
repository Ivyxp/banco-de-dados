create database site;

use site;

create table usuario(
	user_cod int primary key auto_increment,
    user_nome varchar(100),
    user_senha varchar(10),
    user_nivel int(11)
);

create table produto(
	prod_codigo int primary key auto_increment,
    prod_nome varchar(100),
    prod_preco float,
    prod_unidade_medida int(11),
    prod_cod_barras varchar(13),
    prod_departamento int(11),
    prod_estoque decimal(15,4)
);

create table unidade_medida(
	uni_codigo int primary key auto_increment,
    uni_nome varchar(100)
);

create table departamentos(
	dep_codigo int primary key auto_increment,
    dep_nome varchar(100)
);

create table itens_venda(
	iven_codigo int primary key auto_increment,
    iven_valor decimal(15,4),
    iven_desconto decimal(15,4),
    iven_total decimal(15,4),
    iven_produto int,
    iven_fk_venda int
);

create table cliente(
	cli_codigo int primary key auto_increment,
    cli_nome varchar(100),
    cli_endereco varchar(60),
    cli_cpf decimal(10,0),
    cli_tel decimal(10,0),
    cli_bairro varchar(60),
    cli_num_casa varchar(10),
    cli_fk_cidade_codigo int
    
);

create table vendas(
		ven_codigo int primary key auto_increment,
		ven_data date,
		ven_total decimal,
		ven_cliente int,
		ven_status tinyint
);

create table recebimento(
	rec_codigo int primary key auto_increment,
    rec_data date,
    rec_valor decimal(15,4),
    rec_fk_codigo_venda int,
    rec_fk_codigo_formapag int
);

create table forma_pagamentos(
	fpag_codigo int primary key auto_increment,
    fpag_nome varchar(30)
);

create table cidade(
	cid_codigo int primary key auto_increment,
    cid_nome varchar(100),
    cid_fk_estado int
);

create  table estados(
	est_codigo int primary key auto_increment,
    est_nome varchar(100)
);

 
alter table vendas
add constraint FK_vends
	foreign key(ven_cliente)
    references cliente(cli_codigo);

#tabela que vai ser modificada
alter table cidade
# nome para a chave estrangeira que ficara nessa tabela
add constraint FK_cid
# a chave estrangeira da tabela que esta sendo alterada
	foreign key(cid_fk_estado)
# referenciando a chave primaria da outra tabela
    references cliente(cli_codigo);
    
alter table produto
add constraint FK_uniprodd
	foreign key(prod_unidade_medida)
    references unidade_medida(uni_codigo);
 
 #inserindo valor
 insert into departamentos(dep_nome) value ('Alimento'),('Limpeza');

 insert into unidade_medida(uni_nome) value('KG'),('LT'),('UN'),('MT');
 
 insert into produto (prod_nome, prod_preco, prod_unidade_medida, prod_cod_barras ,prod_departamento, prod_estoque) value ('macarrao',3.00,9,'75845211111',1,50);
 
select * from produto
#juntando as duas tabelas
inner join departamentos on(dep_codigo = prod_departamento)
inner join unidade_medida on (uni_codigo = prod_unidade_medida);

insert into produto (prod_nome, prod_preco, prod_unidade_medida, prod_cod_barras ,prod_departamento, prod_estoque) value ('Cuscuz',1.60,9,'65144178965',1,20);

insert into estados(est_nome) value ('Bahia'),('Sao paulo'),('Rio de janeiro');

insert into cidade(cid_nome,cid_fk_estado) value ('Feira de santana', 7);
insert into cidade(cid_nome,cid_fk_estado) value ('Sao paulo',8),('Niteroi',9);

insert into cliente(cli_nome,cli_endereco,cli_cpf,cli_tel,cli_bairro,cli_num_casa,cli_fk_cidade_codigo) value ('Bea', 'Sim', '9566588443','55669944','SIM', 12,7);

select * from cidade
inner join estados on (est_codigo = cid_fk_estado )

inner join cliente on (cli_codigo = cli_fk_cidade_codigo);

select * from cliente
