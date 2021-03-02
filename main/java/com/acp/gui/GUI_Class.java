/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.acp.gui;

import com.acp.Email_Engine;
import javax.swing.JOptionPane;
import java.sql.SQLException;
import java.time.LocalDate;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dewal
 */
public class GUI_Class {
    
    private com.acp.Account_Class account = new com.acp.Account_Class();
    private com.acp.Security_Class security = new com.acp.Security_Class();
    private com.acp.Base_Class base = new com.acp.Base_Class();

    private AccountCreationPortal splashPage;
    private Register registerPage;
    private NewAccountConfirmation confirmationPage;
    private ReturnUserLogin loginPage;
    private OwnerAccountTool ownerToolPage;
    private ReturningUserTool customerToolPage;
    private EditAccountInfo editAccountPage;
    private LoyaltyPointsUpdate loyaltyPointsPage;
    private ExportJFrame exportReportsPage;
    private ChangeExportPathJFrame changePathPage;

    //tracks when a window has already been created so redundant event listeners
    //are not created
    private Boolean splashPageInit = false;
    private Boolean registerPageInit = false; 
    private Boolean confirmationPageInit = false;
    private Boolean loginPageInit = false;
    private Boolean ownerToolPageInit = false;
    private Boolean customerToolPageInit = false;
    private Boolean editAccountPageInit = false;
    private Boolean loyaltyPointsPageInit = false;
    private Boolean exportReportsPageInit = false;
    private Boolean changePathPageInit = false;   
    

    /*
    holding pattern:
    editAccountPageInit  = true;
    loyaltyPointsPageInit  = true;
    exportReportsPageInit  = true;
    changePathPageInit  = true;
     */
    public GUI_Class(com.acp.Account_Class account) {
        splashPage = new AccountCreationPortal();
        registerPage = new Register();
        confirmationPage = new NewAccountConfirmation();
        loginPage = new ReturnUserLogin();
        ownerToolPage = new OwnerAccountTool();
        customerToolPage = new ReturningUserTool();
        editAccountPage = new EditAccountInfo();
        loyaltyPointsPage = new LoyaltyPointsUpdate();
        exportReportsPage = new ExportJFrame();
        changePathPage = new ChangeExportPathJFrame();
        initSplashPage();

    }

    //-----------------Splash page controls-----------------
    private void initSplashPage() {
        splashPage.setVisible(true);
        if (!splashPageInit) {
            splashPage.getCreateJButton().addActionListener(e -> openRegisterWindow());
            splashPage.getLoginJButton().addActionListener(e -> LoginSplashPage());
        }
        splashPageInit = true;
    }

    private void openRegisterWindow() {
        splashPage.setVisible(false);
        initRegisterPage();
    }

    private void LoginSplashPage() {
        splashPage.setVisible(false);
        initLoginPage();

    }

    //------------------registration page controls-------------
    private void initRegisterPage() {
        
        registerPage.setVisible(true);
        if (!registerPageInit) {
            registerPage.getBackJButton().addActionListener(e -> backRegisterWindow());
            registerPage.getSubmitJButton().addActionListener(e -> submitRegisterWindow());
        }
        registerPageInit = true;
    }

    private void backRegisterWindow() {
        registerPage.setVisible(false);
        splashPage.setVisible(true);
    }

    private void submitRegisterWindow() {
        //update account obj
        
        //Security_Class security = new Security_Class();
        
        
        int year = Integer.parseInt(registerPage.getExpirationYearComboBox());
        int month = Integer.parseInt(registerPage.getExpirationMonthComboBox());
        int day = 1;
            
        LocalDate ccDate = LocalDate.of(year, month, day);
        
        Random rand = new Random();
        int random=rand.nextInt(999999) + 10;
                String randString = String.valueOf(random);
                System.out.println("Here is you verification number: " + randString);
            //message.setText("Thank you for registering. Here is you verification number: " + confirmationCode);
        try {
            Email_Engine.sendMail("creationprotal495@gmail.com",randString);
            
            /*
            HashSet<Integer> set = new HashSet<>();
            while(set.size()< 1){
            int random=rand.nextInt(999999) + 10;
            
            */
//        String randString = String.valueOf(random);

//            set.add(random);
        } catch (Exception ex) {
            Logger.getLogger(GUI_Class.class.getName()).log(Level.SEVERE, null, ex);
        }
            
            
      /*  }for (int randomNumber:set){
            System.out.println("Here is you verification number: " + randomNumber);
            //message.setText("Thank you for registering. Here is you verification number: " + confirmationCode);
            
                    Email_Engine.sendMail("creationprotal495@gmail.com", );

        }
        */
        account.setFirstName(registerPage.getFirstName());
        account.setMiddleInitial(registerPage.getMiddleInitial());
        account.setLastName(registerPage.getLastName());
        account.setUserEmail(registerPage.getUserEmail());
        account.setUserName(registerPage.getUserName());
        account.setPassword(registerPage.getPassword()); //sending plain text to validate form.  Maybe this should change?
        //account.setCreditCardNumber("1111222233334444"); //Hardcoding until form is updated
        //account.setCcDate("01-12-2023"); //Hardcoding until form is updated
        //account.setCvvCode(234);       //Not storing credit card CCV anymore.
        account.setAddressLine1(registerPage.getAddressLineOneField());
        account.setAddressLine2(registerPage.getAddressLineTwoField());
        account.setCity(registerPage.getCityField());
        account.setState(registerPage.getStateComboBox());
        account.setZipCode(registerPage.getZipCodeField()); 
        account.setCreditCardNumber(registerPage.getCardNumberField()); //Hardcoding until form is updated
        account.setCcDate(ccDate.toString()); //Hardcoding until form is updated    
       
        account.setConfirmationCode(randString); //Replace text with actual confirmation code

        
        account.validateFormData();      

        if (account.getValidForm()){

            try{
                
                //debug
//                System.out.println(registerPage.getUserEmail());
//                System.out.println(registerPage.getUserEmailConfirm());
//                System.out.println(registerPage.getUserEmail().equals(registerPage.getUserEmailConfirm()));
                
                
                if (!registerPage.getUserEmail().equals(registerPage.getConfirmUserEmail())){
                    throw new SQLException("Email does not match!");  
                }
                
                if (!registerPage.getPassword().equals(registerPage.getConfirmPassword())){
                    throw new SQLException("Password does not match!");  
                }                

                //check for existing user name
                base.existingUserCheck(account.getUserName());
                Boolean returningUser = base.returningUser;

                if(returningUser){      
                    throw new SQLException("Username already exists!");                                        
                }                      

                
                String hashedPassword = security.performHash(registerPage.getPassword());  
                
                //hash password
                account.setPassword(hashedPassword);

                 //Base_Class base = new Base_Class();
                 base.storeFormDataInSQLDatabase(account);    

                 //debug
                 //System.out.println(hashedPassword);
                 
                //pop up confirmation dialog
                JOptionPane.showMessageDialog(null, "Registration form submitted!");

                //send to confirmation page
                initConfirmationPage();
                registerPage.setVisible(false);     
                
                //clear form
                registerPage.clear();

             } catch(SQLException e){
                 JOptionPane.showMessageDialog(null, e.getMessage());
                 //throw new RuntimeException(e);
             } catch (Exception e){

             }             

        }
            
                
        
        
        //System.out.println(account.getFirstName());
        
        //Security_Class security = new Security_Class();
        //String hashedPassword = security.performHash(jPasswordField1.getText());
      
        //Account_Class ac = new Account_Class(userField.getText(), emailField.getText(), nameField.getText(), "", nameField.getText(), 11112222, "20220221", 234, hashedPassword);
        
        //get all the info
        
        //send to DB
        //com.acp.Base_Class.newEntry(account);
        
       
        
        
        //validate form
        //hash password
        //store user info
        //send email

    }

    //-----------------------Confirmation Page Controls--------------------
    private void initConfirmationPage() {

        confirmationPage.setVisible(true);
        if (!confirmationPageInit) {
            confirmationPage.getHomeJButton().addActionListener(e -> homeConfirmWindow());
            confirmationPage.getVerifyJButton().addActionListener(e -> verifyConfirmWindow());
        }
        confirmationPageInit = true;
    }

    private void verifyConfirmWindow() {
        
//get confirmation code from GUI
        String inputCode  = confirmationPage.getConfirmationCode();
        //get account.confirmation code
        String storedCode = account.getConfirmationCode();
       
        //if they match
        if (storedCode.matches(inputCode)){
           confirmAccount(); 
           JOptionPane.showMessageDialog(null, "Account Confirmed");

        }else{
            JOptionPane.showMessageDialog(null, "Incorrect Confirmation Code");    
        }

    }

    private void homeConfirmWindow() {
        confirmationPage.setVisible(false);

        initSplashPage();
    }

    //-----------------------Login Page Controls--------------------
    private void initLoginPage() {
        loginPage.setVisible(true);
        if (!loginPageInit) {
            loginPage.getBackJButton().addActionListener(e -> backLoginPage());
            loginPage.getLoginJButton().addActionListener(e -> loginLoginPage());
        }
        loginPageInit = true;
    }

    private void backLoginPage() {
        loginPage.setVisible(false);
        initSplashPage();

    }
    
    private void populateEditAccountPage(){
        
        try {            
        
            //get account info from Base_Class
            account = base.getAccount(account.getAccountID());
            
            //Split the credit card expiration date 
            String dateParts[] = account.getCcDate().split("-");   
            String year = dateParts[0];
            String month = dateParts[1];
            String day = dateParts[2];  
            
            //populate edit page
            //editAccountPage.setNameField(account.getFirstName() + " " + ((account.getMiddleInitial() == null) ? "" : account.getMiddleInitial()) + " " + account.getLastName());
            editAccountPage.setFirstNameField(account.getFirstName());
            editAccountPage.setMiddleInitialField(account.getMiddleInitial());
            editAccountPage.setLastNameField( account.getLastName());            
            editAccountPage.setUserField(account.getUserName());
            editAccountPage.setEmailField(account.getUserEmail());  
            editAccountPage.setAddressLineOneField(account.getAddressLine1());  
            editAccountPage.setAddressLineTwoField(account.getAddressLine2());  
            editAccountPage.setCityField(account.getCity());  
            editAccountPage.setStateComboBox(account.getState());  
            editAccountPage.setZipCodeField(account.getZipCode());          
            editAccountPage.setCardNumberField(account.getCreditCardNumber());  
            editAccountPage.setExpirationMonthComboBox(month);  
            editAccountPage.setExpirationYearComboBox(year);
            editAccountPage.setCVVField("");              

        
         } catch(SQLException e){
             JOptionPane.showMessageDialog(null, e.getMessage());
             //throw new RuntimeException(e);
         } catch (Exception e){

         }         
        
    }
    
    private Boolean validatePassword(String userName){
        
        boolean validPassword = false;        
        
        try {                 

            //String userName = loginPage.getUsername();
            String password = loginPage.getPassword();

            //Get hash for the supplied user name
            account = base.getHashedPassword(userName);       
            String hashPassword = account.getPassword();

            //System.out.println(account.getAccountID());
            //validate password
            validPassword = security.checkCorrectPassword(password, hashPassword);               
        
         } catch(SQLException e){
             JOptionPane.showMessageDialog(null, e.getMessage());
             //throw new RuntimeException(e);
         } catch (Exception e){

         }   
        
        return validPassword;
        
    }   
    
    private void confirmAccount(){  
        
        try {      

            base.confirmAccount(account);
        
         } catch(SQLException e){
             JOptionPane.showMessageDialog(null, e.getMessage());
             //throw new RuntimeException(e);
         } catch (Exception e){

         }           
        
    }     

    private void loginLoginPage() {

        //get inputs from GUI
        String username = loginPage.getUsername();
        String password = loginPage.getPassword();
        
        boolean validPassword = validatePassword(username);
        boolean accountConfirmed = account.getAccountConfirmed();   
        String confirmationCode = account.getConfirmationCode(); 
        
        //debug
        System.out.println("Account Confirmed? " + accountConfirmed);
        System.out.println("Confirmation Code: " + confirmationCode);
            
//            //Get hash for the supplied user name
//            account = base.getHashedPassword(username);       
//            String hashPassword = account.getPassword();
//            
//            
//            //System.out.println(account.getAccountID());
//            //validate password
//            Boolean validPassword = security.checkCorrectPassword(password, hashPassword);         
            
            //debug
            //System.out.println(hashPassword);                
            //System.out.println(security.checkCorrectPassword(password, hashPassword));

            /*
            This commented out section is the correct implementation for the log in
            once the database is connected and the database calls are built in
             */
            ////get account from DB based on username
            //if (account in database){
            //account = retrieved_account;
            //}else JOptionPane.showMessageDialog(null, "Username/password invalid");
            //get hash from account
            //String hash = account.password;
            //pass entered password against stored hash
    //        if (Security_Class.checkCorrectPassword(password, hash)) {
    //            if (account.confirmed) {
    //                if account.owner   {//sends to owner tools
    //                    loginPage.setVisible(false);
    //                    ownerToolPageInit();
    //                } else {//sends to cusomter tools
    //                    loginPage.setVisible(false);
    //                    customerToolPageInit();
    //                }
    //            } else {//if account is not confirmed yet, send to confirmation page
    //                initConfirmationPage();
    //                loginPage.setVisible(false);
    //            }
    //        } else {//if password/hash is not matched
    //            JOptionPane.showMessageDialog(null, "Username/password invalid");
    //        }
            /*
    
    This is only a placeholder for log in function. 
             */
            if ((username.matches(
                    "owner")) && (password.matches("admin"))) {
                loginPage.setVisible(false);
                ownerToolPageInit();
            } else if ((username.matches(
                    "customer")) && (password.matches("returning"))) {
                loginPage.setVisible(false);
                customerToolPageInit();
            } else if (validPassword && !accountConfirmed) {
                JOptionPane.showMessageDialog(null, "Account must be verified!");
                loginPage.setVisible(false);
                initConfirmationPage();

            } else if (validPassword) {
                loginPage.setVisible(false);
                customerToolPageInit();
                
            } else {
                JOptionPane.showMessageDialog(null, "Username/password invalid");
            }         

            //Popo
            populateEditAccountPage();

            //clear field values
            loginPage.clear();
        
 
        
    }
//-----------------------Owner Page Controls--------------------

    private void ownerToolPageInit() {
        ownerToolPage.setVisible(true);
        if (!ownerToolPageInit) {
            ownerToolPage.getPathJButton().addActionListener(e -> pathOwnerPage());
            ownerToolPage.getExportJButton().addActionListener(e -> exportOwnerPage());
            ownerToolPage.getLookupJButton().addActionListener(e -> lookupOwnerPage());
            ownerToolPage.getLoyaltyJButton().addActionListener(e -> loyaltyOwnerPage());
            ownerToolPage.getSettingsJButton().addActionListener(e -> settingsOwnerPage());
            ownerToolPage.getLogoutJButton().addActionListener(e -> logoutOwnerPage());
        }
        ownerToolPageInit = true;
    }

    private void pathOwnerPage() {
        initChangePathPage();
    }

    private void exportOwnerPage() {
        initExportReportsPage();
    }

    private void lookupOwnerPage() {
        //user search not implemented yet
        //initUserLookupPage();
        JOptionPane.showMessageDialog(null, "Coming soon");
    }

    private void loyaltyOwnerPage() {
        initloyaltyPointsPage();
    }

    private void settingsOwnerPage() {
        JOptionPane.showMessageDialog(null, "Coming soon");

    }

    private void logoutOwnerPage() {
        ownerToolPage.setVisible(false);
        initSplashPage();
    }

    //-----------------------Path Page Controls--------------------
    private void initChangePathPage() {
        changePathPage.setVisible(true);

        if (!changePathPageInit) {
            changePathPage.getBrowseJButton().addActionListener(e -> browsePathPage());
            changePathPage.getUpdateJButton().addActionListener(e -> updatePathPage());
            changePathPage.getCancelJButton().addActionListener(e -> cancelPathPage());
        }
        changePathPageInit = true;

    }

    private void browsePathPage() {
        JOptionPane.showMessageDialog(null, "Coming soon");
        //get changePathPage text
        //set export path
        changePathPage.setVisible(false);
    }

    private void updatePathPage() {
        JOptionPane.showMessageDialog(null, "Path Updated");

    }

    private void cancelPathPage() {
        changePathPage.setVisible(false);
    }

    //-----------------------Export Page Controls--------------------
    private void initExportReportsPage() {
        exportReportsPage.setVisible(true);

        if (!exportReportsPageInit) {
            exportReportsPage.getAllJButton().addActionListener(e -> allExportPage());
            exportReportsPage.getSingleJButton().addActionListener(e -> singleExportPage());
            exportReportsPage.getTailoredJButton().addActionListener(e -> tailoredExportPage());
            exportReportsPage.getBackJButton().addActionListener(e -> backExportPage());
        }
        exportReportsPageInit = true;
    }

    private void allExportPage() {
        //export all users from DB in CSV
        JOptionPane.showMessageDialog(null, "Coming soon - Export report of all users");
    }

    private void singleExportPage() {
        //open user search
        //export single user from DB in CSV
        JOptionPane.showMessageDialog(null, "Coming soon - Export report of single user");

    }

    private void tailoredExportPage() {
        //open report tailoring window
        //export report from DB in CSV
        JOptionPane.showMessageDialog(null, "Coming soon - Export tailored user report");
    }

    private void backExportPage() {
        exportReportsPage.setVisible(false);
    }

    //-----------------------Edit Loyalty Points Page Controls--------------------
    private void initloyaltyPointsPage() {
        loyaltyPointsPage.setVisible(true);

        if (!loyaltyPointsPageInit) {
            loyaltyPointsPage.getSearchJButton().addActionListener(e -> searchLoyaltyPage());
            loyaltyPointsPage.getUpdateJButton().addActionListener(e -> updateLoyaltyPage());
            loyaltyPointsPage.getBackJButton().addActionListener(e -> backLoyaltyPage());
        }
        loyaltyPointsPageInit = true;
    }

    private void searchLoyaltyPage() {
        //search DB for account number
        //if found - set label w/ points
        JOptionPane.showMessageDialog(null, "User not found");
    }

    private void updateLoyaltyPage() {
        JOptionPane.showMessageDialog(null, "Points updated");
        //update DB entry
        //update label in jframe
    }

    private void backLoyaltyPage() {
        loyaltyPointsPage.setVisible(false);
    }

    //-----------------------Customer Tool Page Controls--------------------
    private void customerToolPageInit() {
        customerToolPage.setVisible(true);

        if (!customerToolPageInit) {
            customerToolPage.getEditJButton().addActionListener(e -> editCustomerPage());
            customerToolPage.getSettingsJButton().addActionListener(e -> settingsCustomerPage());
            customerToolPage.getLogoutJButton().addActionListener(e -> logoutCustomerPage());
        }
        customerToolPageInit = true;

    }

    private void editCustomerPage() {
        editAccountPageInit();        
    }

    private void settingsCustomerPage() {
        JOptionPane.showMessageDialog(null, "Coming soon");
    }

    private void logoutCustomerPage() {
        customerToolPage.setVisible(false);
        initSplashPage();
    }

    //-----------------------Edit Account Page Controls--------------------
    private void editAccountPageInit() {                
        editAccountPage.setVisible(true);
        if (!editAccountPageInit) {
            editAccountPage.getConfirmJButton().addActionListener(e -> confirmEditAccountPage());
            editAccountPage.getBackJButton().addActionListener(e -> backEditAccountPage());
        }
        editAccountPageInit = true;
    }

    private void confirmEditAccountPage() {

//        String fullName = editAccountPage.getNameField().trim();
//        String firstName = fullName.substring(0,fullName.indexOf(" ")).trim();
//        String lastName = fullName.substring(firstName.length(), fullName.length()).trim();   

        
        //setExpirationMonthComboBox
        //getExpirationYearComboBox
        int year = Integer.parseInt(editAccountPage.getExpirationYearComboBox());
        int month = Integer.parseInt(editAccountPage.getExpirationMonthComboBox());
        int day = 1;
                
        LocalDate ccDate = LocalDate.of(year, month, day);
//        SimpleDateFormat sdf1 = new SimpleDateFormat("MM-dd-yyyy");
//        java.util.Date date = sdf1.parse(ccDate);        
        
        //debug
        //System.out.println(ccDate);
               
        account.setFirstName(editAccountPage.getFirstNameField());
        account.setMiddleInitial(editAccountPage.getMiddleInitialField());
        account.setLastName(editAccountPage.getLastNameField());
        account.setUserEmail(editAccountPage.getEmailField());
        account.setUserName(editAccountPage.getUserField());
        //account.setPassword(editAccountPage.getPassword()); //sending plain text to validate form.  Maybe this should change?
        account.setCreditCardNumber(editAccountPage.getCardNumberField()); //Hardcoding until form is updated
        account.setCcDate(ccDate.toString()); //Hardcoding until form is updated
        //account.setCvvCode(234);       //Not storing credit card CCV anymore.
        
        account.setAddressLine1(editAccountPage.getAddressLineOneField());
        account.setAddressLine2(editAccountPage.getAddressLineTwoField());
        account.setCity(editAccountPage.getCityField());
        account.setState(editAccountPage.getStateComboBox());
        account.setZipCode(editAccountPage.getZipCodeField());                    
        
        try {

            //Update account info
            base.updateFormDataInSQLDatabase(account); 


            JOptionPane.showMessageDialog(null, "Account Updated");
            editAccountPage.setVisible(false);
            
            //Refresh fields to make sure information was saved to thedatabase
            populateEditAccountPage();            
        
         } catch(SQLException e){
             JOptionPane.showMessageDialog(null, e.getMessage());
             //throw new RuntimeException(e);
         } catch (Exception e){

         } 
        
        

    }

    private void backEditAccountPage() {
        editAccountPage.setVisible(false);
    }

}