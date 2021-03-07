package com.acp;

import javax.swing.JOptionPane;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Calendar;
import java.util.Date;
import com.codahale.passpol.Status;
import java.text.SimpleDateFormat;

/**
 * Purpose: Hold the main method and manage the operations of the subordinate
 * classes UMGC CMSC 495 Special Topics Developer: Team 1 Date: February 21,
 * 2021
 */
public class Base_Class {

    /**
     * Instance and Field variables
     */
    public Boolean returningUser = false;
//    public String userName;
    public int loginCount = 0;
    public int loyaltyPoints = 0;
    public String localDateString;
    public String localTimeString;
    public Boolean rejectForm = false;
//    public int creditCardNumber = 0;
//    public String ccDate;
//    public int cvvCode = 999;
//    public String password;
    public Boolean validForm = false;
    public Account_Class account;

    /**
     * Constructors
     */
    public Base_Class() {
    }

    /* I will keep adding to this constructor as we figure out what we need to
    send between classes
     */
    public Base_Class(int loyaltyPoints) {
        loyaltyPoints = this.loyaltyPoints;
    }

    /**
     * Getters
     */
    /**
     * Setters
     */
    /**
     * Methods
     */
    public void existingUserCheck(String loginName) throws Exception {

        Database_Class db = new Database_Class();
        Connection conn = db.getConnection();
        PreparedStatement sql = null;
        ResultSet resultSet = null;

        //remove leading and trailing space
        loginName = loginName.trim();

        returningUser = false;

        try {

            sql = conn.prepareStatement("SELECT LoginID FROM CMSC495.Login WHERE LoginName = ?");
            sql.setString(1, loginName);
            resultSet = sql.executeQuery();

            while (resultSet.next()) {

                returningUser = true;

            }

        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } finally {

            if (conn != null) {
                conn.close();
            }

            if (sql != null) {
                sql.close();
            }

            if (resultSet != null) {
                resultSet.close();
            }

        }

        //debug
        //System.out.println(returningUser);
    }
    
    public Account_Class getHashedPassword(String loginName) throws Exception {

        Database_Class db = new Database_Class();
        Connection conn = db.getConnection();
        PreparedStatement sql = null;
        ResultSet resultSet = null;
        Account_Class account = new Account_Class();
        
        String hashedPassword = "";

        //remove leading and trailing space
        loginName = loginName.trim();        

        try {

            sql = conn.prepareStatement("SELECT Account.AccountID, Login.Password, Login.Confirmed, Login.ConfirmationCode FROM CMSC495.Login inner join CMSC495.Account on Account.PersonID = Login.PersonID WHERE LoginName = ?");
            sql.setString(1, loginName);
            resultSet = sql.executeQuery();

            
            
            while (resultSet.next()) {
                
                //System.out.println(resultSet.getInt(1));

                //hashedPassword = resultSet.getString(1);
                account.setAccountID(resultSet.getInt(1));
                account.setPassword(resultSet.getString(2));
                //account.setAccountConfirmed(resultSet.getInt(3)); //MySQL does not have a true boolean data type      
                
                if (resultSet.getInt(3) == 0){
                    account.setAccountConfirmed(false);
                } else {
                    account.setAccountConfirmed(true);                            
                }
                
                account.setConfirmationCode(resultSet.getString(4)); 
                        
            }

        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } finally {

            if (conn != null) {
                conn.close();
            }

            if (sql != null) {
                sql.close();
            }

            if (resultSet != null) {
                resultSet.close();
            }

        }
        
        return account;

        //debug
        //System.out.println(returningUser);
    }    

    public void validateWelcomeMessage() {
        if (returningUser == true) {
            JOptionPane.showMessageDialog(null, "Welcome back " + account.getUserName());
        }
    }

    public void calculateLoyaltyPoints() {
        if (returningUser == true) {
//            query the database for the number of logins
//                    loginCount == the number of logins
//                            loyaltyPoints = loginCount + 10;
        }
    }

    public void dateAndTime() {
        LocalDate localDate = LocalDate.now();
        localDateString = localDate.toString();
        LocalTime localTime = LocalTime.now();
        localTimeString = localTime.toString();
    }

   // public void storeFormDataInSQLDatabase(String loginName, String passWord, String firstName, String lastName, String middleInitial, String ccNumber, Date ccExpirationDate, String email) throws Exception {
    public int storeFormDataInSQLDatabase(Account_Class account) throws Exception {    
        //if (validForm == true) {
            // send userName to the database;
            // send loginCount  to the database;
            // send loyaltyPoints to the database;
            // send localDateString to the database?;
            // send localTimeString to the database?;
            // send creditCardNumber to the database;
            // send ccDate to the database;
            // send cvvCode to the database;
            // send password to the database;

            Database_Class db = new Database_Class();
            Connection conn = db.getConnection();
            CallableStatement procedureCall = null;
            
            //Used for debugging
            PreparedStatement sql = null;
            ResultSet resultSet = null;

            try {

                //java.sql.Date sql_CCExpirationDate = sql_CCExpirationDate.valueOf(account.getCcDate());  //new java.sql.Date(account.getCcDate()); //Need to convert Credit Card expiration date to an SQL acceptable date
                String expirationDate = account.getCcDate();
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = sdf1.parse(expirationDate);
                java.sql.Date sql_ExpirationDate = new java.sql.Date(date.getTime());                 

                procedureCall = conn.prepareCall("{ CALL CMSC495.usp_InsertAccount(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
                procedureCall.setString(1, account.getUserName());
                procedureCall.setString(2, account.getPassword());
                procedureCall.setString(3, account.getFirstName());
                procedureCall.setString(4, account.getLastName());
                procedureCall.setString(5, account.getMiddleInitial());
                procedureCall.setString(6, String.valueOf(account.getCreditCardNumber()));
                procedureCall.setDate(7, sql_ExpirationDate);
                procedureCall.setString(8, account.getUserEmail());          
                procedureCall.setString(9, account.getAddressLine1()); 
                procedureCall.setString(10, account.getAddressLine2()); 
                procedureCall.setString(11, account.getCity()); 
                procedureCall.setString(12, account.getState()); 
                procedureCall.setString(13, account.getZipCode());                 
                procedureCall.setString(14, account.getConfirmationCode());
                procedureCall.registerOutParameter(15, Types.INTEGER); //AccountID
                procedureCall.executeQuery();

                // Get the identity value of the new account			
                int accountID = procedureCall.getInt(15);
                
                //existingUserCheck(account.getUserName());
                
                //debug
                System.out.println("AccountID: " + accountID);
                System.out.println("Record Created? " + returningUser);
                return accountID;
                
//                sql = conn.prepareStatement("select PersonID from account WHERE AccountID = ?");
//                sql.setString(1, accountID);                
//                resultSet = sql.executeQuery();
//
//                while (resultSet.next()) {
//
//                    //returningUser = true;
//                    System.out.println("UserName: " + );
//
//                }                

            } catch (SQLException e) {
                throw e;
            } catch (Exception e) {
                throw e;
            } finally {

                if (conn != null) {
                    conn.close();
                }

                if (procedureCall != null) {
                    procedureCall.close();
                }
                
            }
        //}
        
    }
    



    public void updateFormDataInSQLDatabase(Account_Class account) throws Exception {    
        //if (validForm == true) {
            // send userName to the database;
            // send loginCount  to the database;
            // send loyaltyPoints to the database;
            // send localDateString to the database?;
            // send localTimeString to the database?;
            // send creditCardNumber to the database;
            // send ccDate to the database;
            // send cvvCode to the database;
            // send password to the database;

            Database_Class db = new Database_Class();
            Connection conn = db.getConnection();
            CallableStatement procedureCall = null;
            
            //Used for debugging
            PreparedStatement sql = null;
            ResultSet resultSet = null;

            try {

                //java.sql.Date sql_CCExpirationDate = sql_CCExpirationDate.valueOf(account.getCcDate());  //new java.sql.Date(account.getCcDate()); //Need to convert Credit Card expiration date to an SQL acceptable date
                String expirationDate = account.getCcDate();
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date date = sdf1.parse(expirationDate);
                java.sql.Date sql_ExpirationDate = new java.sql.Date(date.getTime());                 

                procedureCall = conn.prepareCall("{ CALL CMSC495.usp_UpdateAccount(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
                procedureCall.setString(1, account.getUserName()); 
                procedureCall.setInt(2, account.getAccountID()); //hardcoding for now
                procedureCall.setString(3, account.getFirstName());
                procedureCall.setString(4, account.getLastName());
                procedureCall.setString(5, account.getMiddleInitial());
                procedureCall.setString(6, account.getCreditCardNumber());
                procedureCall.setDate(7, sql_ExpirationDate);
                procedureCall.setString(8, account.getUserEmail());              
                
                procedureCall.setString(9, account.getAddressLine1()); 
                procedureCall.setString(10, account.getAddressLine2()); 
                procedureCall.setString(11, account.getCity()); 
                procedureCall.setString(12, account.getState()); 
                procedureCall.setString(13, account.getZipCode()); 
               //procedureCall.registerOutParameter(9, Types.INTEGER); //AccountID
                procedureCall.executeQuery();

                // Get the identity value of the new account			
                //int accountID = procedureCall.getInt(9);
                
                //existingUserCheck(account.getUserName());
                
                //debug
                System.out.println("AccountID: " + account.getAccountID());
                System.out.println("Record updated? " + returningUser);
                
//                sql = conn.prepareStatement("select PersonID from account WHERE AccountID = ?");
//                sql.setString(1, accountID);                
//                resultSet = sql.executeQuery();
//
//                while (resultSet.next()) {
//
//                    //returningUser = true;
//                    System.out.println("UserName: " + );
//
//                }                

            } catch (SQLException e) {
                throw e;
            } catch (Exception e) {
                throw e;
            } finally {

                if (conn != null) {
                    conn.close();
                }

                if (procedureCall != null) {
                    procedureCall.close();
                }

            }
        //}
    }
    
    public void confirmAccount(Account_Class account) throws Exception {    
   
            Database_Class db = new Database_Class();
            Connection conn = db.getConnection();
            CallableStatement procedureCall = null;

            try {           

                procedureCall = conn.prepareCall("{ CALL CMSC495.usp_ConfirmAccount(?, ?) }");
                procedureCall.setString(1, account.getUserName()); 
                procedureCall.setInt(2, account.getAccountID()); 
                procedureCall.executeQuery();              

            } catch (SQLException e) {
                throw e;
            } catch (Exception e) {
                throw e;
            } finally {

                if (conn != null) {
                    conn.close();
                }

                if (procedureCall != null) {
                    procedureCall.close();
                }

            }
    }    




    

    public void sendEmail() {
        if (validForm == true) {
            // tell Email_Engine to send the email
        }
    }

    public void deleteUser(String loginName, int accountID) throws Exception {

        Database_Class db = new Database_Class();
        Connection conn = db.getConnection();
        CallableStatement procedureCall = null;

        try {

            procedureCall = conn.prepareCall("{ CALL CMSC495.usp_DeleteAccount(?, ?) }");
            procedureCall.setString(1, loginName);
            procedureCall.setInt(2, accountID);
            procedureCall.executeQuery();

        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } finally {

            if (conn != null) {
                conn.close();
            }

            if (procedureCall != null) {
                procedureCall.close();
            }

        }

    }
    
     public Account_Class getAccount(int accountID) throws Exception {

        Database_Class db = new Database_Class();
        Connection conn = db.getConnection();
        CallableStatement procedureCall = null;
        ResultSet resultSet = null;
        Account_Class account = new Account_Class();

        try {          

            procedureCall = conn.prepareCall("{ CALL CMSC495.usp_GetAccount(?) }");
            procedureCall.setInt(1, accountID);            
            procedureCall.executeQuery();               
            resultSet = procedureCall.getResultSet();           
            
            while (resultSet.next()) {
                
                //debug
                //System.out.println("3");     
                //System.out.println(resultSet.getString(3));
                //System.out.println(resultSet.getString("FirstName"));
                //System.out.println(account);
                account.setAccountID(resultSet.getInt("AccountID"));
                account.setFirstName(resultSet.getString("FirstName"));
                account.setMiddleInitial(resultSet.getString("MiddleInitial"));
                account.setLastName(resultSet.getString("LastName"));
                account.setUserEmail(resultSet.getString("Email"));
                account.setUserName(resultSet.getString("LoginName"));   
                account.setCreditCardNumber(resultSet.getString("MaskedCreditCard"));   
                account.setCcDate(resultSet.getString("ExpirationDate")); 
                account.setAddressLine1(resultSet.getString("AddressLine1")); 
                account.setAddressLine2(resultSet.getString("AddressLine2")); 
                account.setCity(resultSet.getString("City")); 
                account.setState(resultSet.getString("State")); 
                account.setZipCode(resultSet.getString("ZipCode")); 
                
                //debug
                //System.out.println("4");

            }    
            
            return account;

        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } finally {

            if (conn != null) {
                conn.close();
            }

            if (procedureCall != null) {
                procedureCall.close();
            }
            
            if (resultSet != null) {
                resultSet.close();
            }            

        }
        

    }   
     
     public static Account_Class[] getAllAccounts() throws Exception {

        Database_Class db = new Database_Class();
        Connection conn = db.getConnection();
        CallableStatement procedureCall = null;
        ResultSet resultSet = null;
        //Account_Class[] accountArray = new Account_Class[100];

        try {          

            procedureCall = conn.prepareCall("{ CALL CMSC495.usp_GetAllAccounts(?) }");
            procedureCall.registerOutParameter(1, Types.INTEGER); //row count       
            procedureCall.executeQuery();               
            resultSet = procedureCall.getResultSet(); 
            int index = procedureCall.getInt(1);
            int row = 0;
            
            //debug
            //System.out.println(index);
            
            Account_Class[] accountArray = new Account_Class[index];
            
  
            
            while (resultSet.next()) {
                
               //System.out.println( resultSet.length);
                
                //debug
                //System.out.println("3");     
                //System.out.println(resultSet.getString(3));
                //System.out.println(resultSet.getString("FirstName"));
                //System.out.println(account);
                accountArray[row] = new Account_Class();
                
                accountArray[row].setAccountID(resultSet.getInt("AccountID"));
                accountArray[row].setFirstName(resultSet.getString("FirstName"));
                accountArray[row].setMiddleInitial(resultSet.getString("MiddleInitial"));
                accountArray[row].setLastName(resultSet.getString("LastName"));
                accountArray[row].setUserEmail(resultSet.getString("Email"));
                accountArray[row].setUserName(resultSet.getString("LoginName"));   
                accountArray[row].setCreditCardNumber(resultSet.getString("MaskedCreditCard"));   
                accountArray[row].setCcDate(resultSet.getString("ExpirationDate")); 
                accountArray[row].setAddressLine1(resultSet.getString("AddressLine1")); 
                accountArray[row].setAddressLine2(resultSet.getString("AddressLine2")); 
                accountArray[row].setCity(resultSet.getString("City")); 
                accountArray[row].setState(resultSet.getString("State")); 
                accountArray[row].setZipCode(resultSet.getString("ZipCode")); 
                
                //debug
                //System.out.println("AccountID: " + accountArray[row].getAccountID() + ", " + "UserName: " + accountArray[row].getUserName() + ", " + "FirstName: " + accountArray[row].getFirstName() + ", " + "MiddleInitial: " + accountArray[row].getMiddleInitial() + ", " + "LastName: " + accountArray[row].getLastName()); 
//                System.out.println(accountArray[row].getUserEmail()); 
//                System.out.println(accountArray[row].getCreditCardNumber()); 
//                System.out.println(accountArray[row].getCcDate()); 
//                System.out.println(accountArray[row].getCvvCode()); 
//                System.out.println(accountArray[row].getPassword()); 
//                System.out.println(accountArray[row].getAddressLine1()); 
//                System.out.println(accountArray[row].getAddressLine2()); 
//                System.out.println(accountArray[row].getCity()); 
//                System.out.println(accountArray[row].getState()); 
//                System.out.println(accountArray[row].getZipCode()); 
                //System.out.println(row);
                //System.out.println(accountArray.length);
                
                row++;
              

            }    
            
            //System.out.println(accountArray.length);
            
            //debug
//            for(int i=0; i<accountArray.length; i++) {
//               System.out.println("AccountID: " + accountArray[i].getAccountID() + ", " + "UserName: " + accountArray[i].getUserName() + ", " + "FirstName: " + accountArray[i].getFirstName() + ", " + "MiddleInitial: " + accountArray[i].getMiddleInitial() + ", " + "LastName: " + accountArray[i].getLastName()); 
//            }            
            
            return accountArray;

        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } finally {

            if (conn != null) {
                conn.close();
            }

            if (procedureCall != null) {
                procedureCall.close();
            }
            
            if (resultSet != null) {
                resultSet.close();
            }            

        }
        

    }        

    public static void main(String[] args) throws Exception {
        
        /**
         * Create the Account_Class object
         */
        Account_Class account = new Account_Class();
        
        //debug
//        Base_Class base = new Base_Class();
//        base.getAllAccounts();

        /**
         * Instantiate the GUI
         */
//        GUI gui = new GUI();

        /**
         * Instantiate the Database_Class
         */
       // Database_Class db = new Database_Class();

        /**
         * Instantiate the security features
         */
        //Currently all Security_Class methods are public static
        //Security_Class sc = new Security_Class();
        /**
         * Instantiate the Email_Engine
         */
        Email_Engine ee = new Email_Engine();

        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new com.acp.gui.GUI_Class(account);
            }
        });
    }

}