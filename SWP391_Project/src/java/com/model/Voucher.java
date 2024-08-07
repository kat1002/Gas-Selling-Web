/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author kat1002
 */
import java.time.LocalDateTime;
import java.sql.Date;

public class Voucher {

    private int voucherId;
    private String title;
    private String voucherCode;
    private String description;
    private int discountType;
    private float discountValue;
    private float condition;
    private int quantity;
    private int createdBy;
    private int modifiedBy;
    private Date createdAt;
    private Date modifiedOn;
//    private LocalDateTime expiry;
    private Date expiry;
    private boolean status;

    public Voucher() {
    }

//    public Voucher(int voucherId, String title, String voucherCode, String description, int discountType, float discountValue, float condition, int quantity, int createdBy, int modifiedBy, Date createdAt, Date modifiedOn, LocalDateTime expiry, boolean status) {
//        this.voucherId = voucherId;
//        this.title = title;
//        this.voucherCode = voucherCode;
//        this.description = description;
//        this.discountType = discountType;
//        this.discountValue = discountValue;
//        this.condition = condition;
//        this.quantity = quantity;
//        this.createdBy = createdBy;
//        this.modifiedBy = modifiedBy;
//        this.createdAt = createdAt;
//        this.modifiedOn = modifiedOn;
//        this.expiry = expiry;
//        this.status = status;
//    }
    public Voucher(int voucherId, String title, String voucherCode, String description, int discountType, float discountValue, float condition, int quantity, int createdBy, int modifiedBy, Date createdAt, Date modifiedOn, Date expiry, boolean status) {
        this.voucherId = voucherId;
        this.title = title;
        this.voucherCode = voucherCode;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.condition = condition;
        this.quantity = quantity;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        this.createdAt = createdAt;
        this.modifiedOn = modifiedOn;
        this.expiry = expiry;
        this.status = status;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDiscountType() {
        return discountType;
    }

    public void setDiscountType(int discountType) {
        this.discountType = discountType;
    }

    public float getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(float discountValue) {
        this.discountValue = discountValue;
    }

    public float getCondition() {
        return condition;
    }

    public void setCondition(float condition) {
        this.condition = condition;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public int getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(int modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(Date modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

//    public LocalDateTime getExpiry() {
//        return expiry;
//    }
//
//    public void setExpiry(LocalDateTime expiry) {
//        this.expiry = expiry;
//    }
    public Date getExpiry() {
        return expiry;
    }

    public void setExpiry(Date expiry) {
        this.expiry = expiry;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
