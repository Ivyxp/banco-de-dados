create database JM_veiculos;

use JM_veiculos;

create table cliente(
	cli_id int primary key auto_increment,
	cli_nome varchar(100),
	cli_endereco varchar(60),
    cli_cpf decimal(10,0),
    cli_tel decimal(10,0),
    cli_bairro varchar(60)
);

create table veiculo(
	veic_id int primary key auto_increment,
    veic_preco float,
    veic_FK_marc_id int not null,
    foreign key(veic_FK_marc_id) references marca(marc_id)
);

create table vendas(
	ven_id int primary key auto_increment,
	ven_data date,
	ven_total decimal,
	ven_FK_cliente int not null,
	ven_status tinyint,
    foreign key (ven_FK_cliente) references cliente(cli_id)
);

create table forma_pagamentos(
	fpag_id int primary key auto_increment,
    fpag_nome varchar(30)
);

create table marca(
	marc_id int primary key auto_increment,
    marc_nome varchar(100)
);

create table modelo(
	mod_id int primary key auto_increment,
    mod_nome varchar(100),
    mod_FK_marc int not null,
	foreign key (mod_FK_marc) references marca(marc_id)
);

create table itens_venda(
	iven_id int primary key auto_increment,
    iven_valor float
);

create table recebimento(
	rec_id int primary key auto_increment,
    rec_data date,
    rec_valor decimal(15,4),
    rec_fk_venda int not null,
    rec_fk_formapag int not null,
    foreign key (rec_fk_venda) references vendas(ven_id),
    foreign key (rec_fk_formapag) references forma_pagamentos(fpag_id)
);

insert into cliente (cli_nome, cli_endereco, cli_cpf, cli_tel, cli_bairro,cli_email) value ('OLIVIA', 'cidade nova ', '956658844','55669944','SIM', 'olivia@gmail.com'), ('Bia', 'avenida pricipal', '369852258','55669944','SIM', 'bia@gmail.com'),
('caio', 'caminho 23', '547854569','845758743','SIM', 'caio@gmail.com');
 
 insert into marca(marc_nome) value ('Fiat'), ('Fiat'), ('Fiat'), ('Hyundai'), ('Hyundai');
 
 insert into modelo (mod_nome, mod_FK_marc) value ('Uno', 1),('Mustang', 2), ('Civic',3),('Tucson',4), ('Onix',5);

insert into veiculo(veic_preco, veic_FK_marc_id) value (40000,1), (563000,2), (244900,3), (223990,4), (92658,5);

insert into forma_pagamentos (fpag_nome) value ('dinheiro'),  ('debito'),  ('credito'),  ('pix'),  ('cheque');

insert into vendas (ven_data, ven_total, ven_FK_cliente, ven_status) value('2023-08-29', 400000, 1, true),('2023-08-29', 940000, 2, true);

insert into recebimento(rec_data, rec_valor, rec_fk_venda, rec_fk_formapag) value ('2023-08-29',  355, 1, 1), ('2023-08-29',  5000, 2, 3) 

