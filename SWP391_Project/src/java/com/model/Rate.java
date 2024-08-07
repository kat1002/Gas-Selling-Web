/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import com.controller.WebManager;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Acer Nitro 5
 */
public class Rate {

    private int rate_id;
    private int customer_id;
    private int product_id;
    private int rate;
    private String comment;
    private LocalDateTime created_on;
    private LocalDateTime modified_on;

    public Rate() {
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreated_on() {
        return created_on;
    }

    public void setCreated_on(LocalDateTime created_on) {
        this.created_on = created_on;
    }

    public LocalDateTime getModified_on() {
        return modified_on;
    }

    public void setModified_on(LocalDateTime modified_on) {
        this.modified_on = modified_on;
    }

    public Rate(int customer_id, int product_id, int rate) {
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.rate = rate;
    }

    public Rate(int customer_id, int product_id, int rate, String comment) {
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.rate = rate;
        this.comment = comment;
    }

    public Rate(int customer_id, int product_id, int rate, String comment, LocalDateTime created_on, LocalDateTime modified_on) {
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.rate = rate;
        this.comment = comment;
        this.created_on = created_on;
        this.modified_on = modified_on;
    }

    public Rate(int rate_id, int customer_id, int product_id, int rate, String comment, LocalDateTime created_on, LocalDateTime modified_on) {
        this.rate_id = rate_id;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.rate = rate;
        this.comment = comment;
        this.created_on = created_on;
        this.modified_on = modified_on;
    }

    public String getFormattedModifiedOn() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return this.getModified_on().format(formatter);
    }
    
    public String getFormattedCreatedOn() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return this.getModified_on().format(formatter);
    }

    public int getRate_id() {
        return rate_id;
    }

    public void setRate_id(int rate_id) {
        this.rate_id = rate_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    @Override
    public String toString() {
        return "Rate{" + "rate_id=" + rate_id + ", customer_id=" + customer_id + ", product_id=" + product_id + ", rate=" + rate + '}';
    }

    public Customer getCustomerById(int id) throws ClassNotFoundException, SQLException {
        Customer c = WebManager.getInstance().customerDAO.getCustomer(id);
        return c;
    }
    
    public Product getProductById(int id) throws ClassNotFoundException, SQLException {
        Product p = WebManager.getInstance().productDAO.getProduct(id);
        return p;
    }

}
