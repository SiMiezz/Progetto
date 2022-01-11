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
INSERT INTO `areetematiche` VALUES ('informazione','automatica',1,'1155'),('matematica','base',3,'1155'),('tecnologia','avanzata',1,'1155');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidArea` BEFORE INSERT ON `areetematiche` FOR EACH ROW BEGIN

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
  `datacreazione` date NOT NULL,
  `presenzemin` int NOT NULL,
  `maxpartecipanti` int NOT NULL,
  `id` varchar(30) NOT NULL,
  PRIMARY KEY (`idcorso`),
  KEY `Fk_op_idx` (`id`),
  CONSTRAINT `Fk_op` FOREIGN KEY (`id`) REFERENCES `operatore` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `percentuale_presenze` CHECK (((`presenzemin` >= 0) and (`presenzemin` <= 100)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsoformazione`
--

LOCK TABLES `corsoformazione` WRITE;
/*!40000 ALTER TABLE `corsoformazione` DISABLE KEYS */;
INSERT INTO `corsoformazione` VALUES (1,'informatica','word','2022-01-05',50,15,'1155'),(2,'algebra','polinomi','2022-01-05',30,20,'1155'),(3,'analisi','limiti','2022-01-05',60,30,'1155'),(4,'ade','circuiti','2022-01-05',20,25,'1255'),(5,'laboratorio','java object','2022-01-05',25,10,'1255'),(7,'algoritmi','sorting','2022-01-09',50,100,'1255'),(8,'geometria','spazi vettoriali','2022-01-09',20,15,'1255');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_Lessons` AFTER INSERT ON `corsoformazione` FOR EACH ROW BEGIN
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

--
-- Table structure for table `iscritto`
--

DROP TABLE IF EXISTS `iscritto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iscritto` (
  `matricola` varchar(15) NOT NULL,
  `idcorso` int NOT NULL,
  UNIQUE KEY `iscritto_UNIQUE` (`matricola`,`idcorso`),
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
INSERT INTO `iscritto` VALUES ('6600',1),('6615',2),('6600',3),('6615',3),('6600',4),('6615',4),('6625',4),('6600',5),('6615',5),('6600',7);
/*!40000 ALTER TABLE `iscritto` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidIscritto` BEFORE INSERT ON `iscritto` FOR EACH ROW BEGIN

IF new.idcorso NOT IN (SELECT corso.idcorso FROM corsoformazione AS corso LEFT JOIN terminazione AS ter ON corso.idcorso = ter.idcorso WHERE corso.idcorso = new.idcorso AND ter.id IS NULL ) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lezione`
--

LOCK TABLES `lezione` WRITE;
/*!40000 ALTER TABLE `lezione` DISABLE KEYS */;
INSERT INTO `lezione` VALUES (1,'lezione 1','lezione informatica','02:00:00','2022-01-06','11:00:00',1),(2,'lezione 1','lezione algebra','02:00:00','2022-01-06','18:00:00',2),(3,'lezione 2','lezione algebra','02:00:00','2022-01-07','11:00:00',2),(4,'lezione 3','lezione algebra','02:00:00','2022-01-08','15:00:00',2),(5,'lezione 1','lezione analisi','02:00:00','2022-01-06','09:00:00',3),(6,'lezione 1','lezione ade','02:00:00','2022-01-06','17:00:00',4),(7,'lezione 2','lezione ade','02:00:00','2022-01-07','09:00:00',4),(8,'lezione 3','lezione ade','02:00:00','2022-01-08','11:00:00',4),(9,'lezione 4','lezione ade','02:00:00','2022-01-09','13:00:00',4),(10,'lezione 5','lezione ade','02:00:00','2022-01-10','15:00:00',4),(11,'lezione 6','lezione ade','02:00:00','2022-01-11','15:00:00',4),(12,'lezione 1','lezione laboratorio','02:00:00','2022-01-06','14:00:00',5),(13,'lezione 2','lezione laboratorio','02:00:00','2022-01-07','14:00:00',5),(14,'lezione 3','lezione laboratorio','02:00:00','2022-01-08','12:00:00',5),(15,'lezione 4','lezione laboratorio','02:00:00','2022-01-09','13:00:00',5),(16,'lezione 5','lezione laboratorio','02:00:00','2022-01-10','17:00:00',5),(20,'lezione 6','lezione laboratorio','02:00:00','2022-01-11','11:00:00',5),(21,'lezione 1','lezione algoritmi','02:00:00','2022-01-10','09:00:00',7),(22,'lezione 2','lezione algoritmi','02:00:00','2022-01-11','14:00:00',7),(23,'lezione 1','lezione geometria','02:00:00','2022-01-10','11:00:00',8),(24,'lezione 2','lezione geometria','02:00:00','2022-01-11','16:00:00',8),(25,'lezione 3','lezione geometria','02:00:00','2022-01-12','09:00:00',8),(26,'lezione 4','lezione geometria','02:00:00','2022-01-13','16:00:00',8),(27,'lezione 5','lezione geometria','02:00:00','2022-01-14','16:00:00',8),(28,'lezione 6','lezione geometria','02:00:00','2022-01-15','15:00:00',8);
/*!40000 ALTER TABLE `lezione` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidLesson` BEFORE INSERT ON `lezione` FOR EACH ROW BEGIN

IF new.idcorso NOT IN (SELECT corso.idcorso FROM corsoformazione AS corso LEFT JOIN terminazione AS ter ON corso.idcorso = ter.idcorso WHERE corso.idcorso = new.idcorso AND ter.id IS NULL ) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
ELSEIF new.datainizio < (SELECT corso.datacreazione FROM corsoformazione AS corso WHERE corso.idcorso = new.idcorso) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
INSERT INTO `operatore` VALUES ('1155','giuseppe','giordi','1999-02-07','6677','ok'),('1255','gospi','gospel','2000-09-07','8899','ok');
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
INSERT INTO `partecipa` VALUES ('6600',1),('6615',2),('6615',5),('6600',6),('6615',6),('6625',6),('6600',7),('6615',7),('6625',7),('6600',8),('6615',8),('6600',9),('6615',9),('6625',10),('6600',11),('6625',11),('6600',12),('6600',13),('6600',14),('6600',15),('6600',16),('6600',21);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isLessonFull` BEFORE INSERT ON `partecipa` FOR EACH ROW BEGIN

IF new.idlezione NOT IN (SELECT lezvisual.idlezione FROM (SELECT lez.idlezione, COUNT(par.matricola) visual, corso.maxpartecipanti FROM lezione AS lez LEFT JOIN partecipa AS par ON par.idlezione = lez.idlezione JOIN corsoformazione AS corso ON corso.idcorso = lez.idcorso WHERE lez.idlezione = new.idlezione) AS lezvisual WHERE lezvisual.visual < lezvisual.maxpartecipanti) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidPartecipa` BEFORE INSERT ON `partecipa` FOR EACH ROW BEGIN

IF new.idlezione NOT IN (SELECT lez.idlezione FROM (lezione AS lez JOIN iscritto AS isc ON lez.idcorso = isc.idcorso ) LEFT JOIN terminazione AS ter ON ter.idcorso = lez.idcorso WHERE lez.idlezione = new.idlezione AND isc.matricola = new.matricola AND ter.id IS NULL) THEN
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistiche`
--

LOCK TABLES `statistiche` WRITE;
/*!40000 ALTER TABLE `statistiche` DISABLE KEYS */;
INSERT INTO `statistiche` VALUES (1,1,1,1,3,3),(2,0,0,1,0,2),(3,1,1,1,7,1),(4,2,1,3,8,4);
/*!40000 ALTER TABLE `statistiche` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidStatistiche` BEFORE INSERT ON `statistiche` FOR EACH ROW BEGIN

IF new.idcorso NOT IN(SELECT ter.idcorso FROM terminazione AS ter WHERE ter.idcorso = new.idcorso) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
INSERT INTO `studente` VALUES ('6600','simi','giordi','2001-02-09','5566','ok'),('6615','ferdi','giordi','2002-09-08','6699','ok'),('6625','kuki','giordi','1997-09-07','9988','ok');
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
INSERT INTO `superamento` VALUES (1,'6600',1),(0,'6600',3),(1,'6600',4),(1,'6615',2),(1,'6615',3),(1,'6615',4),(1,'6625',4);
/*!40000 ALTER TABLE `superamento` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidSuperamento` BEFORE INSERT ON `superamento` FOR EACH ROW BEGIN

IF new.idcorso NOT IN(SELECT ter.idcorso FROM terminazione AS ter WHERE ter.idcorso = new.idcorso) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `terminazione`
--

DROP TABLE IF EXISTS `terminazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terminazione` (
  `idcorso` int NOT NULL,
  `id` varchar(30) NOT NULL,
  UNIQUE KEY `idcorso_UNIQUE` (`idcorso`),
  KEY `Fk_op1_idx` (`id`),
  CONSTRAINT `Fk_corsoformazione1` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_op1` FOREIGN KEY (`id`) REFERENCES `operatore` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminazione`
--

LOCK TABLES `terminazione` WRITE;
/*!40000 ALTER TABLE `terminazione` DISABLE KEYS */;
INSERT INTO `terminazione` VALUES (1,'1155'),(2,'1155'),(3,'1155'),(4,'1255');
/*!40000 ALTER TABLE `terminazione` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `isValidTermina` BEFORE INSERT ON `terminazione` FOR EACH ROW BEGIN

IF new.id NOT IN (SELECT corso.id FROM corsoformazione AS corso WHERE corso.id = new.id AND corso.idcorso = new.idcorso) THEN
SIGNAl SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR';
END IF;

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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_Stat_Superamento` AFTER INSERT ON `terminazione` FOR EACH ROW BEGIN
DECLARE
partecipazioni,numlezioni,minpartecipalez,maxpartecipalez,riempimedio,mediastud,minpresenze,maxpartecipa INT;

DECLARE stp INT DEFAULT 0;
DECLARE mat VARCHAR(15) DEFAULT null;
DECLARE visualizzazioni INT DEFAULT 0;

DECLARE studcurr
CURSOR FOR SELECT studvisual.matricola, studvisual.visual
FROM (SELECT COUNT(par.matricola) visual, isc.matricola
FROM (lezione AS lez JOIN iscritto AS isc ON lez.idcorso = isc.idcorso) LEFT JOIN partecipa AS par ON isc.matricola = par.matricola AND par.idlezione = lez.idlezione
WHERE lez.idcorso = new.idcorso
GROUP BY(isc.matricola)) as studvisual;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET stp = 1;

SET partecipazioni = 0, numlezioni = 0, minpartecipalez = 0, maxpartecipalez = 0, riempimedio = 0, mediastud = 0, maxpartecipa = 0, minpresenze = 0;

SELECT COUNT(*) INTO partecipazioni
FROM lezione AS lez JOIN partecipa AS par ON lez.idlezione = par.idlezione
WHERE lez.idcorso = new.idcorso;

SELECT COUNT(*) INTO numlezioni
FROM lezione AS lez 
WHERE lez.idcorso = new.idcorso;

SET mediastud = partecipazioni/numlezioni;

SELECT MIN(parlez) INTO minpartecipalez
FROM (SELECT COUNT(par.idlezione) parlez,lez.idlezione 
FROM lezione AS lez LEFT JOIN partecipa AS par ON lez.idlezione = par.idlezione
WHERE lez.idcorso = new.idcorso
GROUP BY (lez.idlezione)) as conto;

SELECT MAX(parlez) INTO maxpartecipalez
FROM (SELECT COUNT(par.idlezione) parlez,lez.idlezione 
FROM lezione AS lez LEFT JOIN partecipa AS par ON lez.idlezione = par.idlezione
WHERE lez.idcorso = new.idcorso
GROUP BY (lez.idlezione)) as conto;

SELECT corso.maxpartecipanti INTO maxpartecipa
FROM corsoformazione AS corso
WHERE corso.idcorso = new.idcorso;

SELECT corso.presenzemin INTO minpresenze
FROM corsoformazione AS corso
WHERE corso.idcorso = new.idcorso;

SET riempimedio = (mediastud/maxpartecipa)*100;

INSERT INTO statistiche(mediostud,minstud,maxstud,riempimentomedio,idcorso) VALUES (mediastud,minpartecipalez,maxpartecipalez,riempimedio,new.idcorso);

OPEN studcurr;

cursor_loop: LOOP
	FETCH studcurr INTO mat,visualizzazioni;
    IF stp = 1 THEN
		LEAVE cursor_loop;
	END IF;
    IF visualizzazioni >= (minpresenze * numlezioni)/100 THEN
		INSERT INTO superamento(superato,matricola,idcorso) VALUES(true,mat,new.idcorso);
    ELSE
		INSERT INTO superamento(superato,matricola,idcorso) VALUES(false,mat,new.idcorso);
    END IF;
END LOOP cursor_loop;

CLOSE studcurr;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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

-- Dump completed on 2022-01-11 22:00:27
