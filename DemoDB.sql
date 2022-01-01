CREATE DATABASE  IF NOT EXISTS `demodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `demodb`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: demodb
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `areetematiche`
--

DROP TABLE IF EXISTS `areetematiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areetematiche` (
  `tipo` varchar(30) NOT NULL,
  `descrizione` text,
  `idcorso` int NOT NULL,
  `id` varchar(30) NOT NULL,
  UNIQUE KEY `tipo_UNIQUE` (`tipo`),
  KEY `Fk_corso_idx` (`idcorso`),
  KEY `Fk_corsoformazione_idx` (`idcorso`),
  KEY `Fk_operatore_idx` (`id`),
  CONSTRAINT `Fk_corsoformazione` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_operatore` FOREIGN KEY (`id`) REFERENCES `operatore` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areetematiche`
--

LOCK TABLES `areetematiche` WRITE;
/*!40000 ALTER TABLE `areetematiche` DISABLE KEYS */;
INSERT INTO `areetematiche` VALUES ('informazione','',57,'1155'),('logica','applicata',60,'1255'),('matematica','base',59,'1155'),('tecnologia','avanzata',57,'1155');
/*!40000 ALTER TABLE `areetematiche` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areetematiche_BEFORE_INSERT` BEFORE INSERT ON `areetematiche` FOR EACH ROW BEGIN

IF new.id NOT IN (SELECT cs.id FROM corsoformazione AS cs WHERE cs.idcorso = new.idcorso AND cs.id = new.id) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `corsoformazione`
--

DROP TABLE IF EXISTS `corsoformazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsoformazione` (
  `idcorso` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `descrizione` text,
  `presenzemin` int NOT NULL,
  `maxpartecipanti` int NOT NULL,
  `id` varchar(30) NOT NULL,
  `terminato` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idcorso`),
  KEY `Fk_op_idx` (`id`),
  CONSTRAINT `Fk_op` FOREIGN KEY (`id`) REFERENCES `operatore` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsoformazione`
--

LOCK TABLES `corsoformazione` WRITE;
/*!40000 ALTER TABLE `corsoformazione` DISABLE KEYS */;
INSERT INTO `corsoformazione` VALUES (57,'informatica','word',50,120,'1155',0),(58,'algebra','polinomi',30,120,'1155',0),(59,'analisi','limiti',60,200,'1155',0),(60,'algoritmi','sorting',40,120,'1255',0);
/*!40000 ALTER TABLE `corsoformazione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `aggiungi_lezioni` AFTER INSERT ON `corsoformazione` FOR EACH ROW BEGIN
DECLARE
i INT;
SET i = 1;

WHILE i<=(SELECT FLOOR(RAND()*(10-1+1)+1)) DO

INSERT INTO lezione(titolo,descrizione,durata,datainizio,orarioinizio,idcorso) VALUES ((SELECT concat('lezione ',(SELECT convert(i,char)))),(SELECT concat('lezione ',new.nome)),'02:00:00',(SELECT date_add((SELECT CURDATE()), interval i day)),(SELECT (SELECT convert('08:00:00',time))+interval floor(rand()*(10)+1) hour),new.idcorso);
SET i = i+1;

END WHILE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `aggiungi_statistiche` AFTER UPDATE ON `corsoformazione` FOR EACH ROW BEGIN
DECLARE
partecipazioni,numlezioni,minpartecipa,maxpartecipa,riempimedio,mediastud INT;

DECLARE stp INT DEFAULT 0;
DECLARE mat VARCHAR(15) DEFAULT null;
DECLARE visualizzazioni INT DEFAULT 0;

DECLARE studcurr
CURSOR FOR SELECT studvisual.matricola, studvisual.visual
FROM (SELECT COUNT(par.matricola) visual,isc.matricola 
FROM (lezione AS lez JOIN partecipa AS par ON lez.idlezione = par.idlezione) RIGHT JOIN iscritto AS isc ON par.matricola = isc.matricola
WHERE isc.idcorso = new.idcorso
GROUP BY (isc.matricola)) as studvisual;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET stp = 1;

SET partecipazioni = 0, numlezioni = 0, minpartecipa = 0, maxpartecipa = 0, riempimedio = 0, mediastud = 0;

IF new.terminato = true AND old.terminato = false THEN
SELECT COUNT(*) INTO partecipazioni 
FROM lezione AS lez JOIN partecipa AS par ON lez.idlezione = par.idlezione
WHERE lez.idcorso = new.idcorso;

SELECT COUNT(*) INTO numlezioni
FROM lezione AS lez 
WHERE lez.idcorso = new.idcorso;

SET mediastud = partecipazioni/numlezioni;

SELECT MIN(parlez) INTO minpartecipa
FROM (SELECT COUNT(*) parlez,lez.idlezione 
FROM lezione AS lez JOIN partecipa AS par ON lez.idlezione = par.idlezione
WHERE lez.idcorso = new.idcorso
GROUP BY lez.idlezione) as conto;

SELECT MAX(parlez) INTO maxpartecipa
FROM (SELECT COUNT(*) parlez,lez.idlezione 
FROM lezione AS lez JOIN partecipa AS par ON lez.idlezione = par.idlezione
WHERE lez.idcorso = new.idcorso
GROUP BY lez.idlezione) as conto;

INSERT INTO statistiche(mediostud,minstud,maxstud,riempimentomedio,idcorso) VALUES (mediastud,minpartecipa,maxpartecipa,((mediastud/new.maxpartecipanti)*100),new.idcorso);

OPEN studcurr;

cursor_loop: LOOP
	FETCH studcurr INTO mat,visualizzazioni;
    IF stp = 1 THEN
		LEAVE cursor_loop;
	END IF;
    IF visualizzazioni >= ((new.presenzemin * (SELECT COUNT(*) FROM lezione AS lez WHERE lez.idcorso = new.idcorso))/100) THEN
		INSERT INTO superamento(superato,matricola,idcorso) VALUES(true,mat,new.idcorso);
    ELSE
		INSERT INTO superamento(superato,matricola,idcorso) VALUES(false,mat,new.idcorso);
    END IF;
END LOOP cursor_loop;

CLOSE studcurr;

END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `iscritto`
--

DROP TABLE IF EXISTS `iscritto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iscritto` (
  `matricola` varchar(15) NOT NULL,
  `idcorso` int NOT NULL,
  UNIQUE KEY `stud_UNIQUE` (`matricola`,`idcorso`),
  KEY `fk_stud_idx` (`matricola`),
  KEY `fk_corso_idx` (`idcorso`),
  CONSTRAINT `fk_corso` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stud` FOREIGN KEY (`matricola`) REFERENCES `studente` (`matricola`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscritto`
--

LOCK TABLES `iscritto` WRITE;
/*!40000 ALTER TABLE `iscritto` DISABLE KEYS */;
INSERT INTO `iscritto` VALUES ('6600',57);
/*!40000 ALTER TABLE `iscritto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lezione`
--

DROP TABLE IF EXISTS `lezione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lezione` (
  `idlezione` int NOT NULL AUTO_INCREMENT,
  `titolo` varchar(30) NOT NULL,
  `descrizione` text,
  `durata` time NOT NULL,
  `datainizio` date NOT NULL,
  `orarioinizio` time NOT NULL,
  `idcorso` int NOT NULL,
  PRIMARY KEY (`idlezione`),
  KEY `Fk_corsi_idx` (`idcorso`),
  CONSTRAINT `Fk_corsi` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lezione`
--

LOCK TABLES `lezione` WRITE;
/*!40000 ALTER TABLE `lezione` DISABLE KEYS */;
INSERT INTO `lezione` VALUES (99,'lezione 1','lezione informatica','02:00:00','2022-01-01','10:00:00',57),(100,'lezione 2','lezione informatica','02:00:00','2022-01-02','18:00:00',57),(101,'lezione 3','lezione informatica','02:00:00','2022-01-03','16:00:00',57),(102,'lezione 4','lezione informatica','02:00:00','2022-01-04','09:00:00',57),(103,'lezione 5','lezione informatica','02:00:00','2022-01-05','10:00:00',57),(104,'lezione 6','lezione informatica','02:00:00','2022-01-06','14:00:00',57),(105,'lezione 7','lezione informatica','02:00:00','2022-01-07','16:00:00',57),(106,'lezione 1','lezione algebra','02:00:00','2022-01-01','14:00:00',58),(107,'lezione 2','lezione algebra','02:00:00','2022-01-02','17:00:00',58),(108,'lezione 3','lezione algebra','02:00:00','2022-01-03','15:00:00',58),(109,'lezione 4','lezione algebra','02:00:00','2022-01-04','16:00:00',58),(110,'lezione 5','lezione algebra','02:00:00','2022-01-05','13:00:00',58),(111,'lezione 1','lezione analisi','02:00:00','2022-01-01','11:00:00',59),(112,'lezione 2','lezione analisi','02:00:00','2022-01-02','15:00:00',59),(113,'lezione 3','lezione analisi','02:00:00','2022-01-03','12:00:00',59),(114,'lezione 1','lezione algoritmi','02:00:00','2022-01-02','13:00:00',60),(115,'lezione 2','lezione algoritmi','02:00:00','2022-01-03','09:00:00',60),(116,'lezione 3','lezione algoritmi','02:00:00','2022-01-04','15:00:00',60),(117,'lezione 4','lezione algoritmi','02:00:00','2022-01-05','11:00:00',60),(118,'lezione 5','lezione algoritmi','02:00:00','2022-01-06','09:00:00',60);
/*!40000 ALTER TABLE `lezione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatore`
--

DROP TABLE IF EXISTS `operatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operatore` (
  `id` varchar(30) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `data` date DEFAULT NULL,
  `cf` varchar(16) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cf_UNIQUE` (`cf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatore`
--

LOCK TABLES `operatore` WRITE;
/*!40000 ALTER TABLE `operatore` DISABLE KEYS */;
INSERT INTO `operatore` VALUES ('1155','simi','giordi','1998-03-11','7788','ok'),('1255','giuseppe','costabile','1999-03-09','9988','ok');
/*!40000 ALTER TABLE `operatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partecipa`
--

DROP TABLE IF EXISTS `partecipa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partecipa` (
  `matricola` varchar(15) NOT NULL,
  `idlezione` int NOT NULL,
  UNIQUE KEY `Partecipa_UNIQUE` (`idlezione`,`matricola`),
  KEY `Fk_studente_idx` (`matricola`),
  KEY `Fk_lezione_idx` (`idlezione`),
  CONSTRAINT `Fk_lezione` FOREIGN KEY (`idlezione`) REFERENCES `lezione` (`idlezione`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_studente` FOREIGN KEY (`matricola`) REFERENCES `studente` (`matricola`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partecipa`
--

LOCK TABLES `partecipa` WRITE;
/*!40000 ALTER TABLE `partecipa` DISABLE KEYS */;
/*!40000 ALTER TABLE `partecipa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `partecipa_BEFORE_INSERT` BEFORE INSERT ON `partecipa` FOR EACH ROW BEGIN

IF new.idlezione NOT IN (SELECT lez.idlezione FROM lezione AS lez JOIN iscritto AS isc ON lez.idcorso = isc.idcorso WHERE lez.idlezione = new.idlezione) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `statistiche`
--

DROP TABLE IF EXISTS `statistiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statistiche` (
  `idstatistiche` int NOT NULL AUTO_INCREMENT,
  `mediostud` int NOT NULL,
  `minstud` int NOT NULL,
  `maxstud` int NOT NULL,
  `riempimentomedio` int NOT NULL,
  `idcorso` int NOT NULL,
  PRIMARY KEY (`idstatistiche`),
  UNIQUE KEY `idcorso_UNIQUE` (`idcorso`),
  KEY `Fk_corsoformaz_idx` (`idcorso`),
  CONSTRAINT `Fk_corsoformaz` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistiche`
--

LOCK TABLES `statistiche` WRITE;
/*!40000 ALTER TABLE `statistiche` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studente`
--

DROP TABLE IF EXISTS `studente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studente` (
  `matricola` varchar(15) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `data` date DEFAULT NULL,
  `cf` varchar(16) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`matricola`),
  UNIQUE KEY `cf_UNIQUE` (`cf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studente`
--

LOCK TABLES `studente` WRITE;
/*!40000 ALTER TABLE `studente` DISABLE KEYS */;
INSERT INTO `studente` VALUES ('6600','gospi','gospel','2000-01-02','5566','ok'),('6615','simone','giordano','2001-02-07','4455','ok'),('6625','giordi','giordi','1998-02-09','7798','ok'),('6635','ferdi','giordi','2002-08-09','345678','ok'),('6645','toni','effe','2000-09-09','12345678','ok');
/*!40000 ALTER TABLE `studente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `superamento`
--

DROP TABLE IF EXISTS `superamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `superamento` (
  `superato` tinyint NOT NULL,
  `matricola` varchar(15) NOT NULL,
  `idcorso` int NOT NULL,
  UNIQUE KEY `stud_UNIQUE` (`matricola`,`idcorso`),
  KEY `Fk_studente_idx` (`matricola`),
  KEY `Fk_corso1_idx` (`idcorso`),
  CONSTRAINT `Fk_corso1` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_studente1` FOREIGN KEY (`matricola`) REFERENCES `studente` (`matricola`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `superamento`
--

LOCK TABLES `superamento` WRITE;
/*!40000 ALTER TABLE `superamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `superamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'demodb'
--

--
-- Dumping routines for database 'demodb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-01 18:05:23
