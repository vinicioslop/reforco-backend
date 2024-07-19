create database bd_loja;
use bd_loja;

create table tb_cliente (
cpf_cliente char(11) primary key,
nm_cliente varchar(45) not null,
nr_fone varchar(11) not null
);

create table tb_nota (
cd_nota int primary key auto_increment,
dt_nota date not null,
vl_total decimal(8,2) not null,
fk_cpf_cliente char(11),
foreign key (fk_cpf_cliente) references tb_cliente (cpf_cliente)
);

create table tb_produto (
cd_produto int primary key auto_increment,
nm_produto varchar(45) not null,
vl_produto decimal(5,2) not null,
dt_validade date
);

create table tb_item (
cd_item int primary key auto_increment,
qt_produto int not null,
vl_item decimal(6,2) not null,
fk_cd_nota int,
foreign key (fk_cd_nota) references tb_nota (cd_nota),
fk_cd_produto int,
foreign key (fk_cd_produto) references tb_produto (cd_produto)
);
