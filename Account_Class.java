/**
 * Purpose: Hold an account object which will be created by the Base_Class and
 * passed to the GUI and Database_Class for recording values and inputting to the
 * database
 * UMGC CMSC 495 Special Topics Developer: Team 1
 * Date: February 19,2021
 */
package com.acp;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.JOptionPane;

/**
 *
 * @author cplun
 */
public class Account_Class {

    /**
     * Instance and Field variables
     */
    public Boolean returningUser = false;
    public String userName;
    public String firstName;
    public String middleInitial;
    public String lastName;
    public String userEmail;
    public int loginCount = 0;
    public int loyaltyPoints = 0;
    public String localDateString;
    public String localTimeString;
    public Boolean rejectForm = false;
    public int creditCardNumber = 0;
    public String ccDate;
    public int cvvCode = 999;
    public String password;
    public Boolean validForm = false;

    /**
     * Constructor
     */
    public Account_Class() {

    }

    public Account_Class(String userName, String userEmail, String firstName,
            String middleInitial, String lastName, int creditCardNumber,
            String ccDate, int cvvCode, String password) {

        this.userName = userName;
        this.userEmail = userEmail;
        this.firstName = firstName;
        this.middleInitial = middleInitial;
        this.lastName = lastName;
        this.creditCardNumber = creditCardNumber;
        this.ccDate = ccDate;
        this.cvvCode = cvvCode;
        this.password = password;
    }

    /**
     * Methods
     */
    public void recordFormData() {
        // use this to obtain data from the form
        // note this is probably not necessary if the data is passed via the constructor?
    }

    public void validateFormData() {
        if (returningUser == false) {
            if (userName.length() == 0) {
                JOptionPane.showMessageDialog(null, "Invalid userName, userName cannot be blank");
                rejectForm = true;
            } else if (userName.length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid userName, userName cannot be more than 128 characters");
                rejectForm = true;
            } else if (firstName.length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid first name, first name cannot be more than 128 characters");
                rejectForm = true;
            } else if (middleInitial.length() >= 2) {
                JOptionPane.showMessageDialog(null, "Invalid middle initial, middle initial cannot be more than 1 character");
                rejectForm = true;
            } else if (lastName.length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid last name, last name cannot be more than 128 characters");
                rejectForm = true;
            } else if (creditCardNumber >= 0) {
                int ccn = String.valueOf(creditCardNumber).length();
                if (ccn <= 15) {
                    JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number must be 16 digits");
                    rejectForm = true;
                } else if (ccn >= 17) {
                    JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number must be 16 digits");
                    rejectForm = true;
                } else if (ccn > 0) {
                    String cCNString = Integer.toString(ccn);
                    Pattern regex = Pattern.compile("[^A-Za-z0-9]");
                    Matcher matcher = regex.matcher(cCNString);
                    boolean matches = matcher.matches();
                    if (cCNString.contains(".")) {
                        JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number cannot contain a decimal");
                        rejectForm = true;
                    } else if (matches == false) {
                        JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number cannot contain a special characters");
                        rejectForm = true;
                    }
                }
            } else if (ccDate.length() > 0) {
                Pattern regex = Pattern.compile("[^A-BA-B]" + "[^0-90-9]");
                Matcher matcher = regex.matcher(ccDate);
                boolean matches = matcher.matches();
                if (matches == false) {
                    JOptionPane.showMessageDialog(null, "Invalid credit card date format, the date format is MMYY");
                    rejectForm = true;
                }
            } else if (password.length() <= 7) {
                JOptionPane.showMessageDialog(null, "Invalid password, password must be at least 8 characters");
                rejectForm = true;
            } else if (password.length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid password, password must be less than or equal to 128 characters");
                rejectForm = true;
            } else if (Security_Class.testPassword(password) == Status.BREACHED) {
                JOptionPane.showMessageDialog(null, "Invalid password, password is found on a list of common passwords");
                rejectForm = true;
            } else {
                validForm = true;
                JOptionPane.showMessageDialog(null, "Welcome " + userName);
            }

        }
    }

    public void assignAccountNumber() {
        if (validForm == true) {
            // query the database to find database length
            // the account number is database length + 1
        }
    }

}
