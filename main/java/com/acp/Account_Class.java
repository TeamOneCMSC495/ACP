/**
 * Purpose: Hold an account object which will be created by the Base_Class and
 * passed to the GUI and Database_Class for recording values and inputting to the
 * database
 * UMGC CMSC 495 Special Topics Developer: Team 1
 * Date: February 19,2021
 */
package com.acp;

import com.codahale.passpol.Status;
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
    private Boolean returningUser = false;
    private int accountID;
    private String userName;
    private String firstName;
    private String middleInitial;
    private String lastName;
    private String userEmail;
    private int loginCount = 0;
    private int loyaltyPoints = 0;
    public String localDateString;
    public String localTimeString;
    public Boolean rejectForm = false;
    private String creditCardNumber;
    private String ccDate;
    private String cvvCode;
    private String password;
    public Boolean validForm = false;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String zipCode;
    private Boolean accountConfirmed;
    private String confirmationCode;

    /**
     * Constructor
     */
    public Account_Class() {

    }

    public Account_Class(int accountID, String userName, String userEmail, String firstName,
            String middleInitial, String lastName, String creditCardNumber,
            String ccDate, String cvvCode, String password) {

        this.accountID = accountID;
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
        if (getReturningUser() == false) {
            if (getFirstName().length() == 0) {
                JOptionPane.showMessageDialog(null, "Invalid first name, first name cannot be blank");
                setRejectForm((Boolean) true);
            } else if (getFirstName().length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid first name, first name cannot be more than 128 characters");
                setRejectForm((Boolean) true);
            } else if (getMiddleInitial().length() >= 2) {
                JOptionPane.showMessageDialog(null, "Invalid middle initial, middle initial cannot be more than 1 character");
                setRejectForm((Boolean) true);
            } else if (getLastName().length() == 0) {
                JOptionPane.showMessageDialog(null, "Invalid last name, last name cannot be blank");
                setRejectForm((Boolean) true);
            } else if (getLastName().length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid last name, last name cannot be more than 128 characters");
                setRejectForm((Boolean) true);
//            } else if (getCreditCardNumber() >= 0) {
//                int ccn = String.valueOf(getCreditCardNumber()).length();
//                if (ccn <= 15) {
//                    JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number must be 16 digits");
//                    setRejectForm((Boolean) true);
//                } else if (ccn >= 17) {
//                    JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number must be 16 digits");
//                    setRejectForm((Boolean) true);
//                } else if (ccn > 0) {
//                    String cCNString = Integer.toString(ccn);
//                    Pattern regex = Pattern.compile("[^A-Za-z0-9]");
//                    Matcher matcher = regex.matcher(cCNString);
//                    boolean matches = matcher.matches();
//                    if (cCNString.contains(".")) {
//                        JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number cannot contain a decimal");
//                        setRejectForm((Boolean) true);
//                    } else if (matches == false) {
//                        JOptionPane.showMessageDialog(null, "Invalid credit card number, the credit card number cannot contain a special characters");
//                        setRejectForm((Boolean) true);
//                    }
////                }
//            } else if (getCcDate().length() > 0) {
//                Pattern regex = Pattern.compile("[^A-BA-B]" + "[^0-90-9]");
//                Matcher matcher = regex.matcher(getCcDate());
//                boolean matches = matcher.matches();
//                if (matches == false) {
//                    JOptionPane.showMessageDialog(null, "Invalid credit card date format, the date format is MMYY");
//                    setRejectForm((Boolean) true);
//                }
            } else if (getUserEmail().length() == 0) {
                JOptionPane.showMessageDialog(null, "Invalid email address, email address cannot be blank");
                setRejectForm((Boolean) true);
            } else if (getUserName().length() == 0) {
                JOptionPane.showMessageDialog(null, "Invalid user name, user name cannot be blank");
                setRejectForm((Boolean) true);
            } else if (getUserName().length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid userName, userName cannot be more than 128 characters");
                setRejectForm((Boolean) true);
            } else if (getPassword().length() <= 7) {
                JOptionPane.showMessageDialog(null, "Invalid password, password must be at least 8 characters");
                setRejectForm((Boolean) true);
            } else if (getPassword().length() >= 129) {
                JOptionPane.showMessageDialog(null, "Invalid password, password must be less than or equal to 128 characters");
                setRejectForm((Boolean) true);
            } else if (Security_Class.testPassword(getPassword()) == Status.BREACHED) {
                JOptionPane.showMessageDialog(null, "Invalid password, password is found on a list of common passwords");
                setRejectForm((Boolean) true);
            } else {
                setValidForm((Boolean) true);
                //JOptionPane.showMessageDialog(null, "Welcome " + getUserName());
            }

        }

        //debug
//        System.out.println(getPassword());
//        System.out.println(getPassword().length());
    }

    public void assignAccountNumber() {
        if (getValidForm() == true) {
            // query the database to find database length
            // the account number is database length + 1
        }
    }

    /**
     * @return the returningUser
     */
    public Boolean getReturningUser() {
        return returningUser;
    }

    /**
     * @param returningUser the returningUser to set
     */
    public void setReturningUser(Boolean returningUser) {
        this.returningUser = returningUser;
    }

    /**
     * @return the userName
     */
    public String getUserName() {
        return userName;
    }

    /**
     * @param userName the userName to set
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * @return the middleInitial
     */
    public String getMiddleInitial() {
        return middleInitial;
    }

    /**
     * @param middleInitial the middleInitial to set
     */
    public void setMiddleInitial(String middleInitial) {
        this.middleInitial = middleInitial;
    }

    /**
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * @return the userEmail
     */
    public String getUserEmail() {
        return userEmail;
    }

    /**
     * @param userEmail the userEmail to set
     */
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    /**
     * @return the loginCount
     */
    public int getLoginCount() {
        return loginCount;
    }

    /**
     * @param loginCount the loginCount to set
     */
    public void setLoginCount(int loginCount) {
        this.loginCount = loginCount;
    }

    /**
     * @return the loyaltyPoints
     */
    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    /**
     * @param loyaltyPoints the loyaltyPoints to set
     */
    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    /**
     * @return the rejectForm
     */
    public Boolean getRejectForm() {
        return rejectForm;
    }

    /**
     * @param rejectForm the rejectForm to set
     */
    public void setRejectForm(Boolean rejectForm) {
        this.rejectForm = rejectForm;
    }

    /**
     * @return the creditCardNumber
     */
    public String getCreditCardNumber() {
        return creditCardNumber;
    }

    /**
     * @param creditCardNumber the creditCardNumber to set
     */
    public void setCreditCardNumber(String creditCardNumber) {
        this.creditCardNumber = creditCardNumber;
    }

    /**
     * @return the ccDate
     */
    public String getCcDate() {
        return ccDate;
    }

    /**
     * @param ccDate the ccDate to set
     */
    public void setCcDate(String ccDate) {
        this.ccDate = ccDate;
    }

    /**
     * @return the cvvCode
     */
    public String getCvvCode() {
        return cvvCode;
    }

    /**
     * @param cvvCode the cvvCode to set
     */
    public void setCvvCode(String cvvCode) {
        this.cvvCode = cvvCode;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the validForm
     */
    public Boolean getValidForm() {
        return validForm;
    }

    /**
     * @param validForm the validForm to set
     */
    public void setValidForm(Boolean validForm) {
        this.validForm = validForm;
    }

    /**
     * @return the accountID
     */
    public int getAccountID() {
        return accountID;
    }

    /**
     * @param accountID the password to set
     */
    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    /**
     * @return the addressLine1
     */
    public String getAddressLine1() {
        return addressLine1;
    }

    /**
     * @param addressLine1 the password to set
     */
    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    /**
     * @return the addressLine2
     */
    public String getAddressLine2() {
        return addressLine2;
    }

    /**
     * @param addressLine2 the password to set
     */
    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    /**
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * @param city the password to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * @param state the password to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * @return the zipCode
     */
    public String getZipCode() {
        return zipCode;
    }

    /**
     * @param zipCode the password to set
     */
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    @Override
    public String toString() {
        return returningUser + "," + accountID + "," + userName + ","
                + firstName + "," + middleInitial + "," + lastName + "," + userEmail
                + "," + loginCount + "," + loyaltyPoints + "," + localDateString
                + "," + localTimeString + "," + rejectForm + "," + creditCardNumber
                + "," + "ccDate" + "," + cvvCode + "," + password + "," + validForm
                + "," + addressLine1 + "," + addressLine2 + "," + city + ","
                + state + "," + zipCode;
    }

    public String toStringReportFormat() {
        //return blank line output instead of "Null" for second address line
        String addressLineTwo;
        if (addressLine2 == null) {
            addressLineTwo = "";
        } else addressLineTwo = addressLine2;
        
        return firstName + "," + middleInitial + "," + lastName + ","
                + accountID + "," + userName + "," + userEmail + ","
                + loginCount + "," + loyaltyPoints + "," //currently always "0"
                + creditCardNumber.substring(12) + "," + //trims off leading asterisks from masked CCN
                ccDate + ","
                + addressLine1 + "," + addressLineTwo + "," + city + "," + state + ","
                + zipCode;
    }

    /**
     * @return the accountConfirmed
     */
    public Boolean getAccountConfirmed() {
        return accountConfirmed;
    }

    /**
     * @param confirmed the password to set
     */
    public void setAccountConfirmed(Boolean confirmed) {
        this.accountConfirmed = confirmed;
    }

    /**
     * @return the confirmationCode
     */
    public String getConfirmationCode() {
        return confirmationCode;
    }

    /**
     * @param confirmationCode the password to set
     */
    public void setConfirmationCode(String confirmationCode) {
        this.confirmationCode = confirmationCode;
    }

}
