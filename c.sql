#DROP DATABASE transportagency;
CREATE DATABASE TransportAgency;

USE TransportAgency;

CREATE TABLE Routes(
	id_route integer(4),
    origin varchar(30),
    destination varchar(30),
    constraint pk_id_route primary key (id_route)
);

CREATE TABLE Locations(
    c_postal integer(8),
    id_route integer(4),
    name_loc varchar(30),
    time_stops varchar(10),
    constraint pk_c_postal primary key (c_postal, id_route),
    constraint fk_id_route foreign key (id_route) references Routes(id_route)
);

CREATE TABLE Vehicle(
	id_vehicle integer(4),
    v_type varchar(20),
    size integer(4),
    cost integer(6),
    constraint pk_id_vehicle primary key (id_vehicle)
);

CREATE TABLE Driver(
	id_driver integer(4),
    dni varchar(20),
    ssn varchar(20),
    telf integer(9),
    constraint pk_id_driver primary key (id_driver)
);

CREATE TABLE LocHasHist(
	c_postal integer(8),
    ini_date varchar(20),
    franja_hor varchar(10),
    id_route integer(4),
    id_vehicle integer(4),
    id_driver integer(4),
    constraint pk_lochist primary key (c_postal, ini_date, franja_hor, id_route),
    constraint fk_postal foreign key (c_postal) references Locations(c_postal),
    constraint fk_route foreign key (id_route) references Locations(id_route), #ROUTE OR LOCATIONS
    constraint fk_veh foreign key (id_vehicle) references Vehicle(id_vehicle),
    constraint fk_driver foreign key (id_driver) references Driver(id_driver)
);

CREATE TABLE Clientt(
	id_client integer(4),
    name_c varchar (40),
    telf integer (9),
    email varchar(40),
	constraint pk_id_client primary key (id_client)
);

CREATE TABLE Cost(
	id_cost integer(4),
	weight integer(10),
    price integer(10),
    type_p varchar (40),
    constraint pk_idcost primary key (id_cost)
);

CREATE TABLE PackageSendHas(
	id_package integer(4),
    id_client integer(4),
    id_cost integer(4),
    adress varchar(20),
    constraint pk_pack primary key (id_package, id_cost, id_client),
	constraint fk_id_cost foreign key (id_cost) references Cost(id_cost),
    constraint fk_id_cliente foreign key (id_client) references Clientt(id_client)
);

CREATE TABLE GoesThrough(
	id_package integer(4),
    c_postal integer(8),
    ini_date varchar(20),
    franja_hor varchar(10),
    id_route integer(4),
    constraint pk_goes primary key (id_package, c_postal, ini_date, franja_hor, id_route),
    constraint fk2_package foreign key (id_package) references PackageSendHas(id_package),
    constraint fk2_ini_date foreign key (c_postal, ini_date, franja_hor, id_route) references LocHasHist(c_postal, ini_date, franja_hor, id_route),
	constraint fk2_route foreign key (id_route) references Locations(id_route)
);

CREATE TABLE Statuss(
	id_status integer(4),
    description varchar(15),
	constraint pk_stat primary key (id_status)
);

CREATE TABLE With_stat(
	id_status integer(4),
    id_package integer(4),
    fecha varchar(20),
	constraint pk_with_stat primary key (id_status, id_package),
    constraint fk_stat foreign key (id_status) references Statuss(id_status),
    constraint fk2_pack foreign key (id_package) references PackageSendHas(id_package)
    
);

# now we will put 5 diferent values for each table

INSERT INTO Routes (id_route, origin, destination) VALUES
(1,'Madrid', 'Barcelona'),
(2,'Vic', 'Barcelona'),
(3,'Sevilla','Madrid'),
(4,'Barcelona','Granollers'),
(5,'Valencia','Barcelona');

INSERT INTO Locations (c_postal, id_route, name_loc, time_stops) VALUES
(08480,1,'Vallés', '10:30'),
(09234,3,'Toledo','12:15'),
(21032,1,'Reus','16:45'),
(48239,1,'Barcelona','13:23'),
(48239,2,'Barcelona','15:56'),
(48239,4,'Barcelona','10:33'),
(48239,5,'Barcelona','17:13'),
(21032,2,'Reus','17:45'),
(09234,5,'Toledo','08:15');

INSERT INTO Vehicle (id_vehicle, v_type, size, cost) VALUES
(1,'Turisme', 350, 300),
(2,'Moto',250,250),
(3,'Furgoneta',500, 450),
(4,'Camión',1500,600),
(5,'Furgoneta',500,450);

INSERT INTO Driver (id_driver, dni, ssn, telf) VALUES
(1,'934536339G','23526',938432913),
(2,'231938239T','42526',931824382),
(3,'919328312P','31412',621952129),
(4,'231414192F','20103',629304019),
(5,'059382394G','42819',934812394);

INSERT INTO LocHasHist (c_postal, ini_date, franja_hor, id_route, id_vehicle, id_driver) VALUES
(08480,'28/06/2017','Mañana',1,1,1),
(21032,'02/07/2017','Tarde',2,2,2),
(48239,'23/06/2017','Tarde',1,1,2),
(21032,'14/04/2017','Mañana',1,1,3),
(09234,'18/05/2017','Tarde',5,5,5);


INSERT INTO Clientt (id_client, name_c, telf, email) VALUES
(1,'Apple',923182392,'apple@gmail.com'),
(2,'Google',948322918,'google@hotmail.com'),
(3,'Amazon',934921039,'amazonas@gmail.com'),
(4,'Windows',958432938,'ventanas@gmail.com'),
(5,'Upf',948392839,'upf@upc.edu');

INSERT INTO Cost (id_cost, weight,price, type_p) VALUES
(1,50,800,'Caja'),
(2,2,300,'Sobre'),
(3,600,1300,'Caja grande'),
(4,300,900,'Caja'),
(5,200,300,'Caja');

INSERT INTO PackageSendHas (id_package, id_client ,id_cost, adress) VALUES
(1,1,1,'Pollancre, 18'),
(2,2,2,'Riera, 25'),
(3,3,3,'Moscarola, 147'),
(4,4,4,'Enric Morera, 12'),
(5,5,5,'Tomas Bretón, 17');

INSERT INTO GoesThrough (id_package, c_postal, ini_date, franja_hor, id_route) VALUES
(1,08480,'28/06/2017','Mañana',1),
(2,21032,'02/07/2017','Tarde',2),
(1,48239,'23/06/2017','Tarde',1),
(1,21032,'14/04/2017','Mañana',1),
(5,09234,'18/05/2017','Tarde',5);

INSERT INTO Statuss (id_status, description) VALUES
(1,'In process'),
(2,'enviado'),
(3,'In process'),
(4,'a la espera'),
(5,'recibido');

INSERT INTO With_stat (id_status, id_package, fecha) VALUES
(1,1,'14/06'),
(2,2,'24/12'),
(3,3,'02/11'),
(4,4,'30/08'),
(5,5,'12/02');


