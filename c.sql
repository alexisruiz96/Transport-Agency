CREATE DATABASE TransportAgency;

USE TransportAgency;

CREATE TABLE Routes(
	id_route integer(4),
    origin varchar(30),
    destination varchar(30),
    constraint pk_id_route primary key (id_route)
);

CREATE TABLE Locations(
	id_loc integer(4),
    c_postal integer(8),
    name_loc varchar(30),
    id_route integer(4) NOT NULL,
    time_stops integer(8),
    constraint pk_id_loc primary key (id_loc),
    constraint fk_id_route foreign key (id_route) references Routes(id_route)
);

CREATE TABLE Historic(
	dates varchar(10),
    hours varchar (10)
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
    constraint pk_used_in primary key (id_vehicle, id_loc),
    constraint fk1_id_vehicle foreign key (id_vehicle) references Vehicle(id_vehicle),
    constraint fk2_id_loc foreign key (id_loc) references Locations(id_loc)
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
    constraint pk_driver_at primary key (id_driver, id_loc),
    constraint fk1_id_driver foreign key (id_driver) references Driver(id_driver),
    constraint fk2_id_loc2 foreign key (id_loc) references Locations(id_loc)
    );

CREATE TABLE Clientt(
	id_client integer(4),
    name_c varchar (40),
    telf integer (9),
    email varchar(40),
	constraint pk_id_client primary key (id_client)
);

CREATE TABLE Package(
	id_package integer(4),
    id_cost integer(4),
    init_date varchar (20),
    constraint pk_pack primary key (id_package, id_cost),
	constraint fk_id_cost foreign key (id_cost) references Cost(id_cost)
);

CREATE TABLE Cost(
	weight integer(10),
    price integer(10),
    type_p varchar (40),
    id_cost integer(4),
    constraint pk_idcost primary key (id_cost)
);

CREATE TABLE goes_through(
	id_package integer(4),
    id_loc integer(4),
    constraint pk_goes primary key (id_package, id_loc),
	constraint fk_id_loc foreign key (id_loc) references Locations(id_loc)
);

#LES TAULES COST I HISTORY LES HE FICAT SIMPLEMENT COM ATRIBUTS DE PACKAGE, NO ENTENC PERQUE TENIM COM A 2 TAULES.