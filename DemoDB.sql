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
  UNIQUE KEY `tipo_UNIQUE` (`tipo`),
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsoformazione`
--

LOCK TABLES `corsoformazione` WRITE;
/*!40000 ALTER TABLE `corsoformazione` DISABLE KEYS */;
INSERT INTO `corsoformazione` VALUES (50,'informatica','word',50,50,'1155');
/*!40000 ALTER TABLE `corsoformazione` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `iscritto` VALUES ('6600',50),('6615',50),('6625',50),('6635',50),('6645',50);
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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lezione`
--

LOCK TABLES `lezione` WRITE;
/*!40000 ALTER TABLE `lezione` DISABLE KEYS */;
INSERT INTO `lezione` VALUES (74,'lezione 1','lezione informatica','02:00:00','2021-12-30','11:00:00',50),(75,'lezione 2','lezione informatica','02:00:00','2021-12-31','10:00:00',50),(76,'lezione 3','lezione informatica','02:00:00','2022-01-01','09:00:00',50),(77,'lezione 4','lezione informatica','02:00:00','2022-01-02','12:00:00',50),(78,'lezione 5','lezione informatica','02:00:00','2022-01-03','12:00:00',50);
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
INSERT INTO `partecipa` VALUES ('6600',74),('6615',74),('6625',74),('6635',74),('6645',74),('6600',75),('6615',75),('6625',75),('6635',75),('6645',75),('6600',76),('6615',76),('6625',76),('6635',76),('6645',76),('6600',77),('6615',77),('6625',77),('6635',77),('6645',77),('6600',78),('6615',78),('6625',78),('6635',78),('6645',78);
/*!40000 ALTER TABLE `partecipa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistiche`
--

DROP TABLE IF EXISTS `statistiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statistiche` (
  `idstatistiche` int NOT NULL AUTO_INCREMENT,
  `mediostud` int DEFAULT NULL,
  `minstud` int DEFAULT NULL,
  `maxstud` int DEFAULT NULL,
  `riempimentomedio` int DEFAULT NULL,
  `idcorso` int NOT NULL,
  PRIMARY KEY (`idstatistiche`),
  KEY `Fk_corsoformaz_idx` (`idcorso`),
  CONSTRAINT `Fk_corsoformaz` FOREIGN KEY (`idcorso`) REFERENCES `corsoformazione` (`idcorso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistiche`
--

LOCK TABLES `statistiche` WRITE;
/*!40000 ALTER TABLE `statistiche` DISABLE KEYS */;
INSERT INTO `statistiche` VALUES (1,5,5,5,10,50);
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-29 20:24:34
