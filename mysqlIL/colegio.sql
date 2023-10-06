create database colegio;

use colegio;

create table alunos(
	alu_id int primary key auto_increment,
    alu_nome varchar(100),
    alu_curso varchar(80),
    alu_nota float
);

create table notas(
	notas_id int primary key auto_increment,
    notas_FK_aluno_id int,
    notas_notas float,
    constraint FK_notas foreign key (notas_FK_aluno_id) references alunos(alu_id)
);

create table materias(
	mat_id int primary key auto_increment,
    mat_nome varchar(100)
);

create table aluno_materia(recebimento
	amat_id int primary key auto_increment,
    amat_FK_materia int not null,
    amat_FK_aluno int not null,
    foreign key (amat_FK_materia) references materias(mat_id),
    foreign key (amat_FK_aluno) references alunos(alu_id)
);


#AVG RETORNA A MEDIA DE DETERMINADO Valores
select avg(alu_nota) as media_notas from alunos;

#SOMA
select sum(alu_nota) as total_notas from alunos;

#CONTA O NUMEROS DE LINHAS EM UMA TABELA
select count(*) as total from alunos;

#RETORNA O MENOR VALOR DE UMA TABELA
select min(alu_nota) as menor_nota from alunos;
#RETORNA O MAIOR VALOR DE UMA TABELA
select max(alu_nota) as max_mota from alunos;

select * from alunos
inner join notas on (alu_id = notas_FK_aluno_id);

insert into alunos (alu_nome,alu_curso,alu_nota) value ('jade', 'fotografia', 9), ('Todd', 'ed. fisica', 10),('Sam', 'fisica', 7);
select * from notas;

insert into notas (notas_FK_aluno_id, notas_notas) value (4,8),(5,8.5),(6,2.2),(7,9),(8,6.5),(8,10),(9,10),(10,9)
 




