/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author WuanTun
 */
public class Customer {

    private int customerId;
    private int customerType;
    private String username;
    private String password; 
    private String gmail;
    private String phone_number;
    private String first_name;
    private String last_name;
    private String address_line1;
    private String address_line2;
    private int postal_code;
    private String city;
    private String customerImage = "media/customerImage.jpg";
    private int receiveNotif;
   

    public Customer() {
    }

    public Customer(int customerId, int customerType, String username, String gmail, String phone_number, String first_name, String last_name, String address_line1, String address_line2, int postal_code, String city) {
        this.customerId = customerId;
        this.customerType = customerType;
        this.username = username;
        this.gmail = gmail;
        this.phone_number = phone_number;
        this.first_name = first_name;
        this.last_name = last_name;
        this.address_line1 = address_line1;
        this.address_line2 = address_line2;
        this.postal_code = postal_code;
        this.city = city;
    }

    public Customer(int customerType, String username, String gmail, String phone_number, String first_name, String last_name, String address_line1, String address_line2, int postal_code, String city) {
        this.customerType = customerType;
        this.username = username;
        this.gmail = gmail;
        this.phone_number = phone_number;
        this.first_name = first_name;
        this.last_name = last_name;
        this.address_line1 = address_line1;
        this.address_line2 = address_line2;
        this.postal_code = postal_code;
        this.city = city;
    }

    public Customer(int customerId, String username, String gmail, String phone_number, String first_name, String last_name, String address_line1) {
        this.customerId = customerId;
        this.username = username;
        this.gmail = gmail;
        this.phone_number = phone_number;
        this.first_name = first_name;
        this.last_name = last_name;
        this.address_line1 = address_line1;
    }

    public Customer(int customerId, int customerType, String username, String password, String gmail, String phone_number, String first_name, String last_name, String address_line1, String address_line2, int postal_code, String city,String customerImage, int receiveNotif) {
        this.customerId = customerId;
        this.customerType = customerType;
        this.username = username;
        this.password = password;
        this.gmail = gmail;
        this.phone_number = phone_number;
        this.first_name = first_name;
        this.last_name = last_name;
        this.address_line1 = address_line1;
        this.address_line2 = address_line2;
        this.postal_code = postal_code;
        this.city = city;
        this.customerImage = customerImage;
        this.receiveNotif = receiveNotif;
    }

    

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public int getId() {
        return customerId;
    }
    
    public int getCustomerType() {
        return customerType;
    }

    public void setCustomerType(int customerType) {
        this.customerType = customerType;
    }
    public String getName(){
        return first_name +" "+ last_name;
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getAddress_line1() {
        return address_line1;
    }

    public void setAddress_line1(String address_line1) {
        this.address_line1 = address_line1;
    }

    public String getAddress_line2() {
        return address_line2;
    }

    public void setAddress_line2(String address_line2) {
        this.address_line2 = address_line2;
    }

    public int getPostal_code() {
        return postal_code;
    }

    public void setPostal_code(int postal_code) {
        this.postal_code = postal_code;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCustomerImage() {
        return customerImage;
    }

    public void setCustomerImage(String customerImage) {
        this.customerImage = customerImage;
    }

    public int getReceiveNotif() {
        return receiveNotif;
    }

    public void setReceiveNotif(int receiveNotif) {
        this.receiveNotif = receiveNotif;
    }
    
    
    
    @Override
    public String toString() {
        return "Customer{" + "customerId=" + customerId + ", customerType=" + customerType + ", username=" + username + ", gmail=" + gmail + ", phone_number=" + phone_number + ", first_name=" + first_name + ", last_name=" + last_name + ", address_line1=" + address_line1 + ", address_line2=" + address_line2 + ", postal_code=" + postal_code + ", city=" + city + '}';
    }

}
