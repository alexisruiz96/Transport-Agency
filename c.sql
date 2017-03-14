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

CREATE TABLE Historic(
	ini_date varchar(20),
	franja_hor varchar(10),
    constraint pk_ini_date primary key (ini_date)
    
);

CREATE TABLE LocHasHist(
	c_postal integer(8),
    ini_date varchar(20),
    constraint pk_lochist primary key (c_postal, ini_date),
    constraint fk_postal foreign key (c_postal) references Locations(c_postal),
    constraint fk_date foreign key (ini_date) references Historic(ini_date)
);
CREATE TABLE Vehicle(
	id_vehicle integer(4),
    v_type varchar(20),
    size varchar(10),
    cost integer(6),
    constraint pk_id_vehicle primary key (id_vehicle)
);

CREATE TABLE Used_in(
	id_vehicle integer(4),
    c_postal integer(8),
    ini_date varchar(20),
    constraint pk_used_in primary key (id_vehicle, c_postal, ini_date),
    constraint fk1_id_vehicle foreign key (id_vehicle) references Vehicle(id_vehicle),
    constraint fk2_c_postal foreign key (c_postal) references Locations(c_postal),
    constraint fk3_ini_date foreign key (ini_date) references Historic(ini_date)
    );

CREATE TABLE Driver(
	id_driver integer(4),
    dni varchar(20),
    ssn varchar(20),
    telf integer(9),
    constraint pk_id_driver primary key (id_driver)
);

CREATE TABLE Driver_at(
	id_driver integer(4),
    c_postal integer(8),
    ini_date varchar(20),
    constraint pk_driver_at primary key (id_driver, c_postal, ini_date),
    constraint fk1_id_driver foreign key (id_driver) references Driver(id_driver),
    constraint fk2_c_postal2 foreign key (c_postal) references Locations(c_postal),
	constraint fk3_ini_date2 foreign key (ini_date) references Historic(ini_date)
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
    constraint pk_goes primary key (id_package, c_postal, ini_date),
	constraint fk_c_postal3 foreign key (c_postal) references Locations(c_postal),
    constraint fk2_package foreign key (id_package) references PackageSendHas(id_package),
    constraint fk3_ini_date3 foreign key (ini_date) references Historic(ini_date)
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
(08480,2,'Vallés', '10:30'),
(09234,3,'Toledo','12:15'),
(21032,5,'Reus','16:45'),
(48239,1,'Barcelona','13:23'),
(48239,2,'Barcelona','15:56'),
(48239,4,'Barcelona','10:33'),
(48239,5,'Barcelona','17:13');

INSERT INTO Historic (ini_date, franja_hor) VALUES
('10:30 Lunes','Mañana'),
('16:45 Jueves','Tarde'),
('17:13 Martes','Tarde'),
('10:33 Viernes','Mañana'),
('12:15 Miercoles','Mañana');

INSERT INTO LocHasHist (c_postal, ini_date) VALUES
(08480,'10:30 Lunes'),
(21032,'16:45 Jueves'),
(48239,'17:13 Martes'),
(48239,'10:33 Viernes'),
(09234,'12:15 Miercoles');

INSERT INTO Vehicle (id_vehicle, v_type, size, cost) VALUES
(1,'Turisme', 'Medio', 300),
(2,'Moto','Bajo',250),
(3,'Furgoneta','Grande', 450),
(4,'Camión','Enorme',600),
(5,'Furgoneta','Grande',450);


INSERT INTO Used_in (id_vehicle, c_postal, ini_date) VALUES
(1,08480,'10:30 Lunes'),
(2,21032,'16:45 Jueves'),
(3,48239,'17:13 Martes'),
(4,48239,'10:33 Viernes'),
(5,09234,'12:15 Miercoles');

INSERT INTO Driver (id_driver, dni, ssn, telf) VALUES
(1,'934536339G','23526',938432913),
(2,'231938239T','42526',931824382),
(3,'919328312P','31412',621952129),
(4,'231414192F','20103',629304019),
(5,'059382394G','42819',934812394);

INSERT INTO Driver_at (id_driver, c_postal, ini_date) VALUES
(1,08480,'10:30 Lunes'),
(2,21032,'16:45 Jueves'),
(3,48239,'17:13 Martes'),
(4,48239,'10:33 Viernes'),
(5,09234,'12:15 Miercoles');

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
(),
(),
(),
(),
();

INSERT INTO GoesThrough (id_package, c_postal, ini_date) VALUES
(),
(),
(),
(),
();

INSERT INTO Statuss (id_status, description) VALUES
(),
(),
(),
(),
();

INSERT INTO With_stat (id_status, id_package, fecha) VALUES
(),
(),
(),
(),
();