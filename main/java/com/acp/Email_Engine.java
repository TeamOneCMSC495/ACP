package com.acp;

/** Purpose: Hold the class controlling the email service
 *  UMGC CMSC 495 Special Topics
 *  Developer: Team 1
 *  Date: February 12, 2021
 */
// import statements
import java.util.HashSet;
import javax.mail.Session;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



public class Email_Engine {
    
    
    
    
     public static void sendMail(String recpient, String confirmationCode) throws Exception {
        
        
        //String recipient = "accountcreation495@yahoo.com";
        
        
        
        System.out.println("Preparing to send email");
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host","smtp.gmail.com");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.port", "465");
        
        String sender = "creationprotal495@gmail.com";
        String password = "Accountcreation123*";

    Session session = Session.getInstance(properties, new Authenticator(){
        @Override
        protected PasswordAuthentication getPasswordAuthentication(){
            return new PasswordAuthentication(sender, password);
        }
    }
    );
    
    
    Message message = prepareMessage(session, sender, recpient,confirmationCode);
    
    Transport.send(message);
    System.out.println("Message sent successfully!");
    
    
    }
    
    private static Message prepareMessage(Session session, String sender, String recpient, String confirmationCode) throws MessagingException{
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender));
            message.setRecipient(Message.RecipientType.TO,new InternetAddress(recpient));
            message.setSubject("Lets Verify Your Account Creation Portal");
          /*  Random rand = new Random();
        HashSet<Integer> set = new HashSet<>();
        while(set.size()< 1){
            int random=rand.nextInt(999999) + 10;
            set.add(random);
            
        }for (int randomNumber:set){
            System.out.println("Here is you verification number: " + randomNumber); */
            message.setText("Thank you for registering. Here is you verification number: " + confirmationCode);
      //  }
           // message.setText("This is a Test mail" + randomNumber);
            
            return message;
        } catch (Exception ex) {
            Logger.getLogger(Email_Engine.class.getName()).log(Level.SEVERE, null, ex);
        }    
    return null;
    }  
}    

    

    /**
     * Instance and Field variables
     */
    /**
     * Constructors
     
    public Email_Engine() {
    }

    /**
     * Getters
     */
    /**
     * Setters
     */
    /**
     * Methods
     
    public void sendTheEmail() {
    }
}
*/