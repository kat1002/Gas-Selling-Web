/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * @author kat1002
 */
public class ProductSerialNumber {
    private int serialNumberId;
    private int orderItemId;
    private String serviceTag;
    private int productId;

    // Constructors
    public ProductSerialNumber() {
        // Default constructor
    }

//    public ProductSerialNumber(int serialNumberId, int productId, String serviceTag) {
//        this.serialNumberId = serialNumberId;
//        this.productId = productId;
//        this.serviceTag = serviceTag;
//    }
//
//    public ProductSerialNumber(int serialNumberId, int productId, String serviceTag, boolean status) {
//        this.serialNumberId = serialNumberId;
//        this.productId = productId;
//        this.serviceTag = serviceTag;
//        this.status = status;
//    }
//
//    public ProductSerialNumber(int serialNumberId, int orderItemId, int productId, String serviceTag, Date guarantee_date, Date expiry, boolean status) {
//        this.serialNumberId = serialNumberId;
//        this.orderItemId = orderItemId;
//        this.productId = productId;
//        this.serviceTag = serviceTag;
//        this.guarantee_date = guarantee_date;
//        this.expiry = expiry;
//        this.status = status;
//    }
//
    public ProductSerialNumber(int productId) {
        this.productId = productId;
        this.serviceTag = generateServiceTag(productId);
    }

    public ProductSerialNumber(int serialNumberId, int orderItemId,int productId, String serviceTag) {
        this.serialNumberId = serialNumberId;
        this.orderItemId = orderItemId;
        this.serviceTag = serviceTag;
        this.productId = productId;
    }

    

    // Getters and Setters
    public int getSerialNumberId() {
        return serialNumberId;
    }

    public void setSerialNumberId(int serialNumberId) {
        this.serialNumberId = serialNumberId;
    }

    public String getServiceTag() {
        return serviceTag;
    }

    public void setServiceTag(String serviceTag) {
        this.serviceTag = serviceTag;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }


    private String generateServiceTag(int productId) {
        String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String randomStr = generateRandomString(8); // Generate a random alphanumeric string of length 16
        return productId + "x" + dateStr + "x" + randomStr;
    }

    private String generateRandomString(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder randomString = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            randomString.append(characters.charAt(random.nextInt(characters.length())));
        }
        return randomString.toString();
    }

    @Override
    public String toString() {
        return "ProductSerialNumber{" + "serialNumberId=" + serialNumberId + ", orderItemId=" + orderItemId + ", serviceTag=" + serviceTag + ", productId=" + productId + '}';
    }
    
}
