/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import javax.mail.Session;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
//import javax.mail.internet.MimeMessage;
//import javax.mail.internet.AddressException;


/*
import java.util.*; 
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*; 
import javax.mail.internet.*; 
import javax.activation.*; 
import javax.mail.Session; 
import javax.mail.Transport;
import sun.util.logging.PlatformLogger;*/

/**
 *
 * @author isaac
 */
public class createEmail {
    
    




    public static void sendMail(String recpient) throws Exception {
        
        
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
    
    
    Message message = prepareMessage(session, sender, recpient);
    
    Transport.send(message);
    System.out.println("Message sent successfully!");
    
    
    }
    
    private static Message prepareMessage(Session session, String sender, String recpient) throws MessagingException{
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(sender));
            message.setRecipient(Message.RecipientType.TO,new InternetAddress(recpient));
            message.setSubject("This is the Subject");
            message.setText("This is a Test mail");
            return message;
        } catch (Exception ex) {
            Logger.getLogger(createEmail.class.getName()).log(Level.SEVERE, null, ex);
        }    
    return null;
    }  
}    

    
    
    
    
    

       /* message.setFrom(new InternetAddress(sender));
        message.setRecipient(Message.RecipientType.TO,new InternetAddress(recipient));
        message.setSubject("This is the Subject");
        message.setText("This is a Test mail");
        return message;
    }catch (Exception ex){
        Logger.getLogger(createEmail.class.getName()).log(Level.SEVERE, null, ex);
        
    }    
    return null;
    }
}
    

   /* 
    try
    {
        MimeMessage message = new MimeMessage(session);
        
        message.setFrom(new InternetAddress(sender));
        
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        
        message.setSubject("This is Subject");
        
        message.setText("This is a test mail");
        
        Transport.send(message);
        System.out.println("Mail Successfully Sent!");
        
    }
    catch (MessagingException mex)
    {
            mex.printStackTrace();

    }
    }
    }
    */

