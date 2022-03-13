/*Práctica Base de Datos*/
/*Alumno Félix Díaz de Rada*/

/*Creación de la base de datos*/
DROP DATABASE IF EXISTS fdrs;
CREATE DATABASE fdrs;
USE fdrs;

/*Eliminación de tablas en caso de ser necesario*/

DROP TABLE IF EXISTS estado_caso;
DROP TABLE IF EXISTS dictamen;
DROP TABLE IF EXISTS caso;
DROP TABLE IF EXISTS ambito_caso;
DROP TABLE IF EXISTS juez;
DROP TABLE IF EXISTS periodico;
DROP TABLE IF EXISTS ambito_periodico;
DROP TABLE IF EXISTS partido_politico;
DROP TABLE IF EXISTS telefono;
DROP TABLE IF EXISTS implicado;
DROP TABLE IF EXISTS esFamiliar;


DROP TABLE IF EXISTS investiga;
DROP TABLE IF EXISTS descubre;
DROP TABLE IF EXISTS envuelve;
DROP TABLE IF EXISTS es_afin;
DROP TABLE IF EXISTS es_afiliado;





/*Creación de las tablas relativas al modelo E/R y paso a tablas posterior*/



CREATE TABLE estado_caso(
Id_estado_caso int NOT NULL,
descripcion_estado varchar (100),
PRIMARY KEY (Id_estado_caso)
);


CREATE TABLE dictamen(
Id_dictamen int NOT NULL,
registrado ENUM ('Sí registrado','No registrado'),
PRIMARY KEY (Id_dictamen)
);


CREATE TABLE caso(
Id_caso int NOT NULL , 
nombre varchar(30) NOT NULL, 
descripcion varchar(150),
est_desvio int unsigned,
fecha_estado_caso Date,
Id_estado_caso int,
Id_dictamen int,
PRIMARY KEY (Id_caso),
FOREIGN KEY (Id_estado_caso) REFERENCES estado_caso(Id_estado_caso) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_dictamen) REFERENCES dictamen(Id_dictamen) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ambito_caso(
Id_ambito int NOT NULL AUTO_INCREMENT,
descripcion_ambito varchar (100),
Id_caso int,
PRIMARY KEY (Id_ambito),
FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) ON DELETE CASCADE ON UPDATE CASCADE 
);


CREATE TABLE Juez(
Id_juez int NOT NULL,
nombre varchar (30) NOT NULL,
direccion varchar (100),
fecha_nac date,
fecha_pro date,
num_casos_profesion int,
PRIMARY KEY (Id_juez)
);


CREATE TABLE periodico(
 Id_periodico int NOT NULL ,
 nombre varchar (30) NOT NULL, 
 web varchar (50), 
 dir_sede varchar (100), 
 ed_impreso tinyint NOT NULL, 
 ed_digital tinyint NOT NULL,
 PRIMARY KEY (Id_periodico)
 );
 
 
 CREATE TABLE ambito_periodico(
Id_ambito_periodico int NOT NULL ,
descripcion_ambito_per varchar (50),
Id_periodico int,
PRIMARY KEY (Id_ambito_periodico),
FOREIGN KEY (Id_periodico) REFERENCES periodico(Id_periodico) ON DELETE CASCADE ON UPDATE CASCADE
);
 
 
 CREATE TABLE partido_politico (
 Id_partidopol int NOT NULL,
 nombre varchar (30),
 dir_sede varchar (100),
 PRIMARY KEY (Id_partidopol)
 );
 
 
 CREATE TABLE  telefono(
   telefono_num int NOT NULL,
   tipo_num varchar (50),
   Id_partidopol int,
   PRIMARY KEY (telefono_num),
   FOREIGN KEY (Id_partidopol) REFERENCES partido_politico(Id_partidopol) ON DELETE CASCADE ON UPDATE CASCADE
  );
 

 CREATE TABLE implicado(
 Id_implicado int NOT NULL ,
 DNI varchar (9) NOT NULL ,
 nombre varchar(30) NOT NULL,
 direccion varchar (100),
 pais_residencia varchar (50) NOT NULL,
 ciudad varchar (50) NOT NULL,
 patrimonio int,
 PRIMARY KEY (Id_implicado)
 );
 
 
 CREATE TABLE esFamiliar(
Id_implicado_1 int,
Id_implicado_2 int,
parentesco varchar(30) ,
PRIMARY KEY (Id_implicado_1,Id_implicado_2),
FOREIGN KEY (Id_implicado_1) REFERENCES implicado(Id_implicado) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_implicado_2) REFERENCES implicado(Id_implicado) ON DELETE CASCADE ON UPDATE CASCADE
);
 

 CREATE TABLE investiga (
 Id_caso int ,
 Id_juez int ,
 PRIMARY KEY (Id_caso),
 FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (Id_juez) REFERENCES juez(Id_juez) ON DELETE CASCADE ON UPDATE CASCADE
 );
 

 CREATE TABLE descubre (
 Id_caso int,
 Id_periodico int,
 Fecha_descubre date, 
 PRIMARY KEY (Id_caso),
 FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (Id_periodico) REFERENCES periodico(Id_periodico) ON DELETE CASCADE ON UPDATE CASCADE
 );
 

 CREATE TABLE envuelve (
 Id_caso int,
 Id_implicado int,
 Fecha_inicio date,
 Puesto varchar (30),
 PRIMARY KEY (Id_caso,Id_implicado),
 FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (Id_implicado) REFERENCES implicado(Id_implicado) ON DELETE CASCADE ON UPDATE CASCADE
 );
 

 CREATE TABLE es_afin (
 Id_periodico int,
 Id_partidopol int,
 PRIMARY KEY (Id_periodico,Id_partidopol),
 FOREIGN KEY (Id_periodico) REFERENCES periodico(Id_periodico) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (Id_partidopol) REFERENCES partido_politico(Id_partidopol) ON DELETE CASCADE ON UPDATE CASCADE
 );
 

CREATE TABLE es_afiliado (
Id_implicado int,
Id_partidopol int,
Cargo_partido varchar  (30),
PRIMARY KEY (Id_implicado,Id_partidopol),
FOREIGN KEY (Id_implicado) REFERENCES implicado(Id_implicado) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_partidopol) REFERENCES partido_politico(Id_partidopol) ON DELETE CASCADE ON UPDATE CASCADE
 );










/* Trigger*/
/*Cada inserción de un caso nuevo genera, a través del trigger sumarCasosJuez, un aumento del número de casos llevados por el juez */
CREATE TRIGGER sumarCasosJuez
AFTER INSERT ON caso
FOR EACH ROW
UPDATE juez
SET num_casos_profesion=num_casos_profesion + 1
WHERE Id_juez = NEW.Id_caso; 


















/* Inserción de datos*/

INSERT INTO estado_caso(Id_estado_caso, descripcion_estado)
VALUES
(1, 'Caso abierto'),
(2, 'Caso en trámite de apertura'),
(3, 'Caso cerrado con dictamen registrado'),
(4, 'Caso cerrado sin dictamen registrado');



INSERT INTO dictamen(Id_dictamen, registrado)
VALUES
(1, 'No registrado'),
(2, 'Sí registrado'),
(3, 'No registrado'),
(4, 'No registrado'),
(5, 'No registrado'),
(6, 'No registrado'),
(7, 'Sí registrado'),
(8, 'Sí registrado'),
(9, 'No registrado'),
(10, 'No registrado'),
(11, 'No registrado'),
(12, 'Sí registrado'),
(13, 'No registrado'),
(14, 'No registrado'),
(15, 'No registrado'),
(16, 'No registrado'),
(17, 'No registrado'),
(18, 'No registrado'),
(19, 'No registrado'),
(20, 'Sí registrado'),
(21, 'No registrado'),
(22, 'No registrado');

INSERT INTO juez(Id_juez,nombre,direccion,fecha_nac,fecha_pro,num_casos_profesion) 
VALUES
(1,'Pedro Pimienta','calle del pino 2','1986/10/06','2016/10/06',670),
(2,'Eustaquio Diaz','calle del roble 3','1977/10/01','2007/10/07',780),
(3,'Luis Ramiro','calle del abeto 56','1979/11/12','2009/11/14',612),
(4,'Catalina Viernes','calle del sol 34','1978/11/26','2008/11/29',895),
(5,'Pedro Suarez','calle de la luna 44','1968/01/03','1998/01/02',1232),
(6,'Luis Prieto','calle de la lluvia 89','1968/11/06','1998/11/03',1543),
(7,'Fernando Ortiz','calle de la pesca 12','1978/06/04','2008/06/04',975),
(8,'Guadalupe González','calle de la caza 45','1978/01/16','2009/01/15',871),
(9,'Ines Sastre','calle de Palmas 100','1969/11/26','1999/11/28',1452),
(10,'Hortensia del Valle','calle de la rosa 3','1981/11/08','2011/11/09',431),
(11,'Paula Solo','calle del sueño 2','1991/10/06','1991/10/06',234);


INSERT INTO caso(Id_caso,nombre,descripcion,est_desvio,fecha_estado_caso,Id_estado_caso,Id_dictamen) 
VALUES
(1,'caso de la luz','robo de bombillas',43000000,'2016/10/03',1,1),
(2,'caso de la noche','cohecho de sueños',500000000,'2020/10/04',3,2),
(3,'caso de la sirena','robo de peces',50900000,'2014/12/22',1,3),
(4,'caso de la playa','robo de arena',600000000,'2008/11/04',1,4),
(5,'caso de la escollera','robo de piedras',122000000,'2009/11/12',4,5),
(6,'caso de la inglesa','prevaricación de historias',455000000,'2011/11/07',2,6),
(7,'caso de la sal','robo de sal',5300000,'2006/10/08',3,7),
(8,'caso del timbre','cohecho de tiempo',41000000,'2005/11/09',3,8),
(9,'caso del camino','robo de señales',12000000,'2011/12/10',3,9),
(10,'caso del leon','robo de fieras',45400000,'2005/12/01',4,10),
(11,'caso del viejo blanco','cohecho de documentos',15700000,'2005/12/02',1,11),
(12,'caso de la rosa','robo de amores',85000000,'2005/10/03',3,12),
(13,'caso del tigre','tráfico de animales',10500000,'2004/11/04',2,13),
(14,'caso de la piel','Violencia de género',30800000,'2003/11/05',2,14),
(15,'caso de muerte','Asesinato y robo de políticos',700040000,'2003/11/06',1,15),
(16,'caso del alquiler','Vandalismo de inquilinos en edificios públicos',232000000,'2002/11/07',1,16),
(17,'caso del dolar','Fraude del cambio',435080000,'2004/10/08',1,17),
(18,'caso del euro','Dumping Fiscal',5900000,'2001/10/09',2,18),
(19,'caso de la biblioteca','robo de libros',50700000,'2011/10/10',1,19),
(20,'caso del festival','Fraude en las entradas del festival',22000000,'2010/08/11',3,20),
(21,'caso del subsidio','Fraude al Sistema de Seguridad Social',82000000,'2009/09/12',2,21),
(22,'caso del despido','Despido objetivos injustificados',11100000,'2012/11/15',1,22);


/*un caso puede tener varios ámbitos*/
INSERT INTO ambito_caso(descripcion_ambito,Id_caso)
VALUES
('Banco',1),
('Ayuntamiento',2),
('Caja de Ahorros',1),
('Comunidad Autónoma',2), 
('Estado',2),
('Banco',3),
('Ayuntamiento',4),
('Caja de Ahorros',5),
('Comunidad Autónoma',6), 
('Estado',6),
('Banco',5),
('Ayuntamiento',7),
('Caja de Ahorros',6),
('Comunidad Autónoma',7), 
('Estado',8),
('Banco',10),
('Ayuntamiento',11),
('Caja de Ahorros',10),
('Comunidad Autónoma',12), 
('Estado',12),
('Banco',13),
('Ayuntamiento',14),
('Caja de Ahorros',15),
('Comunidad Autónoma',16), 
('Estado',16),
('Banco',17),
('Ayuntamiento',18),
('Caja de Ahorros',17),
('Comunidad Autónoma',18), 
('Estado',19),
('Banco',20),
('Ayuntamiento',21),
('Caja de Ahorros',20),
('Comunidad Autónoma',22), 
('Estado',22),
('Banco',15);





 
 
INSERT INTO periodico(Id_periodico,nombre,web,dir_sede,ed_impreso,ed_digital) 
VALUES
(1,'el pais','elpais.es','calle del camino',0,0),
(2,'el mundo','elmundo.es','calle del cielo 12',1,1),
(3,'el español','elespañol.es','calle del tiempo 19',0,1),
(4,'el abc','abc.es','calle del príncipe 11',0,1),
(5,'The Times','times.com','calle Lugo 44',0,1),
(6,'el diario','diario.es','calle Ternera 72',1,0),
(7,'el marca','marca.es','calle Ruiz 32',1,0),
(8,'el as','as.es','Calle del Olmo 98',1,1),
(9,'la vanguardia','lavanguardia.es','calle Don Quijote 3',1,1);



INSERT INTO ambito_periodico(Id_ambito_periodico, descripcion_ambito_per,Id_periodico)
VALUES
(1,'nacional',2),
(2,'comarcal',2),
(3,'nacional',1),
(4,'internacional',1),
(5,'local',3),
(6,'comarcal',3),
(7,'nacional',4),
(8,'internacional',5),
(9,'nacional',6),
(10,'comarcal',7),
(11,'nacional',8),
(12,'internacional',8),
(13,'comarcal',9);


INSERT INTO partido_politico(Id_partidopol,nombre,dir_sede)
VALUES
(1,'PT','Genova 14'),
(2,'PRYM','Asuncion Rodríguez 23'),
(3,'PTOE','Eustquia Alonso 67'),
(4,'PRAR','Angela Callejo 32'),
(5,'OCK','Luna 11'),
(6,'ERG','Juan Antonio Sanz 12'),
(7,'Castellanos','Cercona 57'),
(8,'UJ','Travesia del rio 14'),
(9,'Republica','Eugenio Arribas 12'); 


INSERT INTO telefono (telefono_num,tipo_num, Id_partidopol)
VALUES
(915439532,'linea  principal',1),
(912344322,'linea secundaria',1),
(932112228,'linea  principal',2),
(938871127,'linea  principal',3),
(912237889,'linea secundaria',3),
(961188723,'linea  principal',4),
(912214566,'linea secundaria',4),
(915344559,'linea  principal',5),
(912233921,'linea secundaria',5);


 
 INSERT INTO implicado(Id_implicado,DNI,nombre,patrimonio,direccion,pais_residencia,ciudad) 
 VALUES
(1,'57797259V','Álvaro Aragón',80000,'Colón 13','España','Guadalajara'),
(2,'54738259V','Emiliano Ramirez',456000,'San Jaime 127','España','Segovia'),
(3,'40737259H','Laura Soldevila',990000,'Lucio del valle 56','España','Sevilla'),
(4,'30737259G','Eduardo Vilas',130000,'Ávila 121','España','Barcelona'),
(5,'10737259K','Gonzalo Acosta',60000,'San Gabriel 2','España','Valencia'),
(6,'40222259V','Carmen Taguas',180000,'San Vicente 12','España','Valencia'),
(7,'57797221V','Vanesa Prieto',80000,'Ibiza 12','España','Madrid'),
(8,'5476659R','Ana Zabala',6000,'Arcipreste de Hita 14','España','Barcelona'),
(9,'40877259H','Luis de Miguel',990000,'Serrano Jover 6','España','Madrid'),
(10,'34507259K','Carmen Rando',60000,'Gran Vía 21','España','Madrid'),
(11,'17797259K','Luis Aragón',180000,'San Miguel 18','España','Guadalajara'),
(12,'24738259L','Pedro Ramirez',56000,'San Eustaquio 137','España','Segovia'),
(13,'30737259H','Eduardo Soldevila',290000,'Lucio del condor 36','España','Sevilla'),
(14,'40737259F','Fernando Vilas',330000,'Zamora 151','España','Barcelona'),
(15,'50737259D','Ramiro Acosta',40000,'San Román 22','España','Valencia'),
(16,'10222259S','Ana Taguas',280000,'San Minero 32','España','Valencia'),
(17,'17797221E','MAría Prieto',30000,'Minerva 52','España','Madrid'),
(18,'01476659T','Paula Zabala',12000,'Arcipreste de la Salle 11','España','Barcelona'),
(19,'20777259Y','Juan de Miguel',590000,'Serrano 61','España','Valencia'),
(20,'10911259U','Alejandro Garijo',230000,'Guadalajara 21','España','Barcelona'),
(21,'24507259I','Fontana Ranto',70000,'Gran paseo 24','España','Valencia'),
(22,'37797259O','Álvaro Pérez',90000,'La música 15','España','Guadalajara'),
(23,'44738259P','Emiliano De Juan',16000,'San Juan 126','España','Segovia'),
(24,'50737259W','Laura Clemente',100000,'Santa Cristina 55','España','Sevilla'),
(25,'40637259Q','Eduardo Sánchez',190000,'Burgos 129','España','Barcelona'),
(26,'40737259N','Gonzalo Ruiz',160000,'Jaen 8','España','Valencia'),
(27,'40222259M','Carmen Larisa',380000,'Vicente María 15','España','Valencia'),
(28,'54766759X','Ana Díaz',68000,'Conde Lucanor 12','España','Barcelona'),
(29,'50777259Z','Luis Olartiaga',150000,'Tutor Jover 16','España','Madrid'),
(30,'20911259B','Ramón Escandell',190000,'Manuel Castelar 72','España','Barcelona'),
(31,'14507259T','Carmen Mari',260000,'Meneses 24','España','Madrid'),
(32,'30911259G','Luis Garijo',130000,'Toledo 71','España','Barcelona');

INSERT INTO esFamiliar(Id_implicado_1,Id_implicado_2,parentesco)
VALUES
(1,2,'primos'),
(2,3,'hermanos'),
(3,4,'casados'),
(4,5,'sin parentesco'),
(5,6,'primos'),
(6,7,'hermanos'),
(7,8,'casados'),
(8,9,'sin parentesco'),
(9,10,'primos'),
(10,11,'hermanos'),
(11,12,'casados'),
(12,13,'sin parentesco'),
(13,14,'primos'),
(14,15,'hermanos'),
(15,16,'casados'),
(16,17,'sin parentesco'),
(17,18,'primos'),
(18,19,'hermanos'),
(19,20,'casados'),
(20,21,'sin parentesco'),
(21,22,'sin parentesco'),
(22,23,'sin parentesco'),
(23,24,'sin parentesco'),
(24,25,'sin parentesco'),
(25,26,'sin parentesco'),
(26,27,'sin parentesco'),
(27,28,'sin parentesco'),
(28,29,'sin parentesco'),
(29,30,'sin parentesco'),
(30,31,'sin parentesco'),
(31,32,'sin parentesco'),
(32,30,'sin parentesco');


INSERT INTO investiga(Id_caso,Id_juez) 
VALUES
(1,2),
(2,1),
(3,1),
(4,9),
(5,3),
(6,3),
(7,3),
(8,4),
(9,5),
(10,6),
(11,7),
(21,2),
(12,1),
(13,1),
(14,2),
(15,3),
(16,3),
(17,3),
(18,4),
(19,8),
(20,11);

INSERT INTO descubre(Id_caso,Id_periodico,Fecha_descubre)
VALUES
(6,6,'2015/10/09'),
(7,5,'2005/12/06'),
(8,6,'2003/03/04'),
(9,5,'2005/10/02'),
(10,7,'2006/01/16'),
(12,5,'2009/10/24'),
(15,6,'2016/10/04'),
(17,3,'2006/12/03'),
(18,6,'2004/03/04'),
(19,5,'2005/10/03'),
(20,7,'2007/01/14'),
(21,3,'2009/10/23');

INSERT INTO es_afin(Id_periodico,Id_partidopol)
VALUES
(3,1),
(4,1),
(5,1),
(6,4),
(7,5),
(8,6),
(9,6),
(1,6),
(2,9);

INSERT INTO envuelve(Id_caso,Id_implicado,Puesto,Fecha_inicio)
VALUES
(2,1,'gerente','2014/08/13'),
(2,2,'técnico','2013/07/26'),
(3,2,'periodista','2015/09/18'),
(4,3,'político','2011/10/30'),
(5,5,'capitán','2012/11/22'),
(6,5,'alcalde','2015/08/04'),
(7,6,'comerciante','2015/07/08'),
(3,7,'gerente','2014/02/06'),
(5,8,'profesor','2012/01/09'),
(9,9,'funcionario','2009/04/11'),
(10,9,'político','2008/05/14'),
(11,10,'político','2006/07/16');

INSERT INTO es_afiliado(Id_implicado,Id_partidopol,Cargo_partido)
VALUES
(11,1,'miliante de base'),
(1,1,'miliante de base'),
(12,1,'Jefe miliante'),
(15,2,'miliante de base'),
(8,2,'Jefe miliante'),
(7,4,'miliante de base'),
(6,8,'miliante de base'),
(13,8,'Jefe miliante'),
(18,7,'miliante de base'),
(2,7,'miliante de base');








 
 /* queries*/
/* Cuando se registró el primer caso*/
 /*
 SELECT nombre AS 'Nombre del caso', min(Fecha_descubre) as 'Fecha del primer caso' */
 SELECT nombre, Fecha_descubre
 FROM caso AS c
 INNER JOIN descubre AS d
 ON c.Id_caso=d.Id_caso
 ORDER BY Fecha_descubre
 LIMIT 1
 ;
 
 
 /* Ordenar y mostrar de mayor a menor desvío de dinero en Millones de Euros los casos abiertos en ayuntamientos desde que se tiene datos */

 SELECT nombre AS 'Nombre del caso',ROUND((est_desvio)/1000000,0) AS 'desvío dinero en Ayuntamientos (Millones de €)'
 FROM caso AS c
 INNER JOIN ambito_caso AS ac
 ON c.Id_caso = ac.Id_caso
 WHERE ac.descripcion_ambito = 'Ayuntamiento' AND Id_estado_caso = 1
 ORDER BY est_desvio DESC
 ;
 
 /* Cuántos casos y cuántos millones de Euros se han han desviado desde 2010 */
 
 SELECT COUNT(*) AS 'número de casos' ,ROUND((SUM(est_desvio))/1000000,0) as 'Millones de Euros desviados'
 FROM caso AS c
 INNER JOIN ambito_caso AS ac
 ON c.Id_caso = ac.Id_caso
 WHERE fecha_estado_caso >= '2010/01/01' 
 ORDER BY SUM(est_desvio) DESC
 ;
 
 /* De los anteriores cual ha sido su distribución en cada ámbito correspondiente y ordenados de mayor a menor desvío de dinero*/

 SELECT ac.descripcion_ambito AS ' Ámbitos del caso' , COUNT(*) AS 'número de casos' ,ROUND((SUM(est_desvio))/1000000,0) as 'Millones de Euros desviados'
 FROM caso AS c
 INNER JOIN ambito_caso AS ac
 ON c.Id_caso = ac.Id_caso
 WHERE fecha_estado_caso >= '2010/01/01' 
 GROUP BY ac.descripcion_ambito
 ORDER BY SUM(est_desvio) DESC
 ;

 /* De los casos anteriores como se llaman los que permanecen abiertos a día de hoy en cada ámbito*/
 
SELECT ac.descripcion_ambito AS 'Ámbitos del caso',c.nombre AS 'Nombre del caso'
FROM caso AS c
INNER JOIN ambito_caso AS ac
ON c.Id_caso = ac.Id_caso
WHERE fecha_estado_caso >= '2014/03/10' AND c.Id_estado_caso = 1
ORDER BY ac.descripcion_ambito
;
	
 /* Cuantos veces cada tipo de ámbitos han sido objeto de casos investigados desde los años 90?(Cada caso puede tener más de un ámbito)*/
SELECT  ac.descripcion_ambito AS 'Tipo ámbito',count(ac.Id_ambito) AS 'número de casos involucrados en cada ámbito' 
FROM caso AS c
	INNER JOIN ambito_caso AS ac
	ON c.Id_caso = ac.Id_caso
WHERE fecha_estado_caso >= '1990/01/01' 
GROUP BY ac.descripcion_ambito
ORDER BY count(ac.Id_ambito) DESC;
 
 /* ¿Cuáles son los tres jueces que persiguieron las mayores cantidades de desvío de dinero desde 1990 hasta el año 2020?
 ¿Cúales fueron las cantidades investigadas?  */
 SELECT casojuez.nombre, ROUND(SUM(est_desvio)/1000000,0) AS 'Millones de Euros de desvío en los casos investigados por juez'
 FROM caso AS c
 INNER JOIN 
	(SELECT  Id_caso, nombre
	FROM investiga
	LEFT JOIN juez
	ON investiga.id_juez=juez.id_juez
	ORDER BY ID_caso)
    AS casojuez
ON c.Id_caso = casojuez.Id_caso
WHERE fecha_estado_caso > '2000/01/01' AND fecha_estado_caso <'2020/01/01'
GROUP BY casojuez.nombre
ORDER BY SUM(est_desvio) DESC
LIMIT 3
 ;
 /* ¿Cuál es el juez estrella en lo que a perseguir mayores cantidades de dinero defraudado al Estado desde el año 2020 ?
 ¿Cúales fueron las cantidades investigadas en millones de Euros?  */
SELECT casoambitojuez.nombre,ROUND(SUM(est_desvio)/1000000,0) AS 'Desvío en millones de Euros'
FROM(	
    SELECT casojuez.Id_caso, casojuez.nombre,ac.Id_ambito,ac.descripcion_ambito 
	FROM (
		SELECT  i.Id_caso, j.nombre
		FROM investiga AS i
		LEFT JOIN juez AS j
		ON i.Id_juez=j.Id_juez
		ORDER BY i.Id_caso ASC) AS casojuez 
	INNER JOIN ambito_caso AS ac
	ON casojuez.Id_caso = ac.Id_caso
	WHERE descripcion_ambito = 'Estado')
    AS casoambitojuez
INNER JOIN caso AS c
ON casoambitojuez.Id_caso = c.Id_caso    
WHERE  fecha_estado_caso >'2020/01/01'
GROUP BY casoambitojuez.nombre
ORDER BY SUM(est_desvio) DESC
LIMIT 1   
    ;
 
 
 
/* Cuantos implicados son familia? Cuántos son hermanos, primos o están casados?*/
 SELECT COUNT(Id_implicado_1) AS 'número de implicados que son familia'
 FROM esfamiliar
 WHERE parentesco <> 'sin parentesco';
 
 /* Cuántos son hermanos, primos o están casados?*/
 SELECT parentesco, COUNT(Id_implicado_1) 
 FROM esfamiliar
 WHERE parentesco <> 'sin parentesco'
 GROUP BY parentesco;
 
 /* En qué ciudad viven los implicados en los casos de ambito bancario abiertos desde 2012 ?*/
 
 SELECT i.nombre AS 'nombre del implicado',i.ciudad AS 'vive en la ciudad'
 FROM (
	SELECT e.Id_implicado	
	FROM (
		SELECT c.Id_caso,c.nombre AS 'Nombre del caso'
		FROM caso AS c
		INNER JOIN ambito_caso AS ac
		ON c.Id_caso = ac.Id_caso
		WHERE fecha_estado_caso >= '2012/03/10' AND c.Id_estado_caso = 1 AND ac.descripcion_ambito = 'Banco'
		ORDER BY ac.descripcion_ambito) AS caso_abierto_banco_2012
	INNER JOIN envuelve AS e
	ON caso_abierto_banco_2012.Id_caso = e.Id_caso) AS implicado_caso_abierto_banco_2012
INNER JOIN implicado AS i
ON implicado_caso_abierto_banco_2012.Id_implicado = i.Id_implicado
;
 /* Cúal es el nombre y el patrimonio que tenían los implicados en casos cerrados y con dictamen registrado
 relativos al de fraude municipal descubiertos por el periodico The Times desde enero del año 2005? */
 
SELECT i.nombre AS 'nombre del implicado', ROUND(i.patrimonio/1000,0) AS 'Patrimonio (Miles de Euros)' 
FROM 		
	(SELECT e.Id_caso, e.Id_implicado AS Id_implicado, Q2.Nombre_del_caso AS Nombre_del_caso
	FROM (  
        SELECT d.Id_periodico AS Id_periodico, d.Id_caso AS Id_caso, Q1.Nombre_del_caso AS Nombre_del_caso
		FROM (
			SELECT c.Id_caso AS Id_caso ,c.nombre AS Nombre_del_caso
			FROM caso AS c
			INNER JOIN ambito_caso AS ac
			ON c.Id_caso = ac.Id_caso
			WHERE  c.Id_estado_caso = 3 AND ac.descripcion_ambito = 'Ayuntamiento'
			ORDER BY ac.descripcion_ambito
            ) AS Q1
		INNER JOIN descubre AS d
		ON Q1.Id_caso = d.Id_caso
		WHERE fecha_descubre> '2005/01/01'
        ) AS Q2
	INNER JOIN envuelve AS e 
	ON Q2.Id_caso = e.Id_caso
    )AS Q3
INNER JOIN implicado AS i
ON Q3.Id_implicado = i.Id_implicado;
 
 /* Cuál es la cantidad defraudada por cada partido político*/
 SELECT nombre AS 'Nombre partido político', ROUND(sum(est_desvio)/1000000,0) AS 'Fraude en Millones de Euros' 
 FROM(
	SELECT es_afiliado.id_implicado, partido_politico.id_partidopol, envuelve.id_caso, est_desvio, partido_politico.nombre
	FROM es_afiliado
    INNER JOIN envuelve INNER JOIN caso INNER JOIN partido_politico
	ON es_afiliado.id_implicado=envuelve.id_implicado
	AND envuelve.id_caso=caso.id_caso
	AND es_afiliado.Id_partidopol=partido_politico.Id_partidopol) AS subquery
 GROUP BY nombre
 ORDER BY sum(est_desvio) DESC;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 



 /* VISTA- Cuántos casos  y cuántos millones de Euros se han han desviado por ámbito */
CREATE VIEW NumCasosAmbitoMillones AS
SELECT COUNT(*) AS 'número de casos', descripcion_ambito, ROUND((SUM(est_desvio))/1000000,0) as 'Millones de Euros desviados'
 FROM caso AS c
 INNER JOIN ambito_caso AS ac
 ON c.Id_caso = ac.Id_caso
 group by descripcion_ambito
 ORDER BY SUM(est_desvio) DESC
 ;
 SELECT * FROM NumCasosAmbitoMillones;


 