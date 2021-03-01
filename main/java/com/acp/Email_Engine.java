
/** Purpose: Hold the class controlling the email service
 *  UMGC CMSC 495 Special Topics
 *  Developer: Team 1
 *  Date: February 12, 2021
 */
// import statements
import java.util.*; 
import javax.mail.*; 
import javax.mail.internet.*; 
import javax.activation.*; 
import javax.mail.Session; 
import javax.mail.Transport;


public class Email_Engine {
    
     public static void main(String [] args)
    {
        String recipent = "inyarko1@student.umuc.edu";
        
        String sender = "accountcreation495@yahoo.com";
        
        String host = "127.0.0.1";
        
        Properties properties = System.getProperties();
        
        properties.setProperty("smtp.mail.yahoo.com", host);
        
    }Session session = Session.getDefaultInstance(properties);
    
    
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
    }

    mex.printStackTrace();

  }
}
}

    /**
     * Instance and Field variables
     */
    /**
     * Constructors
     */
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
     */
    public void sendTheEmail() {
    }
}