/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.acp.gui;

import javax.swing.JOptionPane;

/**
 *
 * @author dewal
 */
public class GUI_Class {
    
    private com.acp.Account_Class account;

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
        
        account.setFirstName(registerPage.getFirstName());
        account.setMiddleInitial(registerPage.getMiddleInitial());
        account.setLastName(registerPage.getLastName());
        
        
        //get all the info
        
        //send to DB
        //com.acp.Base_Class.newEntry(account);
        
        
        //validate form
        //hash password
        //store user info
        //send email
        //pop up confirmation dialog
        JOptionPane.showMessageDialog(null, "Registration form submitted!");

        //send to confirmation page
        initConfirmationPage();
        registerPage.setVisible(false);
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
        JOptionPane.showMessageDialog(null, "Coming soon");
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

    private void loginLoginPage() {

        //get inputs from GUI
        String username = loginPage.getUsername();
        String password = loginPage.getPassword();

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

        } else {
            JOptionPane.showMessageDialog(null, "Username/password invalid");
        }
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
        JOptionPane.showMessageDialog(null, "Account Updated");
        editAccountPage.setVisible(false);

    }

    private void backEditAccountPage() {
        editAccountPage.setVisible(false);
    }

}
