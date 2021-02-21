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
/*!50003 DROP PROCEDURE IF EXISTS `usp_DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_DeleteUser`(
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
/*!50003 DROP PROCEDURE IF EXISTS `usp_getAllUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_getAllUsers`(
	
)
BEGIN

	-- MySQL gotcha...need to use table name in where clause, or query will return all results.
	SELECT 
		Account.AccountID,        
        Person.LastName,
        Person.FirstName,
        Person.MiddleInitial,
        Email.Email,
        CreditCard.MaskedCreditCard,
        CreditCard.ExpirationDate,
        Account.LoyaltyPoints
    FROM Account
        INNER JOIN Person
            ON Person.PersonID = Account.PersonID
		LEFT OUTER JOIN Email
			ON Email.AccountID = Account.AccountID            
		LEFT OUTER JOIN CreditCard
			ON CreditCard.AccountID = Account.AccountID	           
		LEFT OUTER JOIN Login
			ON Login.PersonID = Account.PersonID;

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
/*!50003 DROP PROCEDURE IF EXISTS `usp_getUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_getUser`(
	IN AccountID int
)
BEGIN

	

	SET @AccountID := AccountID;    
    
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
        Account.LoyaltyPoints
    FROM Account
        INNER JOIN Person
            ON Person.PersonID = Account.PersonID
		LEFT OUTER JOIN Email
			ON Email.AccountID = Account.AccountID            
		LEFT OUTER JOIN CreditCard
			ON CreditCard.AccountID = Account.AccountID	           
		LEFT OUTER JOIN Login
			ON Login.PersonID = Account.PersonID			
	WHERE Account.AccountID = @AccountID;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_InsertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_InsertUser`(
	IN LoginName varchar(128),
    IN PassWord varchar(128),
    IN FirstName varchar(45),
    IN LastName varchar(45),
    IN MiddleInitial char(1),
    IN CCNumber varchar(16), -- Credit card numbers can begin with a zero
    IN CCExpirationDate date, -- ex..02/2023   
    IN Email varchar(45),    
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
    SET @LoginName := TRIM(LoginName);
    SET @PassWord := TRIM(PassWord);	
    SET @FirstName := TRIM(FirstName);
    SET @LastName := TRIM(LastName);
    SET @MiddleInitial := TRIM(MiddleInitial);
    SET @CCNumber = TRIM(CCNumber);
	-- SET @EncryptedCreditCard := @CCNumber; Do not stored ecrypted value	
	SET @MaskedCreditCard := CONCAT( REPEAT( '*', 12 ), RIGHT( @CCNumber, 4 ) );   -- Mask and store credit card number 
    SET @CCExpirationDate := CCExpirationDate;   
	SET @Email := TRIM(Email);
    
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
		VALUES ( @AccountID, Email, LoginName );
		
		INSERT INTO CMSC495.Login ( PersonID, LoginName, Password, CreatedBy )
		VALUES ( @PersonID, LoginName, Password, LoginName );
		
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
/*!50003 DROP PROCEDURE IF EXISTS `usp_UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_UpdateUser`(
	IN LoginName varchar(128),   
	IN AccountID int,
    IN FirstName varchar(45),
    IN LastName varchar(45),
    IN MiddleInitial char(1),
    IN CCNumber varchar(16), -- Credit card numbers can begin with a zero
    IN CCExpirationDate date, -- ex..02/2023   
    IN Email varchar(45)            
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
    SET @LoginName := TRIM(LoginName);  
    SET @FirstName := TRIM(FirstName);
    SET @LastName := TRIM(LastName);
    SET @MiddleInitial := TRIM(MiddleInitial);
    SET @CCNumber = TRIM(CCNumber);	
	SET @MaskedCreditCard := CONCAT( REPEAT( '*', 12 ), RIGHT( @CCNumber, 4 ) );   -- Mask and store credit card number 
    SET @CCExpirationDate := CCExpirationDate;   
	SET @Email := TRIM(Email);
    SET @AccountID := AccountID;
    
    
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
        
        IF @MaskedCreditCard <> @CurrentMaskedCreditCard OR @ExpirationDate <> @CurrentExpirationDate THEN
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
                ExpirationDate = @ExpirationDate,
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

-- Dump completed on 2021-02-20 19:03:31
