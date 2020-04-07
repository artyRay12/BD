-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: receipt
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `disease`
--

DROP TABLE IF EXISTS `disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disease` (
  `id_disease` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_disease`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disease`
--

LOCK TABLES `disease` WRITE;
/*!40000 ALTER TABLE `disease` DISABLE KEYS */;
INSERT INTO `disease` VALUES (1,'flu'),(2,'plague'),(6,'quinsy'),(7,'gastritis'),(8,'covid-19');
/*!40000 ALTER TABLE `disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug` (
  `id_drug` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `release_date` date NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `id_agregation` int NOT NULL,
  PRIMARY KEY (`id_drug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
INSERT INTO `drug` VALUES (1,'пектусин','2012-12-20','2012-12-20',2),(2,'аспирин','2014-12-29','2022-02-12',5),(3,'мезим','2014-12-01','2055-01-01',2);
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_agregation_state`
--

DROP TABLE IF EXISTS `drug_agregation_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_agregation_state` (
  `id_agregation` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_agregation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_agregation_state`
--

LOCK TABLES `drug_agregation_state` WRITE;
/*!40000 ALTER TABLE `drug_agregation_state` DISABLE KEYS */;
INSERT INTO `drug_agregation_state` VALUES (1,'liquid'),(2,'solid'),(3,'spray');
/*!40000 ALTER TABLE `drug_agregation_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_dealer`
--

DROP TABLE IF EXISTS `drug_dealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_dealer` (
  `id_drug_dealer` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `adress` varchar(100) NOT NULL,
  `phone_number` int NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id_drug_dealer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_dealer`
--

LOCK TABLES `drug_dealer` WRITE;
/*!40000 ALTER TABLE `drug_dealer` DISABLE KEYS */;
INSERT INTO `drug_dealer` VALUES (1,'columbian baron','randomhouse',911,'happy_byer@dog.com'),(2,'Pablo escobar','prison',228,'sad_dealer@cat.com');
/*!40000 ALTER TABLE `drug_dealer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_x_drugdealer`
--

DROP TABLE IF EXISTS `drug_x_drugdealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_x_drugdealer` (
  `id_drug` int NOT NULL,
  `id_drug_dealer` int NOT NULL,
  PRIMARY KEY (`id_drug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_x_drugdealer`
--

LOCK TABLES `drug_x_drugdealer` WRITE;
/*!40000 ALTER TABLE `drug_x_drugdealer` DISABLE KEYS */;
INSERT INTO `drug_x_drugdealer` VALUES (1,2),(2,2),(3,1);
/*!40000 ALTER TABLE `drug_x_drugdealer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_x_receipt`
--

DROP TABLE IF EXISTS `drug_x_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_x_receipt` (
  `id_drug_in_receipt` int NOT NULL AUTO_INCREMENT,
  `id_drug` int NOT NULL,
  `id_receipt` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id_drug_in_receipt`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_x_receipt`
--

LOCK TABLES `drug_x_receipt` WRITE;
/*!40000 ALTER TABLE `drug_x_receipt` DISABLE KEYS */;
INSERT INTO `drug_x_receipt` VALUES (1,1,2,4),(2,2,4,1),(3,1,3,4),(4,1,2,3),(5,3,1,2),(6,3,2,1),(7,3,1,3),(8,3,1,2);
/*!40000 ALTER TABLE `drug_x_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id_patient` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `birth` date NOT NULL,
  `height` int NOT NULL,
  `weight` int DEFAULT NULL,
  PRIMARY KEY (`id_patient`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'John','Travolta','1940-10-09',175,80),(21,'John','Lennon','1940-10-09',185,80),(22,'Paul','McCartney','1941-10-09',180,70),(23,'George','Harrison','1942-10-09',195,60),(24,'Rigno','Star','1943-10-09',165,70),(25,'Freddie','Mercury','1945-10-09',176,73);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `id_receipt` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `id_patient` int NOT NULL,
  `id_disease` int NOT NULL,
  PRIMARY KEY (`id_receipt`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (1,'2012-01-02',1,1),(2,'2012-01-02',21,1),(3,'2012-01-02',23,2),(4,'2013-01-02',24,2),(5,'2013-01-02',25,6),(6,'2014-01-02',23,1),(7,'2014-01-02',1,7),(8,'2015-01-02',24,2),(9,'2015-01-02',25,1),(10,'2014-01-02',21,2),(11,'2013-01-02',22,6),(12,'2014-01-03',23,1);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-08  2:36:58
