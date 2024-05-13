create database estacionamento;
use estacionamento;

create table clientes(
cpf varchar(14) primary key,
nome varchar(50),
dataNascimento varchar(10)
);

create table modelos(
codigoModelo int(1) primary key,
descricaoModelo varchar(10)
);

create table patios(
numeroPatio int(1) primary key,
enderecoPatio varchar(5),
numeroVagas int(2)
);

create table veiculos(
placa varchar(8) primary key,
modelo int(1),
cpf varchar(14),
cor varchar(10),
ano varchar(4)
);

create table estacionamentos(
codigoServico int(2) primary key,
numeroPatio int(1),
placa varchar(8),
dataEntrada varchar(10),
dataSaida varchar(10),
horaEntrada time,
horaSaida time
);

insert into clientes(cpf, nome, dataNascimento)values
("123.456.789-01", "Wagner Toth", "1981-05-23"),
("234.567.890-12", "Lucas Guedes", "1996-08-18"),
("345.678.901-23", "Antonio Henrique Marcondes", "1998-03-27"),
("456.789.012-34", "Andre Oliveira", "1998-02-15");

insert into modelos(codigoModelo, descricaoModelo)values
(1, "Sedan"),
(2, "Hatch"),
(3, "SUV"),
(4, "Utilitários"),
(5, "Moto");

insert into patios(numeroPatio, enderecoPatio, numeroVagas)values
(1, "Rua A", 20),
(2, "Rua B", 25),
(3, "Rua C", 40),
(4, "Rua D", 30);

insert into veiculos(placa, modelo, cpf, cor, ano)values
("ABC-1A23", 1, "123.456.789-01", "Preto", 2000),
("BAC-2834", 2, "234.567.890-12", "Azul", 2020),
("CBA-3C45", 3, "345.678.901-23", "Branco", 2021),
("BCA-4056", 4, "456.789.012-34", "Preto", 2019),
("ACB-5E67", 5, "123.456.789-01", "Branco", 2020),
("CAB-6F78", 1, "345.678.901-23", "Vermelho", 2019),
("AAA-7689", 3, "456.789.012-34", "Cinza", 2005);

insert into estacionamentos(codigoServico, numeroPatio, placa, dataEntrada, dataSaida, horaEntrada, horaSaida)values
(1,1, 'ABC-1A23', '2021-01-03', '2021-01-03', '08:00:30', '08:05:59'),
(2,2, 'BAC-2834', '2020-12-24', '2020-12-27', '18:50:00', '12:35:30'),
(3,3, 'CBA-3C45', '2020-12-31', '2021-01-02', '15:05:25', '17:00:34'),
(4,4, 'BCA-4056', '2021-01-02', '2021-01-02', '08:40:12', '18:34:21'),
(5,1, 'ACB-5E67', '2021-02-01', '2021-02-01', '09:30:13', '09:35:20'),
(6,1, 'CAB-6F78', '2021-02-05', '2021-02-05', '10:05:35', '12:45:36'),
(7,1, 'AAA-7689', '2021-02-10', '2021-02-10', '11:12:45', '12:00:00'),
(8,2, 'BAC-2834', '2021-01-08', '2021-01-08', '10:45:36', '11:05:55'),
(9,2, 'ACB-5E67', '2021-01-15', '2021-01-15', '09:23:45', '10:30:56'),
(10,3, 'CBA-3C45', '2021-01-03', '2021-01-03', '08:02:34', '11:34:35'),
(11,4, 'AAA-7689', '2021-01-04', '2021-01-04', '07:59:59', '17:59:59'),
(12,4, 'CAB-6F78', '2021-02-15', null, '06:30:28', null),
(13,2, 'BAC-2834', '2021-02-18', null, '09:59:30', null),
(14,3, 'ABC-1A23', '2021-02-14', null, '11:59:20', null),
(15,1, 'BCA-4056', '2021-01-30', '2021-01-30', '16:34:58', '19:45:38');
#1º
Select numeroPatio, count(numeroPatio) as Quantidade from estacionamentos group by numeroPatio;
#2º
Select clientes.nome, estacionamentos.placa, estacionamentos.dataEntrada, estacionamentos.dataSaida from clientes 
inner join veiculos on veiculos.cpf = clientes.cpf 
inner join estacionamentos on estacionamentos.placa = veiculos.placa
order by estacionamentos.numeroPatio;

#3º
Select clientes.nome, modelos.descricaoModelo, veiculos.placa from clientes
inner join veiculos on veiculos.cpf = clientes.cpf 
inner join modelos on modelos.codigoModelo = veiculos.modelo
order by clientes.nome;

#4º
Select sum(numeroVagas)AS Toal_Vagas from patios;

#5º
Select estacionamentos.numeroPatio, estacionamentos.dataEntrada, estacionamentos.dataSaida, estacionamentos.placa from estacionamentos 
inner join veiculos using(placa) where veiculos.cpf = "123.456.789-01";
 
#6º
Select clientes.nome, estacionamentos.placa, estacionamentos.numeroPatio, estacionamentos.dataEntrada, estacionamentos.dataSaida from clientes
inner join veiculos using(cpf)
inner join estacionamentos using(placa)
WHERE estacionamentos.dataEntrada BETWEEN '2020-01-01' AND '2020-12-31'
AND estacionamentos.dataSaida BETWEEN '2020-01-01' AND '2020-12-31';

#7º
select clientes.nome, estacionamentos.placa, estacionamentos.numeroPatio, estacionamentos.dataEntrada, estacionamentos.dataSaida from clientes
inner join veiculos using(cpf)
inner join estacionamentos using (placa)
WHERE estacionamentos.dataEntrada BETWEEN '2020-01-01' AND '2020-12-31'
AND estacionamentos.dataSaida BETWEEN '2020-01-01' AND '2020-12-31';

 
#8º
select clientes.nome, modelos.descricaoModelo, veiculos.placa, veiculos.cor, estacionamentos.dataEntrada,
estacionamentos.horaEntrada, estacionamentos.dataSaida, estacionamentos.horaSaida, estacionamentos.numeroPatio, patios.enderecoPatio from clientes
inner join veiculos using(cpf)
inner join modelos on veiculos.modelo = modelos.codigoModelo
inner join estacionamentos using(placa)
inner join patios using(numeroPatio) where modelos.descricaoModelo = "Moto";

 
#9º
select clientes.nome, modelos.descricaoModelo, veiculos.cor, veiculos.placa from clientes
inner join veiculos using(cpf)
inner join modelos on veiculos.modelo = modelos.codigoModelo where modelos.descricaoModelo = "Sedan";
 
#10º
select veiculos.placa, modelos.descricaoModelo, veiculos.cor, clientes.nome, estacionamentos.dataEntrada,
estacionamentos.horaEntrada, estacionamentos.dataSaida, estacionamentos.horaSaida, estacionamentos.numeroPatio from clientes
inner join veiculos using(cpf)
inner join modelos on veiculos.modelo = modelos.codigoModelo
inner join estacionamentos using (placa) where estacionamentos.dataSaida is null;  