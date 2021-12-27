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
  KEY `Fk_corso_idx` (`idcorso`),
  KEY `Fk_corsoformazione_idx` (`idcorso`),
  CONSTRAINT `Fk_corsoformazione` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areetematiche`
--

LOCK TABLES `areetematiche` WRITE;
/*!40000 ALTER TABLE `areetematiche` DISABLE KEYS */;
/*!40000 ALTER TABLE `areetematiche` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`idcorso`),
  KEY `Fk_op_idx` (`id`),
  CONSTRAINT `Fk_op` FOREIGN KEY (`id`) REFERENCES `operatore` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsoformazione`
--

LOCK TABLES `corsoformazione` WRITE;
/*!40000 ALTER TABLE `corsoformazione` DISABLE KEYS */;
INSERT INTO `corsoformazione` VALUES (30,'informatica','word',50,120,'1155'),(31,'italiano','letteratura',40,150,'1155'),(32,'programmazione','java',30,120,'1155'),(33,'algebra','polinomi',30,150,'1255'),(34,'analisi','limiti',50,250,'1255');
/*!40000 ALTER TABLE `corsoformazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscritto`
--

DROP TABLE IF EXISTS `iscritto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iscritto` (
  `data` date NOT NULL,
  `orario` time DEFAULT NULL,
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
INSERT INTO `iscritto` VALUES ('2021-12-27','13:14:16','6600',30),('2021-12-27','13:14:13','6600',32),('2021-12-27','13:14:10','6600',34),('2021-12-27','13:15:15','6615',31),('2021-12-27','13:15:17','6615',33);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lezione`
--

LOCK TABLES `lezione` WRITE;
/*!40000 ALTER TABLE `lezione` DISABLE KEYS */;
INSERT INTO `lezione` VALUES (10,'lezione 1','lezione informatica','02:00:00','2021-12-27','12:41:58',30),(11,'lezione 2','lezione informatica','02:00:00','2021-12-27','12:41:58',30),(12,'lezione 1','lezione italiano','02:00:00','2021-12-27','12:44:46',31),(13,'lezione 2','lezione italiano','02:00:00','2021-12-27','12:44:46',31),(14,'lezione 3','lezione italiano','02:00:00','2021-12-27','12:44:46',31),(15,'lezione 4','lezione italiano','02:00:00','2021-12-27','12:44:46',31),(16,'lezione 1','lezione programmazione','02:00:00','2021-12-27','12:45:05',32),(17,'lezione 2','lezione programmazione','02:00:00','2021-12-27','12:45:05',32),(18,'lezione 3','lezione programmazione','02:00:00','2021-12-27','12:45:05',32),(19,'lezione 4','lezione programmazione','02:00:00','2021-12-27','12:45:05',32),(20,'lezione 5','lezione programmazione','02:00:00','2021-12-27','12:45:05',32),(21,'lezione 6','lezione programmazione','02:00:00','2021-12-27','12:45:05',32),(22,'lezione 1','lezione algebra','02:00:00','2021-12-27','12:45:29',33),(23,'lezione 2','lezione algebra','02:00:00','2021-12-27','12:45:29',33),(24,'lezione 3','lezione algebra','02:00:00','2021-12-27','12:45:29',33),(25,'lezione 4','lezione algebra','02:00:00','2021-12-27','12:45:29',33),(26,'lezione 1','lezione analisi','02:00:00','2021-12-27','12:45:38',34),(27,'lezione 2','lezione analisi','02:00:00','2021-12-27','12:45:38',34),(28,'lezione 3','lezione analisi','02:00:00','2021-12-27','12:45:38',34),(29,'lezione 4','lezione analisi','02:00:00','2021-12-27','12:45:38',34);
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
  `data` date NOT NULL,
  `orario` time DEFAULT NULL,
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
INSERT INTO `studente` VALUES ('6600','gospi','gospel','2000-01-02','5566','ok'),('6615','simone','giordano','2001-02-07','4455','ok');
/*!40000 ALTER TABLE `studente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-27 21:49:19
