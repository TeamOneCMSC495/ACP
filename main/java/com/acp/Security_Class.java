package com.acp;


/** Purpose: Hold the class containing the application security features
 *  UMGC CMSC 495 Special Topics
 *  Developer: Team 1
 *  Date: February 12, 2021
 */
// import statements
import com.codahale.passpol.*;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;


public class Security_Class {

    /**
     * Instance and Field variables
     */
    /**
     * Constructors
     */
    //All methods are public static so a constructor is not called
    public Security_Class() {
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
    
//Class for testing passwords against minimum and maximum length and list of known
//breached passwords. Needs passpol dependency to run. Returns enumerated Status 
//of either "BREACHED", "TOO_SHORT", "TOO_LONG" or "OK". Passwords returning the 
//"OK" status are good to pass to the hashing algorithm.
    public static Status testPassword(String password) {
        BreachDatabase bdb = BreachDatabase.top100K();//Import database of breached passwords
        final PasswordPolicy policy = new PasswordPolicy(bdb, 8, 128);//create policy using breached passwords, min length = 8, max length = 128
        return policy.check(password);
    }//end passwordTest method
    
    
    public void performSalt() {
        //Not used. Salt is generated automatically in performHash
    }
    
    
    //returns string of password hash with salt include. Store exactly as returned.
    public static String performHash(String password) {
        Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id);//forces argon2id algorithm instead of default argon2i
        String hash = argon2.hash(4, 1024 * 1024, 8, password);//these parameters result in 1 gig of memory used to hash and takes approx 1 second on a pc
        return hash;
    }
    
    //check user's submitted password for login against stored hash retrieved from database
    //returns true if password matches hash, otherwise false
    public static Boolean checkCorrectPassword(String password, String hash){
        Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id);
        boolean success = argon2.verify(hash, password);
        return success;
    }
    
//    public static void main(String args[]){
//        System.out.println("security class compiled");
//    }
}
