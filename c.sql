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
    name_loc varchar(30),
    id_route integer(4),
    time_stops integer(8),
    constraint pk_c_postal primary key (c_postal, id_route),
    constraint fk_id_route foreign key (id_route) references Routes(id_route)
);

CREATE TABLE Historic(
	franja_hor varchar(10),
    ini_date varchar(10),
    constraint pk_ini_date primary key (ini_date)
    
);

CREATE TABLE LocHasHist(
	c_postal integer(8),
    ini_date varchar(10),
    constraint pk_lochist primary key (c_postal, ini_date),
    constraint fk_postal foreign key (c_postal) references Locations(c_postal),
    constraint fk_date foreign key (ini_date) references Historic(ini_date)
);
CREATE TABLE Vehicle(
	id_vehicle integer(4),
    v_type varchar(20),
    size integer(5),
    cost integer(6),
    constraint pk_id_vehicle primary key (id_vehicle)
);

CREATE TABLE Used_in(
	id_vehicle integer(4),
    id_loc integer(4),
    ini_date varchar(10),
    constraint pk_used_in primary key (id_vehicle, id_loc, ini_date),
    constraint fk1_id_vehicle foreign key (id_vehicle) references Vehicle(id_vehicle),
    constraint fk2_id_loc foreign key (id_loc) references Locations(id_loc),
    constraint fk3_ini_date foreign key (id_date) references Historic(id_date)
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
    id_loc integer(4),
    ini_date varchar(10),
    constraint pk_driver_at primary key (id_driver, id_loc, ini_date),
    constraint fk1_id_driver foreign key (id_driver) references Driver(id_driver),
    constraint fk2_id_loc2 foreign key (id_loc) references Locations(id_loc),
	constraint fk3_ini_date2 foreign key (id_date) references Historic(id_date)
    );

CREATE TABLE GoesThrough( #TO DO
	id_package integer(4),
    id_loc integer(4),
    ini_date varchar(10),
    constraint pk_goes primary key (id_package, id_loc, ini_date),
	constraint fk_id_loc3 foreign key (id_loc) references Locations(id_loc),
    constraint fk2_packet foreign key (id_packet) references PackageSendHas(id_package),
    constraint fk3_ini_date3 foreign key (ini_date) references Historic(ini_date)
);

CREATE TABLE Clientt(
	id_client integer(4),
    name_c varchar (40),
    telf integer (9),
    email varchar(40),
	constraint pk_id_client primary key (id_client)
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

CREATE TABLE Cost(
	weight integer(10),
    price integer(10),
    type_p varchar (40),
    id_cost integer(4),
    constraint pk_idcost primary key (id_cost)
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

#LES TAULES COST I HISTORY LES HE FICAT SIMPLEMENT COM ATRIBUTS DE PACKAGE, NO ENTENC PERQUE TENIM COM A 2 TAULES.