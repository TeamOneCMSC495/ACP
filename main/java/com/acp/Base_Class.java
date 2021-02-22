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

    public void validateWelcomeMessage() {
        if (returningUser == true) {
            JOptionPane.showMessageDialog(null, "Welcome back " + account.userName);
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

    public void storeFormDataInSQLDatabase(String loginName, String passWord, String firstName, String lastName, String middleInitial, String ccNumber, Date ccExpirationDate, String email) throws Exception {
        if (validForm == true) {
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

            try {

                java.sql.Date sql_CCExpirationDate = new java.sql.Date(ccExpirationDate.getTime()); //Need to convert Credit Card expiration date to an SQL acceptable date

                procedureCall = conn.prepareCall("{ CALL CMSC495.usp_InsertUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
                procedureCall.setString(1, loginName);
                procedureCall.setString(2, passWord);
                procedureCall.setString(3, firstName);
                procedureCall.setString(4, lastName);
                procedureCall.setString(5, middleInitial);
                procedureCall.setString(6, ccNumber);
                procedureCall.setDate(7, sql_CCExpirationDate);
                procedureCall.setString(8, email);
                procedureCall.registerOutParameter(9, Types.INTEGER);  //PersonID
                procedureCall.registerOutParameter(10, Types.INTEGER); //AccountID
                procedureCall.executeQuery();

                // Get the identity value of the new account			
                int accountID = procedureCall.getInt(10);

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

            procedureCall = conn.prepareCall("{ CALL CMSC495.usp_DeleteUser(?, ?) }");
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

    public static void main(String[] args) throws Exception {
        
        /**
         * Create the Account_Class object
         */
        Account_Class account = new Account_Class(userName, userEmail, firstName,
            middleInitial, lastName, creditCardNumber, ccDate, cvvCode, password);

        /**
         * Instantiate the GUI
         */
//        GUI gui = new GUI();

        /**
         * Instantiate the Database_Class
         */
        Database_Class db = new Database_Class();

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
                new com.acp.gui.AccountCreationPortal().setVisible(true);
            }
        });
    }

}
