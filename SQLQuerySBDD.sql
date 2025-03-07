create database EmpresaSBDD;
use EmpresaSBDD;

create table Cliente(
DNI Varchar(20),
Nombre Varchar (20), 
Apellido Varchar(20),
Telefono Varchar(9),
Direccion Varchar(30),
constraint Pk_cliente primary key (DNI)
); 

create table Pedido(
Fecha date not null,
DNI Varchar(20) not null, 
NumPedido int,
MetodoPago Varchar(20),
Estado Varchar(15),

constraint Pk_pedido primary key (Fecha),
constraint FK_cliente foreign key (DNI) references Cliente (DNI)
);

create table Articulo(
NumSerie Varchar(20),
Nombre_Articulo Varchar(20),
Descripcion Varchar(50),
Precio int,
Categoria Varchar(20),

constraint Pk_articulo primary key (NumSerie)
);

create table Articulo_Conforma(
Fecha date not null,
NumSerie Varchar(20) not null,
Cantidad int,

constraint FK_pedido foreign key (Fecha) references Pedido (Fecha),
constraint FK_articulo foreign key (NumSerie) references Articulo (NumSerie)
);

drop table Articulo_Conforma;
drop table Pedido;
drop table Cliente;
drop table Articulo;

insert into Cliente values
('017', 'Alondra', 'Vazquez','568794123', 'Polanco Num.99'),
('022', 'Monse', 'Rodriguez','525128532', 'Gustavo A.Madero Num.302'),
('094', 'Alan', 'Díaz', '569815378', 'Roma Sur Num.101'),
('076', 'Jimena', 'Alvarez', '512945517', 'San Juan de Aragón Num.12'),
('051', 'Cassandra', 'Luna', '546632249', 'Xochimilco Num.87'),
('038', 'Guillermo', 'Camaron','559784032', 'Pradera Num.408'),
('042', 'Carmen', 'Salinas','513324986', 'Lomas Herradura Num.203'),
('063', 'Martha', 'Colgate', '569748334', 'Río San Joaquín Num.5'),
('088', 'Melanie', 'Martinez', '523699468', 'Granjas Num.509'),
('056', 'Carlos', 'Rivera', '559746853', 'Ciudad Satelite Num.888');

insert into Pedido values
('2023-09-01', '017', 1, 'Tarjeta de Crédito', 'Concretado'),
('2023-09-09', '022', 2, 'Tarjeta de Débito', 'Concretado'),
('2023-09-11', '051', 3, 'Transferencia', 'Concretado'),
('2023-09-16', '056', 4, 'Tarjeta de Crédito', 'Concretado'),
('2023-09-20', '076', 5, 'Tarjeta de Crédito', 'Concretado'),
('2023-09-21', '088', 6, 'Tranferencia', 'Pendiente'),
('2023-09-25', '094', 7, 'Tarjeta de Débito', 'Concretado'),
('2023-09-28', '038', 8, 'Transferencia', 'Concretado'),
('2023-09-29', '063', 9, 'Transferencia', 'Pendiente'),
('2023-10-05', '042', 10, 'Tarjeta de Crédito', 'Concretado');

insert into Articulo values
('0018', 'Skittles', 'Caramelo', 28, 'Comida'),
('0171', 'Suavitel', 'Suavizante de ropa', 124, 'Limpieza'),
('0584', 'Colgate', 'Pasta Dental', 30, 'Higiene'),
('0092', 'Duraznos La Costeña', 'Duraznos en Almibar', 54,'Comida'),
('0039', 'Knorr', 'Caldo de Pollo', 59, 'Comida'),
('0122', 'Lysol', 'Toallitas Desinfectantes', 65, 'Limpieza'),
('0186', 'Salvo', 'Lavatrastes Líquido', 60, 'Limpieza'),
('0570', 'Purell Healthy Soap', 'Jabón en Espuma', 38, 'Higiene'),
('0552', 'Dove Original', 'Jabón en Barra', 88, 'Higiene'),
('0065', 'Panditas', 'Gomitas clasicas', 77, 'Comida');

insert into Articulo_Conforma values
('2023-09-01', '0018', 1),
('2023-09-09', '0552', 1),
('2023-09-11', '0039', 3),
('2023-09-16', '0171', 1),
('2023-09-20', '0186', 2),
('2023-09-21', '0065', 1),
('2023-09-25', '0122', 2),
('2023-09-28', '0092', 1),
('2023-09-29', '0584', 2),
('2023-10-05', '0570', 1);

Select*from Cliente; 
Select*from Pedido;
Select*from Articulo;
Select*from Articulo_Conforma;