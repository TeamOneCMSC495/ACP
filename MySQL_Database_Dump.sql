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
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `AddressID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `AddressLine1` varchar(45) NOT NULL,
  `AddressLine2` varchar(45) DEFAULT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  `ZipCode` varchar(45) NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecordEndDateTime` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  PRIMARY KEY (`AddressID`),
  KEY `fk_Address_Account_idx` (`AccountID`),
  CONSTRAINT `fk_Address_Account` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `addresshistory`
--

DROP TABLE IF EXISTS `addresshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresshistory` (
  `AddressHistoryID` int NOT NULL AUTO_INCREMENT,
  `AddressID` int NOT NULL,
  `AccountID` int NOT NULL,
  `AddressLine1` varchar(45) NOT NULL,
  `AddressLine2` varchar(45) DEFAULT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) NOT NULL,
  `ZipCode` varchar(45) NOT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` varchar(45) NOT NULL,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` varchar(45) DEFAULT NULL,
  `RecordStartDateTime` datetime NOT NULL,
  `RecordEndDateTime` datetime NOT NULL,
  PRIMARY KEY (`AddressHistoryID`),
  KEY `fk_AddressHistory_Address_idx` (`AddressID`),
  CONSTRAINT `fk_AddressHistory_Address` FOREIGN KEY (`AddressID`) REFERENCES `address` (`AddressID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'cmsc495'
--
/*!50003 DROP PROCEDURE IF EXISTS `usp_AddLoyaltyPoints` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_AddLoyaltyPoints`(
	IN LoginName varchar(128), 
    IN AccountID int,
    IN Points int
)
BEGIN

	 DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
     
		ROLLBACK;
        RESIGNAL; -- rollback any error in the transaction  
	
     END; 
     
	SET @LoginName := TRIM(LoginName);  	
    SET @AccountID := AccountID;
    SET @Points := Points;
    
    SET @DateTimeNow := Current_TimeStamp();
    SET @CurrentPoints := ( SELECT Account.LoyaltyPoints FROM CMSC495.Account WHERE Account.AccountID = @AccountID ); 
      
	START TRANSACTION;      
    
		IF @Points > 0 THEN
        BEGIN 
    
			INSERT INTO CMSC495.AccountHistory ( AccountID, PersonID, LoyaltyPoints, InactiveDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime )
			SELECT 
				Account.AccountID, 
                Account.PersonID, 
                Account.LoyaltyPoints, 
                Account.InactiveDate, 
                Account.CreatedBy, 
                Account.CreatedDate, 
                Account.ModifiedBy, 
                Account.ModifiedDate, 
                Account.RecordStartDateTime,
                @DateTimeNow
            FROM CMSC495.Account
            WHERE Account.AccountID = @AccountID;
        
			UPDATE CMSC495.Account
			SET LoyaltyPoints = @Points + Account.LoyaltyPoints,
				ModifiedBy = @LoginName,
				ModifiedDate = @DateTimeNow,
				RecordStartDateTime = @DateTimeNow
			WHERE Account.AccountID = @AccountID;
            
		END;
        END IF;
    
	COMMIT;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_DeleteAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_DeleteAccount`(
	IN LoginName varchar(45),
    IN AccountID int        
)
BEGIN
    
	 DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
     
		ROLLBACK;
        RESIGNAL;     
     
		-- GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
		 -- @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
		-- SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
		-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @full_error;             
         
     END;    
	
    -- Get current date/time
	SET @DateTimeNow := current_timestamp();
   
	-- Change to variable to avoid confusion.
	SET @AccountID := AccountID;
    SET @LoginName := LoginName;   
    
    START TRANSACTION;  
    
    	-- debug
		-- SET @LoginName := 'tes';    
		-- SET @AccountID := '25';    
        
        INSERT INTO CMSC495.LoginHistory ( LoginID, PersonID, LoginName, Password, InactiveDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime )
		SELECT 
			Login.LoginID,
            Login.PersonID,
            Login.LoginName,
            Login.Password,
            Login.InactiveDate,
            Login.CreatedBy,
            Login.CreatedDate,
            Login.ModifiedBy,
            Login.ModifiedDate,
			Login.RecordStartDateTime,
			@DateTimeNow             
        FROM CMSC495.Login;
		
		UPDATE CMSC495.Login
		SET InactiveDate = @DateTimeNow,
			ModifiedBy = @LoginName,
			ModifiedDate = @DateTimeNow,
            RecordStartDateTime = @DateTimeNow
		WHERE Login.PersonID = @PersonID;
        
        INSERT INTO CMSC495.AccountHistory ( AccountID, PersonID, LoyaltyPoints, InactiveDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime )
		SELECT 			
            Account.AccountID, 
            Account.PersonID, 
            Account.LoyaltyPoints, 
            Account.InactiveDate, 
            Account.CreatedBy, 
            Account.CreatedDate, 
            Account.ModifiedBy, 
            Account.ModifiedDate,
			Account.RecordStartDateTime,
			@DateTimeNow               
        FROM CMSC495.Account
        WHERE Account.AccountID = @AccountID;

		UPDATE CMSC495.Account
		SET InactiveDate = @DateTimeNow,
			ModifiedBy = @LoginName,
			ModifiedDate = @DateTimeNow,
            RecordStartDateTime = @DateTimeNow
		WHERE Account.AccountID = @AccountID;    
    
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetAccount`(
	IN AccountID int
)
BEGIN

	
	-- SET @LoginName := TRIM( LoginName );    
	SET @AccountID := AccountID; -- ( SELECT AccountID FROM Account WHERE Account.PersonID = @PersonID );    
	-- SET @PersonID := ( SELECT PersonID FROM Account WHERE Account.PersonID = @LoginName );    
    
    -- debug
    -- SELECT @AccountID;

	-- MySQL gotcha...need to use table name in where clause, or query will return all results.
	SELECT 
		Account.AccountID,        
        Person.LastName,
        Person.FirstName,
        Person.MiddleInitial,
        Email.Email,
        CreditCard.MaskedCreditCard,
        CreditCard.ExpirationDate,
        Login.LoginName,
        Login.Password,
        Account.LoyaltyPoints,
        Address.AddressLine1,
        Address.AddressLine2,
        Address.City,
        Address.State,
        Address.ZipCode
    FROM Account
        INNER JOIN Person
            ON Person.PersonID = Account.PersonID
		LEFT OUTER JOIN Email
			ON Email.AccountID = Account.AccountID            
		LEFT OUTER JOIN CreditCard
			ON CreditCard.AccountID = Account.AccountID	           
		LEFT OUTER JOIN Login
			ON Login.PersonID = Account.PersonID
		LEFT OUTER JOIN Address
            ON Address.AccountID = Account.AccountID
	WHERE Account.AccountID = @AccountID;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetAccountHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetAccountHistory`(
	IN AccountID int
)
BEGIN

	SET @AccountID := AccountID;

	select * from (    
	select * from account    
	union
	select AccountID, PersonID, LoyaltyPoints, InactiveDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime
	from accounthistory ) tmp
	WHERE tmp.AccountID = @AccountID
	order by
		recordstartdatetime desc ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetAllAccounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetAllAccounts`(
	OUT rowCount int 
)
BEGIN

	SET rowCount := ( SELECT COUNT(*) FROM Account );

	-- MySQL gotcha...need to use table name in where clause, or query will return all results.
	SELECT 
		Account.AccountID,        
        Person.LastName,
        Person.FirstName,
        Person.MiddleInitial,
        Email.Email,
        CreditCard.MaskedCreditCard,
        CreditCard.ExpirationDate,
        Login.LoginName,
        Login.Password,
        Account.LoyaltyPoints,
        Address.AddressLine1,
        Address.AddressLine2,
        Address.City,
        Address.State,
        Address.ZipCode        
    FROM Account
        INNER JOIN Person
            ON Person.PersonID = Account.PersonID
		LEFT OUTER JOIN Email
			ON Email.AccountID = Account.AccountID            
		LEFT OUTER JOIN CreditCard
			ON CreditCard.AccountID = Account.AccountID	           
		LEFT OUTER JOIN Login
			ON Login.PersonID = Account.PersonID
		LEFT OUTER JOIN Address
            ON Address.AccountID = Account.AccountID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetCreditCardHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetCreditCardHistory`(
	IN AccountID int
)
BEGIN

	SET @AccountID := AccountID;

	select *
	from (    
	select * from creditcard
	union
	select CreditCardID, AccountId, MaskedCreditCard, ExpirationDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime
	from creditcardhistory ) tmp
	WHERE tmp.AccountID = @AccountID
	order by
		recordstartdatetime desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetEmailHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetEmailHistory`(
	IN AccountID int
)
BEGIN

	SET @AccountID := AccountID;

	select * from (    
	select * from email
	union
	select EmailID, AccountID, Email, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime 
	from emailhistory ) tmp
	WHERE tmp.AccountID = @AccountID
	order by
		recordstartdatetime desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetLinkedAccountHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetLinkedAccountHistory`(
	IN AccountID int
)
BEGIN

	SET @AccountID := AccountID;

	select *
	from (    
	select * from linkedaccount
	union 
	select LinkedAccountID, PrimaryAccountID, SecondaryAccountID, InactiveDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime
	from linkedaccounthistory ) tmp
	WHERE tmp.PrimaryAccountID = @AccountID
	order by
		recordstartdatetime desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetLogin`(
	IN LoginName varchar(128)
)
BEGIN

	SET @LoginName := TRIM( LoginName );
    
    SELECT 
		Login.LoginName,
        Login.Password,
        Login.InactiveDate
    FROM CMSC495.Login
    WHERE Login.LoginName = @LoginName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetPersonHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetPersonHistory`(	
	IN AccountID int
)
BEGIN

	SET @AccountID := AccountID;
	SET @PersonID := ( SELECT PersonID FROM Account WHERE Account.AccountID = @AccountID );


	select @AccountID AccountID, tmp.* from (
	select * from person 
	union 
	select PersonID, LastName, FirstName, MiddleInitial, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime
	from personhistory ) tmp
	where tmp.personID = @PersonID
	order by
		recordstartdatetime desc;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_GetUserNameHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_GetUserNameHistory`(
	IN AccountID int
)
BEGIN

	SET @AccountID := AccountID;
	SET @PersonID := ( SELECT PersonID FROM Account WHERE Account.AccountID = @AccountID );	

	select *
	from (    
	select * from login
	union
	select LoginID, PersonID, LoginName, Password, InactiveDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime
	from loginhistory ) tmp
	WHERE tmp.PersonID = @PersonID
	order by
		recordstartdatetime desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_InsertAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_InsertAccount`(
	IN LoginName varchar(128),
    IN PassWord varchar(128),
    IN FirstName varchar(45),
    IN LastName varchar(45),
    IN MiddleInitial char(1),
    IN CCNumber varchar(16), -- Credit card numbers can begin with a zero
    IN CCExpirationDate date, -- ex..02/2023   
    IN Email varchar(45), 
    IN AddressLine1 varchar(45),
    IN AddressLine2 varchar(45),
    IN City varchar(45),
    IN State varchar(45),
    IN ZipCode varchar(45),    
    OUT AccountID int        
)
BEGIN

	-- debug
	-- SET @LoginName := 'tes';    
	-- SET @Password := '12345';
	-- SET @FirstName := 'Holmes';
	-- SET @LastName := 'Larry';
	-- SET @MiddleInitial := 'D';
	-- SET @CreditCardNumber := '1111222233334444';
	-- SET @CreditCardExpirationDate := '20230101';    
	-- SET @Email := 'dd22@yahoo.com';
    

    
	 DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
     
		ROLLBACK;
        RESIGNAL;
     
		-- GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
		 -- @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
		-- SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
		--  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @full_error;            
        
          -- rollback any error in the transaction
         
		  -- SET @login := LoginName;
		  -- SET @LoginID := ( SELECT MAX(LoginID) FROM CMSC495.Login WHERE LoginName = @login AND InactiveDate IS NULL );
		 
		  -- IF (@LoginID > 0) THEN 
		  -- BEGIN
			 -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User name already exists.';
		 -- END;
		 -- END IF;    
         
		 -- SET @email := Email;
		 -- SET @EmailID := ( SELECT MAX(EmailID) FROM CMSC495.Email WHERE Email = @email AND InactiveDate IS NULL );
		 
		 -- IF (@EmailID > 0) THEN 
		 -- BEGIN
			-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email address already exists.';
		 -- END;
		 -- END IF;           
         
         -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error has occurred.';
     END;    
     
    -- Convert parameters to variables to avoid confusion
    SET @LoginName := NULLIF( TRIM( LoginName ), '' );
    SET @PassWord := NULLIF( TRIM( PassWord ), '' );	
    SET @FirstName := NULLIF( TRIM( FirstName ), '' );
    SET @LastName := NULLIF( TRIM( LastName ), '' );
    SET @MiddleInitial := NULLIF( TRIM(MiddleInitial ), '' );
    SET @CCNumber = NULLIF( TRIM( CCNumber ), '' );
	-- SET @EncryptedCreditCard := @CCNumber; Do not stored ecrypted value	
	SET @MaskedCreditCard := NULLIF( CONCAT( REPEAT( '*', 12 ), RIGHT( @CCNumber, 4 ) ), '' );   -- Mask and store credit card number 
    SET @CCExpirationDate := CCExpirationDate;   
	SET @Email := NULLIF( TRIM( Email ), '' );
    
    SET @AddressLine1 = NULLIF( TRIM( AddressLine1 ), '' );
    SET @AddressLine2 = NULLIF( TRIM( AddressLine2 ), '' );
    SET @City = NULLIF( TRIM( City ), '' );
    SET @State = NULLIF( TRIM( State ), '' );
    SET @ZipCode = NULLIF( TRIM( ZipCode ), '' );
    
    START TRANSACTION;    

		INSERT INTO CMSC495.person ( FirstName, LastName, MiddleInitial, CreatedBy )
		VALUES ( @FirstName, @LastName, @MiddleInitial, @LoginName );

		-- Get identidy value
		SET @PersonID :=  LAST_INSERT_ID();
		
		INSERT INTO CMSC495.account ( PersonID, LoyaltyPoints, CreatedBy)
		VALUES ( @PersonID, 0, @LoginName );
		
		SET @AccountID := LAST_INSERT_ID();
		
		INSERT INTO CMSC495.creditcard ( AccountID, MaskedCreditCard, ExpirationDate, CreatedBy )
		VALUES ( @AccountID, @MaskedCreditCard, @CCExpirationDate, @LoginName );
		
		INSERT INTO CMSC495.Email ( AccountID, Email, CreatedBy )
		VALUES ( @AccountID, Email, @LoginName );
		
		INSERT INTO CMSC495.Login ( PersonID, LoginName, Password, CreatedBy )
		VALUES ( @PersonID, LoginName, Password, @LoginName );
        
        INSERT INTO CMSC495.Address ( AccountID, AddressLine1, AddressLine2, City, State, ZipCode, CreatedBy )
        VALUES ( @AccountID, @AddressLine1, @AddressLine2, @City, @State, @ZipCode, @LoginName );
		
		--     select * from person;
		--     select * from account;
		--     select * from creditcard;
		--     select * from login;
		--     select * from email;
        
		SET AccountID := @AccountID;				
	
	COMMIT;    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_UpdateAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_UpdateAccount`(
	IN LoginName varchar(128),   
	IN AccountID int,
    IN FirstName varchar(45),
    IN LastName varchar(45),
    IN MiddleInitial char(1),  
    IN CCNumber varchar(16), -- Credit card numbers can begin with a zero
    IN CCExpirationDate date, -- ex..02/2023   
    IN Email varchar(45),
    IN AddressLine1 varchar(45),
    IN AddressLine2 varchar(45),
    IN City varchar(45),
    IN State varchar(45),
    IN ZipCode varchar(45)  
)
BEGIN

	-- debug
	-- SET @LoginName := 'tes';    
	-- SET @Password := '12345';
	-- SET @FirstName := 'Holmes';
	-- SET @LastName := 'Larry';
	-- SET @MiddleInitial := 'D';
	-- SET @CreditCardNumber := '1111222233334444';
	-- SET @CreditCardExpirationDate := '20230101';    
	-- SET @Email := 'dd22@yahoo.com';
    
	 DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
     
		ROLLBACK;
        RESIGNAL; -- rollback any error in the transaction
     
		-- GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
		-- @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
		-- SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
		-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @full_error;            
        

         
		  -- SET @login := LoginName;
		  -- SET @LoginID := ( SELECT MAX(LoginID) FROM CMSC495.Login WHERE LoginName = @login AND InactiveDate IS NULL );
		 
		  -- IF (@LoginID > 0) THEN 
		  -- BEGIN
			 -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User name already exists.';
		 -- END;
		 -- END IF;    
         
		 -- SET @email := Email;
		 -- SET @EmailID := ( SELECT MAX(EmailID) FROM CMSC495.Email WHERE Email = @email AND InactiveDate IS NULL );
		 
		 -- IF (@EmailID > 0) THEN 
		 -- BEGIN
			-- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email address already exists.';
		 -- END;
		 -- END IF;           
         
         -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error has occurred.';
     END;    
     
    -- Convert parameters to variables to avoid confusion and remove white space from strings
    SET @LoginName := NULLIF( TRIM(LoginName), '' );  
    SET @FirstName := NULLIF( TRIM(FirstName), '' );
    SET @LastName := NULLIF( TRIM(LastName), '' );
    SET @MiddleInitial := NULLIF( TRIM(MiddleInitial), '' );
    SET @CCNumber = NULLIF( TRIM(CCNumber), '' );	
	SET @MaskedCreditCard := CONCAT( REPEAT( '*', 12 ), RIGHT( @CCNumber, 4 ) );   -- Mask and store credit card number 
    SET @CCExpirationDate := CCExpirationDate;   
	SET @Email := NULLIF( TRIM(Email), '' );
    SET @AccountID := AccountID;
    
    SET @AddressLine1 = NULLIF( TRIM(AddressLine1 ), '' );
    SET @AddressLine2 = NULLIF( TRIM(AddressLine2 ), '' );
    SET @City = NULLIF( TRIM( City ), '' );
    SET @State = NULLIF( TRIM( State ), '' );
    SET @ZipCode = NULLIF( TRIM( ZipCode ), '' );    
    
    
    SET @DateTimeNow = Current_TimeStamp();
    
    -- Get current values
	SET @PersonID = ( SELECT PersonID FROM CMSC495.Account WHERE Account.AccountID = @AccountID );
    
    SET @CurrentFirstName = ''; 
    SET @CurrentLastName = ''; 
    SET @CurrentMiddleInitial = '';
					
	SELECT Person.FirstName, Person.LastName, Person.MiddleInitial
	INTO @CurrentFirstName , @CurrentLastName , @CurrentMiddleInitial 
    FROM CMSC495.Person
	WHERE Person.PersonID = @PersonID;	
			
	SELECT CreditCard.MaskedCreditCard, CreditCard.ExpirationDate
	INTO @CurrentMaskedCreditCard , @CurrentExpirationDate FROM
		CMSC495.CreditCard
	WHERE CreditCard.AccountID = @AccountID;
			
	SELECT Email.Email
	INTO @CurrentEmail 
    FROM CMSC495.Email
	WHERE Email.AccountID = @AccountID;
    
    SELECT Address.AddressLine1, Address.AddressLine2, Address.City, Address.State, Address.ZipCode
    INTO @CurrentAddressLine1, @CurrentAddressLine2, @CurrentCity, @CurrentState, @CurrentZipCode
    FROM CMSC495.Address
    WHERE Address.AccountID = @AccountID;
	 
    
    START TRANSACTION;    	 
        
        IF @FirstName <> @CurrentFirstName OR @LastName <> @CurrentLastName OR IFNULL( @MiddleInitial, '' ) <> IFNULL( @CurrentMiddleInitial, '' ) THEN
        BEGIN
        
			INSERT INTO CMSC495.PersonHistory ( PersonID, LastName, FirstName, MiddleInitial, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime )
            SELECT 
				Person.PersonID, 
                Person.LastName, 
                Person.FirstName, 
                Person.MiddleInitial, 
                Person.CreatedBy, 
                Person.CreatedDate, 
                Person.ModifiedBy, 
                Person.ModifiedDate,
                Person.RecordStartDateTime,
                @DateTimeNow
            FROM CMSC495.Person
            WHERE Person.PersonID = @PersonID;
        
			UPDATE CMSC495.Person
            SET FirstName = @FirstName,
				LastName = @LastName,
                MiddleInitial = @MiddleInitial,
                ModifiedBy = @LoginName,
                ModifiedDate = @DateTimeNow,
                RecordStartDateTime = @DateTimeNow
            WHERE Person.PersonID = @PersonID;
        
        END;
        END IF;
        
        IF @MaskedCreditCard <> @CurrentMaskedCreditCard OR @CCExpirationDate <> @CurrentExpirationDate THEN
        BEGIN
        
			INSERT INTO CMSC495.CreditCardHistory ( CreditCardID, AccountID, MaskedCreditCard, ExpirationDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime )
            SELECT 
				CreditCard.CreditCardID, 
                CreditCard.AccountID, 
                CreditCard.MaskedCreditCard, 
                CreditCard.ExpirationDate, 
                CreditCard.CreatedBy, 
                CreditCard.CreatedDate, 
                CreditCard.ModifiedBy, 
                CreditCard.ModifiedDate,
                CreditCard.RecordStartDateTime,
                @DateTimeNow             
            FROM CMSC495.CreditCard
            WHERE CreditCard.AccountID = @AccountID;
        
			UPDATE CMSC495.CreditCard
            SET MaskedCreditCard = @MaskedCreditCard,
                ExpirationDate = @CCExpirationDate,
                ModifiedBy = @LoginName,
                ModifiedDate = @DateTimeNow,
                RecordStartDateTime = @DateTimeNow
			WHERE CreditCard.AccountID = @AccountID;
		
        
        END;
        END IF;
        
        -- debug
        -- SELECT  @Email, @CurrentEmail;
        
        IF @Email <> @CurrentEmail THEN
        BEGIN
        
			INSERT INTO CMSC495.EmailHistory ( EmailID, AccountID, Email, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, RecordStartDateTime, RecordEndDateTime )
            SELECT 
				Email.EmailID, 
                Email.AccountID, 
                Email.Email, 
                Email.CreatedBy, 
                Email.CreatedDate, 
                Email.ModifiedBy, 
                Email.ModifiedDate,
                Email.RecordStartDateTime,
                @DateTimeNow                   
            FROM CMSC495.Email
			WHERE Email.AccountID = @AccountID;
        
			UPDATE CMSC495.Email
            SET Email = @Email,
                ModifiedBy = @LoginName,
                ModifiedDate = @DateTimeNow,
				RecordStartDateTime = @DateTimeNow
            WHERE Email.AccountID = @AccountID;
        
        END;
        END IF;
        
        IF @AddressLine1 <> @CurrentAddressLine1 OR IFNULL( @AddressLine2, '' ) <> IFNULL( @CurrentAddressLine2, '' ) OR @City <> @CurrentCity OR @State <> @CurrentState OR @ZipCode <> @CurrentZipCode THEN 
        BEGIN
         
			INSERT INTO CMSC495.AddressHistory ( AddressID, AccountID, AddressLine1, AddressLine2, City, State, ZipCode, CreatedBy, CreatedDate, Modifiedby, ModifiedDate, RecordstartDateTime, RecordEndDateTime )
            SELECT 
				Address.AddressID, 
                Address.AccountID, 
                Address.AddressLine1, 
                Address.AddressLine2, 
                Address.City, 
                Address.State, 
                Address.ZipCode, 
                Address.CreatedBy, 
                Address.CreatedDate, 
                Address.Modifiedby, 
                Address.ModifiedDate, 
                Address.RecordstartDateTime,
                @DateTimeNow                   
            FROM CMSC495.Address
			WHERE Address.AccountID = @AccountID;
        
			UPDATE CMSC495.Address
            SET AddressLine1 = @AddressLine1,
				AddressLine2 = @AddressLine2,
				City = @City, 
				State = @State, 
				ZipCode = @ZipCode, 
                ModifiedBy = @LoginName,
                ModifiedDate = @DateTimeNow,
				RecordStartDateTime = @DateTimeNow
            WHERE Address.AccountID = @AccountID;
         
        END;
        END IF;         
		
	COMMIT;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-28 22:04:37
