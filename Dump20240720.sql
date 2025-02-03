-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: inventory
-- ------------------------------------------------------
-- Server version	8.4.1

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
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `CustomerFirstName` varchar(20) NOT NULL,
  `CustomerLastName` varchar(20) NOT NULL,
  `CustomerEmail` varchar(30) NOT NULL,
  `CustomerContactNum` varchar(30) NOT NULL,
  `CustomerBirthMonth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'Aaron','Hotchner','aaron.hotchner@example.com','+353871234567','November'),(2,'Spencer','Reid','spencer.reid@example.com','+353857654321','October'),(3,'Derek','Morgan','derek.morgan@example.com','+353861234876','June'),(4,'Penelope','Garcia','penelope.garcia@example.com','+353871234432','March'),(5,'Jennifer','Jareau','jennifer.jareau@example.com','+353851234246','December'),(6,'David','Rossi','david.rossi@example.com','+353861234135','May'),(7,'Emily','Prentiss','emily.prentiss@example.com','+353871234975','September'),(8,'Jason','Gideon','jason.gideon@example.com','+353861234001','February');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `ProductBarcode` varchar(20) NOT NULL,
  `ProductName` varchar(50) NOT NULL,
  `ProductCollection` varchar(30) DEFAULT NULL,
  `ProductColour` varchar(20) DEFAULT NULL,
  `ProductPrice` decimal(10,2) DEFAULT NULL,
  `ProductReleaseYear` int DEFAULT NULL,
  `QuantityInStock` int DEFAULT NULL,
  `ReservedQuantity` int DEFAULT NULL,
  PRIMARY KEY (`ProductBarcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES ('101010','Cassie Crossbody 20 Black','Cassie','Black',350.00,2020,12,2),('101011','Cassie Crossbody 20 Chark','Cassie','Chark',350.00,2020,10,1),('101012','Cassie Crossbody 20 Pink','Cassie','Pink',350.00,2020,6,1),('202010','Tabby Quilted 26 Black','Tabby','Black',595.00,2018,10,1),('202011','Tabby Quilted 26 Chark','Tabby','Chark',595.00,2018,13,1),('202012','Tabby Quilted 26 Pink','Tabby','Pink',595.00,2018,6,1),('303010','Soho 2024 Black','Soho','Black',425.00,2024,8,0),('303011','Soho 2024 Chark','Soho','Chark',425.00,2024,8,0),('303012','Soho 2024 Pink','Soho','Pink',425.00,2024,8,0);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `CustomerEmail` varchar(30) DEFAULT NULL,
  `CustomerFirstName` varchar(20) DEFAULT NULL,
  `ProductBarcode` varchar(20) NOT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ReservationStatus` varchar(20) NOT NULL,
  PRIMARY KEY (`ReservationID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (1,'RachelGreen','aaron.hotchner@example.com','Aaron','101010','2024-07-17','Active'),(2,'RachelGreen','spencer.reid@example.com','Spencer','101010','2024-07-17','Active'),(3,'PhoebeBuffay','derek.morgan@example.com','Derek','101011','2024-07-17','Active'),(4,'PhoebeBuffay','penelope.garcia@example.com','Penelope','101012','2024-07-17','Active'),(5,'RachelGreen','jennifer.jareau@example.com','Jennifer','202010','2024-07-17','Active'),(6,'RachelGreen','david.rossi@example.com','David','202011','2024-07-17','Active'),(7,'RachelGreen','emily.prentiss@example.com','Emily','202012','2024-07-17','Active'),(8,'RachelGreen','aaron.hotchner@example.com','Aaron','101010','2024-07-17','Active'),(9,'RachelGreen','spencer.reid@example.com','Spencer','101010','2024-07-17','Active');
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `UserFirstName` varchar(20) NOT NULL,
  `UserLastName` varchar(20) NOT NULL,
  `UserRole` varchar(20) NOT NULL,
  `UserPassword` varchar(20) NOT NULL,
  `UserEmail` varchar(30) NOT NULL,
  `UserStatus` varchar(20) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserName` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'RachelGreen','Rachel','Green','SalesAssistant','Password','rachelgreen@example.com','Active'),(2,'MonicaGeller','Monica','Geller','SalesAssistant','Password','monicageller@example.com','Active'),(3,'PhoebeBuffay','Phoebe','Buffay','Manager','Password','phoebebuffay@example.com','Active'),(4,'JoeyTribbiani','Joey','Tribbiani','SalesAssistant','Password','joeytribbiani@example.com','Active'),(5,'ChandlerBing','Chandler','Bing','SalesAssistant','Password','chandlerbing@example.com','Active'),(6,'RossGeller','Ross','Geller','SalesAssistant','Password','rossgeller@example.com','Inactive');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-20 18:27:52
