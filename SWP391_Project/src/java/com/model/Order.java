/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author kat1002
 */
import com.controller.WebManager;
import java.sql.Date;
import java.sql.SQLException;


public class Order {
    private int orderId;
    private int customerId;
    private int voucherId;
    private double totalPrice;
    private Date orderDate;
    private int paymentMethod;
    private String addressLine1;
    private String addressLine2;
    private String postalCode;
    private String city;
    private String phoneNumber;
    private Date createdAt;
    private int status;

    // Constructors
    public Order() {
        // Default constructor
    }

    public Order(int orderId, int customerId, int voucherId, double totalPrice, Date orderDate, int paymentMethod,
                 String addressLine1, String addressLine2, String postalCode, String city, String phoneNumber, Date createdAt, int status) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.voucherId = voucherId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.paymentMethod = paymentMethod;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.postalCode = postalCode;
        this.city = city;
        this.phoneNumber = phoneNumber;
        this.createdAt = createdAt;
        this.status = status;
    }

    public Order(int customerId, int voucherId, double totalPrice, Date orderDate, int paymentMethod,
                 String addressLine1, String addressLine2, String postalCode, String city, String phoneNumber, Date createdAt, int status) {
        this.customerId = customerId;
        this.voucherId = voucherId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.paymentMethod = paymentMethod;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.postalCode = postalCode;
        this.city = city;
        this.phoneNumber = phoneNumber;
        this.createdAt = createdAt;
        this.status = status;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(int paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentMethodName() {
        return paymentMethod == 1 ? "QR code" : "Online payment";
    }
    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    public Customer getCustomer() throws SQLException, ClassNotFoundException{
        return WebManager.getInstance().customerDAO.getCustomer(this.getCustomerId());
    }
    
    public Voucher getVoucher() throws SQLException, ClassNotFoundException{
        return WebManager.getInstance().voucherDAO.getVoucher(this.getVoucherId());
    }

    // toString method (optional)

    @Override
    public String toString() {
        return "Order{" + 
                "orderId=" + orderId + ", "
                + "customerId=" + customerId + ", "
                + "voucherId=" + voucherId + ", "
                + "totalPrice=" + totalPrice + ", "
                + "orderDate=" + orderDate + ", "
                + "paymentMethod=" + paymentMethod + ", "
                + "addressLine1=" + addressLine1 + ", "
                + "addressLine2=" + addressLine2 + ", "
                + "postalCode=" + postalCode + ", "
                + "city=" + city + ", "
                + "phoneNumber=" + phoneNumber + ", "
                + "createdAt=" + createdAt + ", "
                + "status=" + status + '}';
    }
    
}
