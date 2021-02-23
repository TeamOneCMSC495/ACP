-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: cmsc495
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `AccountID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `LoyaltyPoints` int NOT NULL DEFAULT '0',
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`AccountID`),
  KEY `fk_Account_Person_idx` (`PersonID`),
  CONSTRAINT `fk_Account_Person` FOREIGN KEY (`PersonID`) REFERENCES `person` (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounthistory`
--

DROP TABLE IF EXISTS `accounthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounthistory` (
  `AccounthistoryID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `PersonID` int NOT NULL,
  `LoyaltyPoints` int NOT NULL DEFAULT '0',
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`AccounthistoryID`),
  KEY `fk_AccountHistory_idx` (`AccountID`),
  CONSTRAINT `fk_AccountHistory` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `AdministratorID` int NOT NULL AUTO_INCREMENT,
  `LoginID` int NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AdministratorID`),
  KEY `fk_Administrator_Login_idx` (`LoginID`),
  CONSTRAINT `fk_Administrator_Login` FOREIGN KEY (`LoginID`) REFERENCES `login` (`LoginID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creditcard`
--

DROP TABLE IF EXISTS `creditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creditcard` (
  `CreditCardID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `MaskedCreditCard` varchar(16) NOT NULL,
  `ExpirationDate` date NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`CreditCardID`),
  KEY `fk_CreditCard_Account_idx` (`AccountID`),
  CONSTRAINT `fk_CreditCard_Account` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creditcardhistory`
--

DROP TABLE IF EXISTS `creditcardhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creditcardhistory` (
  `creditcardhistoryID` int NOT NULL AUTO_INCREMENT,
  `CreditCardID` int NOT NULL,
  `AccountID` int NOT NULL,
  `MaskedCreditCard` varchar(16) NOT NULL,
  `ExpirationDate` date NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`creditcardhistoryID`),
  KEY `fk_creditcardhistory_idx` (`CreditCardID`),
  CONSTRAINT `fk_creditcardhistory` FOREIGN KEY (`CreditCardID`) REFERENCES `creditcard` (`CreditCardID`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email` (
  `EmailID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `Email` varchar(45) NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`EmailID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_Email_Account_idx` (`AccountID`),
  CONSTRAINT `fk_Email_Account` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailhistory`
--

DROP TABLE IF EXISTS `emailhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emailhistory` (
  `emailhistoryID` int NOT NULL AUTO_INCREMENT,
  `EmailID` int NOT NULL,
  `AccountID` int NOT NULL,
  `Email` varchar(45) NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`emailhistoryID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_email_idx` (`EmailID`),
  CONSTRAINT `fk_email` FOREIGN KEY (`EmailID`) REFERENCES `email` (`EmailID`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `linkedaccount`
--

DROP TABLE IF EXISTS `linkedaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkedaccount` (
  `LinkedAccountID` int NOT NULL AUTO_INCREMENT,
  `PrimaryAccountID` int NOT NULL,
  `SecondaryAccountID` int NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`LinkedAccountID`),
  KEY `FK_LinkedAccount_PrimaryAccount_idx` (`PrimaryAccountID`),
  KEY `FK_LinkedAccount_SecondaryAccount_idx` (`SecondaryAccountID`),
  CONSTRAINT `FK_LinkedAccount_PrimaryAccount` FOREIGN KEY (`PrimaryAccountID`) REFERENCES `account` (`AccountID`),
  CONSTRAINT `FK_LinkedAccount_SecondaryAccount` FOREIGN KEY (`SecondaryAccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `linkedaccounthistory`
--

DROP TABLE IF EXISTS `linkedaccounthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkedaccounthistory` (
  `linkedaccounthistoryID` int NOT NULL AUTO_INCREMENT,
  `LinkedAccountID` int NOT NULL,
  `PrimaryAccountID` int NOT NULL,
  `SecondaryAccountID` int NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`linkedaccounthistoryID`),
  KEY `fk_linkedaccounthistory_idx` (`LinkedAccountID`),
  CONSTRAINT `fk_linkedaccounthistory` FOREIGN KEY (`LinkedAccountID`) REFERENCES `linkedaccount` (`LinkedAccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `LoginID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `LoginName` varchar(128) NOT NULL,
  `Password` varchar(128) NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`LoginID`),
  UNIQUE KEY `LoginName_UNIQUE` (`LoginName`),
  KEY `fk_Login_Person_idx` (`PersonID`),
  CONSTRAINT `fk_Login_Person` FOREIGN KEY (`PersonID`) REFERENCES `person` (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loginhistory`
--

DROP TABLE IF EXISTS `loginhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loginhistory` (
  `loginhistoryID` int NOT NULL AUTO_INCREMENT,
  `LoginID` int NOT NULL,
  `PersonID` int NOT NULL,
  `LoginName` varchar(128) NOT NULL,
  `Password` varchar(128) NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`loginhistoryID`),
  KEY `fk_LoginHistory_idx` (`LoginID`),
  CONSTRAINT `fk_LoginHistory` FOREIGN KEY (`LoginID`) REFERENCES `login` (`LoginID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `PersonID` int NOT NULL AUTO_INCREMENT,
  `LastName` varchar(45) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `MiddleInitial` char(1) DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personhistory`
--

DROP TABLE IF EXISTS `personhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personhistory` (
  `PersonHistoryID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `MiddleInitial` char(1) DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`PersonHistoryID`),
  KEY `fk_Personhistory_idx` (`PersonID`),
  CONSTRAINT `fk_Personhistory` FOREIGN KEY (`PersonID`) REFERENCES `person` (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-23 13:07:12
