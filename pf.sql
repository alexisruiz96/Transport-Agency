#DROP PROCEDURE getPckStops;

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
