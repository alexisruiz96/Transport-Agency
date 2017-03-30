#PROCEDURES

DROP PROCEDURE IF EXISTS getPckStops;
DROP PROCEDURE IF EXISTS getPcksCarriedInAStop;
DROP PROCEDURE IF EXISTS getPckinVehAndStop;
DROP FUNCTION IF EXISTS WeightOnStop;

DELIMITER /

#id_package->stops with  driver and telf

CREATE PROCEDURE getPckStops(IN id_pack integer(4))

BEGIN
    
	SELECT G.id_package,G.c_postal,L.id_driver, D.telf
	FROM GoesThrough G, LocHasHist L, Driver D
	WHERE G.c_postal = L.c_postal
	AND G.ini_date = L.ini_date
	AND G.franja_hor = L.franja_hor
	AND G.id_route = L.id_route
	AND L.id_driver=D.id_driver
	AND G.id_package=id_pack;
END/

DELIMITER //;

call getPckStops(1);

#In a specific stop, what packages are being carried in a vehicle
DELIMITER /

CREATE PROCEDURE getPcksCarriedInAStop(IN c_postal integer(8))

BEGIN
    
	SELECT G.c_postal,G.id_package
	FROM GoesThrough G
	WHERE G.c_postal = c_postal;

END/

DELIMITER //;

call getPcksCarriedInAStop(21032);

#What packages are being carried in one specific vehicle and in one specific stop
DELIMITER /

CREATE PROCEDURE getPckinVehAndStop(IN id_vehicle integer(4), c_postal integer(8))

BEGIN
    
	SELECT DISTINCT L.id_vehicle, L.c_postal, G.id_package
	FROM GoesThrough G, LocHasHist L, Vehicle V
	WHERE G.c_postal = c_postal
    AND L.c_postal = c_postal
    AND G.c_postal = L.c_postal;

END/

DELIMITER //;

call getPckinVehAndStop(1,08480);

#FUNCTION

#In one specific stop return what weight is being carried. 

DELIMITER $$


CREATE FUNCTION WeightOnStop(c_postal integer(8)) RETURNS INTEGER(8)

    DETERMINISTIC

BEGIN

    DECLARE sumw integer(8);
    
	SELECT sum(weight)
    INTO sumw
    FROM Cost
    WHERE weight IN (SELECT DISTINCT C.weight
	FROM Cost C, GoesThrough G, Locations L, PackageSendHas PH
	WHERE G.c_postal = L.c_postal
    AND G.id_package = PH.id_package
	AND PH.id_cost = C.id_cost
    AND G.c_postal = c_postal);
    
    
 RETURN (sumw);


END$$

DELIMITER ;


select WeightOnStop(21032);



