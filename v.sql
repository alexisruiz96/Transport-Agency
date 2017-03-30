#VIEWS

#View that shows all the clients and packages whose current status is
#'In process' so that the company can process these packages


DELIMITER ;

CREATE OR REPLACE VIEW CLIENTS_PACKS_IN_PROCESS AS
SELECT P.id_client , P.id_package
FROM PackageSendHas P, Statuss S, With_stat W, Clientt C
WHERE P.id_client = C.id_client
AND W.id_package = P.id_package
AND W.id_status = S.id_status
AND S.description = 'In process';


SELECT * FROM CLIENTS_PACKS_IN_PROCESS;
DELIMITER //


#View that shows for every stop the route and number of packages that
#we have with the sum of the weights 

DELIMITER ;

CREATE OR REPLACE VIEW Stop_packs_and_weight AS
SELECT L.c_postal, L.id_route , count(G.id_package) , sum(C.weight)
FROM Locations L, GoesThrough G, PackageSendHas P, Cost C
WHERE L.c_postal = G.c_postal
AND L.id_route = G.id_route
AND G.id_package = P.id_package
AND P.id_cost = C.id_cost
GROUP BY c_postal;


SELECT * FROM Stop_packs_and_weight;
DELIMITER //