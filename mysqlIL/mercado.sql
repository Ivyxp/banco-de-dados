create database sis_mercado;
use sis_mercado;

create table cliente (
 cli_codigo int primary key auto_increment,
 cli_nome varchar (100) not null,
 cli_email varchar (30),
 cli_tel varchar (15),
 total_compra float
 );
 
 select cli_codigo, cli_nome, total_compra from cliente;
 select * from cliente;
 insert into cliente (cli_nome, cli_email, total_compra) value ('LUA', 'lua@gmail.com', 10.00);
 insert into cliente (cli_nome, cli_email, total_compra) value ('ANA', 'ana@gmail.com', 12.00);
 insert into cliente (cli_nome, cli_email, total_compra) value ('BIA', 'bia@gmail.com', 15.00);
 insert into cliente (cli_nome, cli_email, total_compra) value ('OLIVIA', 'olivia@gmail.com', 19.00);
 
 delete from cliente
 where cli_codigo = 7
 
 
 
 
 