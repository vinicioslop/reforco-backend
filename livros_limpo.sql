create database db_livraria;

use db_livraria;

create table tb_autor(
	id_autor int primary key,
	nome varchar(45),
	nr_fone varchar(15),
	pais varchar(45)
);

create table tb_categoria(
	id_categoria int primary key,
	nm_categoria varchar(45),
	ds_categoria varchar(150)
);

create table tb_livro(
	id_livro int primary key,
	titulo varchar(45),
	ano year,
	ds_livro varchar(100),
	fk_idautor int,
	fk_idcategoria int,
	foreign key (fk_idcategoria) references tb_categoria (id_categoria),
	foreign key (fk_idautor) references tb_autor (id_autor)
);

-- Registro Autores
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (001, 'Takehiko Inoue', 'Japao', 59867537);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (002, 'Machado de Assis', 'Brasil', 90347633);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (003, 'Antoine de Saint-Exupery', 'França', 02745362);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (004, 'J. K. Rowling', 'Reino Unido', 74739478);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (005, 'Inio Asano', 'Japao', 02393746);
 
-- Registro Categorias
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (001, 'Drama', 'Uma historia dramatica');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (002, 'Ficcao', 'Fuja da realidade');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (003, 'Fabula', 'Historias infantis');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (004, 'Aventura', 'Conheça novos lugar');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (005, 'Romance e suspense', 'Uma trama');

-- Registro Livros
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (001, 'Vagabond', 'Uma historia dramatica','1998', 001, 001);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (002, 'O Alienista', 'Fuja da realidade', '1982', 002, 002);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (003, 'O Pequeno Príncipe', 'Historias infantis', '1943', 003, 003);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (004, 'Harry Potter', 'Conheça novos lugar', '1997', 004, 004);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (005, 'Boa Noite Punpun', 'Uma trama','2007', 005, 005);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (006, 'Sense Life', 'Conheça novos lugar','2020', 004, 004);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (007, 'Mob Psycho 100', 'Fuja da realidade','2012', 002, 002);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (008, 'A Girl on the Shore Collectors Edition', 'Uma trama','2023', 005, 005);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (009, 'Dom Quixote', 'Historias infantis','1999', 003, 003);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (010, 'Dead Dead Demons de Dedede Destruction', 'Ficcao','2014', 002, 002);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (011, 'Chainsaw Man', 'Aventura','2022', 004, 004);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (012, 'Jujutsu Kaisen', 'Aventura','2018', 004, 004);