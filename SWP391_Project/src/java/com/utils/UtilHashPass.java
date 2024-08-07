/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utils;

import java.security.MessageDigest;
//import org.apache.tomcat.util.codec.binary.Base64; //Netbeans
//import org.apache.commons.codec.binary.Base64; //Intellij
import java.util.Base64;

/**
 * @author WuanTun
 */
public class UtilHashPass {

    public static String EncodePassword(String password) {
        String salt = "abc@@@defgh;12345"; // Static salt for complexity
        String result = null;
        password = password + salt;
        try {
            byte[] dataBytes = password.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] hashBytes = md.digest(dataBytes);
            result = Base64.getEncoder().encodeToString(hashBytes);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        System.out.println("Password: " + password); // Debugging line
        System.out.println("Hashed Password: " + result); // Debugging line
        return result;
    }

//    public static void main(String[] args) {
//        String password = "tientien1";
//        String hashpass = EncodePassword(password);
//        System.out.println(hashpass);
//    }

}
