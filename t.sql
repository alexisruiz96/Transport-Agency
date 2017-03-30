#TRIGGER

DROP TRIGGER IF EXISTS restrictionWeight;

#Assign one package to one vehicle checking that there is enough space

DELIMITER /

CREATE TRIGGER restrictionWeight
BEFORE INSERT ON GoesThrough FOR EACH ROW

BEGIN

	DECLARE weight_newpck float;
	DECLARE count_total_weight float;
    DECLARE capacity_vehicle float;
    
	SELECT DISTINCT C.weight
    INTO weight_newpck
	FROM Cost C, PackageSendHas P
	WHERE C.id_cost = P.id_cost
    AND P.id_package = NEW.id_package;
    
    
    SELECT sum(C.weight) INTO count_total_weight FROM GoesThrough G, LocHasHist LHH, PackageSendHas P, Cost C
	WHERE G.c_postal = LHH.c_postal
	AND G.ini_date = LHH.ini_date
	AND G.franja_hor = LHH.franja_hor
	AND G.id_route = LHH.id_route
	AND G.c_postal = NEW.c_postal
	AND G.ini_date = NEW.ini_date
	AND G.franja_hor = NEW.franja_hor
	AND G.id_route = NEW.id_route
	AND G.id_package = P.id_package
    AND C.id_cost = P.id_cost;

	SELECT V.size INTO capacity_vehicle FROM LocHasHist LHH, Vehicle V
	WHERE LHH.id_vehicle = V.id_vehicle
	AND LHH.c_postal = NEW.c_postal
	AND LHH.ini_date = NEW.ini_date
	AND LHH.franja_hor = NEW.franja_hor
	AND LHH.id_route = NEW.id_route;
    
	IF((count_total_weight +weight_newpck) > capacity_vehicle) THEN
 
		SIGNAL SQLSTATE '45000'
     	SET MESSAGE_TEXT = 'It cannot add more packages, no such space in this vehicle';
 
     END IF;
 
 END;  //
 
 delimiter //;
 
INSERT INTO PackageSendHas (id_package, id_client ,id_cost, adress) VALUES (6,3,3,'Cirelora, 83');
INSERT INTO GoesThrough (id_package, c_postal, ini_date, franja_hor, id_route) VALUES (6,21032,'02/07/2017','Tarde',2);

