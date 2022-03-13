create database casaselementais;
use casaselementais;

create table poder (
	idPoder int primary key auto_increment,
    nome varchar(45),
    descricao varchar(45),
    fkElemento int
) auto_increment = 1000;

create table elemento (
	idElemento int primary key auto_increment,
	nome varchar(45)
) auto_increment = 100;

create table lider (
	idLider int primary key auto_increment,
    nome varchar(45),
    dataNasc date,
    experiencia varchar(45),
    constraint experiencia_chk check (experiencia = 'baixa' or experiencia = 'media' or experiencia = 'alta'),
    fkElemento int
) auto_increment = 10;

create table exercito (
idExercito int primary key auto_increment,
tamanho varchar (10),
constraint tamanho_chk check (tamanho = 'pequeno' or tamanho = 'medio' or tamanho = 'grande'),
fkLider int
);

create table casa (
idCasa int primary key auto_increment,
nome varchar (45),
fkExercito int
) auto_increment = 500;

create table batalha (
idBatalha int primary key auto_increment,
nome varchar (45)
)auto_increment = 50;

create table resultado (
fkCasaAtacante int,
fkCasaDefesa int,
fkBatalha int,
fkVencedora int, 
fkPeriodo int,
dataBatalha date
); 

create table periodo(
idPeriodo int primary key auto_increment,
descricao varchar (45),
constraint periodo_chk check (descricao = 'dia' or descricao = 'noite')
);

insert into periodo values
(null,'dia'),
(null,'noite');

insert into elemento values
(null,'água'),
(null,'terra'),
(null,'fogo'),
(null,'ar');

insert into poder values
(null,'Barreira de Água','Defesa',100),
(null,'Canhão de Água','Ataque',100),
(null,'Escudo Rochoso','Defesa',101),
(null,'Espinhos de Pedra','Ataque',101),
(null,'Trilha de Fogo','Defesa',102),
(null,'Chama do Dragão','Ataque',102),
(null,'Vendaval Cortante','Defesa',103),
(null,'Furia de Ar','Ataque',103);

insert into casa values
(null,'Magnus',1),
(null,'Acquas',2),
(null,'Terranos',3),
(null,'Sopranos',4);

insert into exercito values
(null, 'medio', 10),
(null, 'pequeno', 11),
(null, 'medio', 12),
(null, 'grande', 13);

insert into lider values
(null, 'Chamusco', '1650-04-02', 'media', 102),
(null, 'Remus', '1644-02-15', 'alta', 100),
(null, 'Floriano', '1665-05-16', 'baixa', 101),
(null, 'Arnaldo', '1661-05-25', 'media', 103);

insert into batalha values
(null, 'Água Negra'),
(null, 'Batalha das 100 noites'),
(null, 'Guerra dos Complementos'),
(null, 'Vendaval de Fogo'),
(null, 'Batalha dos Opostos'),
(null, 'Batalha Maremoto'),
(null, 'Floresta de Chamas'),
(null, 'Batalha das cinzas'),
(null, 'Águas Flutuantes'),
(null, 'Terra em Chamas');

insert into resultado values
(501, 502, 50, 501, 2, '1702-10-02'),
(500, 502, 51, 502, 2, '1700-05-23'),
(503, 500, 52, 500, 1, '1704-07-15'),
(500, 503, 53, 503, 2, '1704-09-15'),
(501, 500, 54, 501, 1, '1705-11-09'),
(503, 501, 55, 501, 2, '1707-01-01'),
(500, 502, 56, 500, 2, '1705-11-20'),
(503, 502, 57, 503, 1, '1708-04-29'),
(501, 503, 58, 501, 2, '1708-09-02'),
(502, 500, 59, 500, 1, '1710-10-10');

select*from resultado;
select*from batalha;
select*from lider;
select*from exercito;
select*from casa;
select*from elemento;
select*from periodo;
select*from poder;

alter table poder add foreign key (fkElemento) references elemento(idElemento);
alter table lider add foreign key (fkElemento) references elemento(idElemento);
alter table exercito add foreign key (fkLider) references lider(idLider);
alter table casa add foreign key (fkExercito) references exercito(idExercito);
alter table resultado add foreign key (fkCasaAtacante) references casa(idCasa);
alter table resultado add foreign key (fkCasaDefesa) references casa(idCasa);
alter table resultado add foreign key (fkBatalha) references batalha(idBatalha);
alter table resultado add foreign key (fkVencedora) references casa(idCasa);
alter table resultado add foreign key (fkPeriodo) references periodo(idPeriodo);