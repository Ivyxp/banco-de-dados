create database veiculosJM;
use veiculosJM;

create table veiculo(
veiculo_id int primary key auto_increment,
veiculo_tipo varchar(60),
veiculo_modelo varchar(100),
veiculo_marca varchar(100),
veiculo_cor varchar(30),
veiculo_preco float,
veiculo_ano_fabrica date,
veiculo_km_rodado float,
veiculo_fpagamento varchar(100),
veiculo_leilao boolean
);