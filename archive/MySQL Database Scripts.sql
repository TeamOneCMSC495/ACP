use cmsc495;

CREATE TABLE `person` (
  `PersonID` int NOT NULL AUTO_INCREMENT,
  `LastName` varchar(45) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `MiddleInitial` char(1) DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `login` (
  `LoginID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `LoginName` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`LoginID`),
  UNIQUE KEY `LoginName_UNIQUE` (`LoginName`),
  KEY `fk_Login_Person_idx` (`PersonID`),
  CONSTRAINT `fk_Login_Person` FOREIGN KEY (`PersonID`) REFERENCES `person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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


CREATE TABLE `account` (
  `AccountID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `LoyaltyPoints` int NOT NULL DEFAULT '0',
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AccountID`),
  KEY `fk_Account_Person_idx` (`PersonID`),
  CONSTRAINT `fk_Account_Person` FOREIGN KEY (`PersonID`) REFERENCES `person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `creditcard` (
  `CreditCardID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `EncryptedCreditCard` varchar(16) NOT NULL,
  `MaskedCreditCard` varchar(16) NOT NULL,
  `ExpirationDate` date NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CreditCardID`),
  KEY `fk_CreditCard_Account_idx` (`AccountID`),
  CONSTRAINT `fk_CreditCard_Account` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `email` (
  `EmailID` int NOT NULL AUTO_INCREMENT,
  `AccountID` int NOT NULL,
  `Email` varchar(45) NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`EmailID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_Email_Account_idx` (`AccountID`),
  CONSTRAINT `fk_Email_Account` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `linkedaccount` (
  `LinkedAccountID` int NOT NULL AUTO_INCREMENT,
  `PrimaryAccountID` int NOT NULL,
  `SecondaryAccountID` int NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `CreatedBy` varchar(45) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedBy` varchar(45) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`LinkedAccountID`),
  KEY `FK_LinkedAccount_PrimaryAccount_idx` (`PrimaryAccountID`),
  KEY `FK_LinkedAccount_SecondaryAccount_idx` (`SecondaryAccountID`),
  CONSTRAINT `FK_LinkedAccount_PrimaryAccount` FOREIGN KEY (`PrimaryAccountID`) REFERENCES `account` (`AccountID`),
  CONSTRAINT `FK_LinkedAccount_SecondaryAccount` FOREIGN KEY (`SecondaryAccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_getAllUsers`(
	
)
BEGIN

	SELECT 
		Account.AccountID,
        Login.LoginName,        
        Person.LastName,
        Person.FirstName,
        Person.MiddleInitial,
        Email.Email,
        CreditCard.MaskedCreditCard,
        CreditCard.ExpirationDate
    FROM Account
        INNER JOIN Person
            ON Person.PersonID = Account.PersonID
		LEFT OUTER JOIN Email
			ON Email.AccountID = Account.AccountID
            AND Email.InactiveDate IS NULL
		LEFT OUTER JOIN CreditCard
			ON CreditCard.AccountID = Account.AccountID		
             AND CreditCard.InactiveDate IS NULL
		LEFT OUTER JOIN Login
			ON Login.PersonID = Account.PersonID
            AND Login.InactiveDate IS NULL			
	WHERE Account.InactiveDate IS NULL;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_InsertUser`(
	IN LoginName varchar(45),
    IN PassWord varchar(45),
    IN FirstName varchar(45),
    IN LastName varchar(45),
    IN MiddleInitial char(1),
    IN CCNumber varchar(16),
    IN CCExpirationDate varchar(10), -- ex..02/2023
    IN Email varchar(45),
    OUT PersonID int,
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
     
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
		 @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
		SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @full_error;            
        
         ROLLBACK;  -- rollback any error in the transaction
         
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
         
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error has occurred.';
     END;    
     

    
    START TRANSACTION;    

		INSERT INTO CMSC495.person ( FirstName, LastName, MiddleInitial, CreatedBy )
		VALUES ( FirstName, LastName, MiddleInitial, LoginName );

		-- Get identidy value
		SET @PersonID :=  LAST_INSERT_ID();
		
		INSERT INTO CMSC495.account ( PersonID, LoyaltyPoints, CreatedBy)
		VALUES ( @PersonID, 0, LoginName );
		
		SET @AccountID := LAST_INSERT_ID();
		
		-- need to encrypt
		SET @EncryptedCreditCard := CCNumber; 
		-- need to mask
		SET @MaskedCreditCard := CCNumber; 
		
		INSERT INTO CMSC495.creditcard ( AccountID, EncryptedCreditCard, MaskedCreditCard, ExpirationDate, CreatedBy )
		VALUES ( @AccountID, @EncryptedCreditCard, @MaskedCreditCard, CCExpirationDate, LoginName );
		
		INSERT INTO CMSC495.Email ( AccountID, Email, CreatedBy )
		VALUES ( @AccountID, Email, LoginName );
		
		INSERT INTO CMSC495.Login ( PersonID, LoginName, Password, CreatedBy )
		VALUES ( @PersonID, LoginName, Password, LoginName );
		
		--     select * from person;
		--     select * from account;
		--     select * from creditcard;
		--     select * from login;
		--     select * from email;
        
			SET AccountID := @AccountID;
            SET PersonID := @PersonID;
		
       COMMIT;
    

END$$
DELIMITER ;






DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_DeleteUser`(
	IN LoginName varchar(45),
    IN AccountID int        
)
BEGIN
    
	 DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
     
		GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
		 @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
		SET @full_error = CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text);
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @full_error;            
        
         ROLLBACK;  -- rollback any error in the transaction             
         
     END;    
	
    -- Get current date/time
	SET @DateTimeNow := current_timestamp();
   
	-- Change to variable to avoid confusion.
	SET @AccountID := AccountID;
    -- Get the PersonID associated to the account
    SET @PersonID := ( SELECT PersonID FROM Account WHERE Account.AccountID = @AccountID );	
    
    START TRANSACTION;  
    
    	-- debug
		-- SET @LoginName := 'tes';    
		-- SET @AccountID := '25';    
		
		UPDATE Login
		SET InactiveDate = @DateTimeNow,
			ModifiedBy = @LoginName,
			ModifiedDate = @DateTimeNow
		WHERE Login.PersonID = @PersonID;

		UPDATE Account
		SET InactiveDate = @DateTimeNow,
			ModifiedBy = @LoginName,
			ModifiedDate = @DateTimeNow
		WHERE Account.AccountID = @AccountID;    
    
    COMMIT;

END$$
DELIMITER ;


