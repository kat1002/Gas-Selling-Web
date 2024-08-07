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
import java.time.format.DateTimeFormatter;

public class Discount {
    private int discountId;
    private int productId;
    private String title;
    private String description;
    private float discountValue;
    private int createdBy;
    private int modifiedBy;
    private Date createdAt;
    private Date modifiedAt;
    private LocalDateTime expiry;
    private boolean status;

    public Discount() {}

    public Discount(int discountId, int productId, String title, String description, float discountValue, int createdBy, int modifiedBy, Date createdAt, Date modifiedAt, LocalDateTime expiry, boolean status) {
        this.discountId = discountId;
        this.productId = productId;
        this.title = title;
        this.description = description;
        this.discountValue = discountValue;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.expiry = expiry;
        this.status = status;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(float discountValue) {
        this.discountValue = discountValue;
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

    public Date getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(Date modifiedAt) {
        this.modifiedAt = modifiedAt;
    }

    public LocalDateTime getExpiry() {
        return expiry;
    }

    public void setExpiry(LocalDateTime expiry) {
        this.expiry = expiry;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public void checkAndUpdateStatus() {
        if (expiry != null && expiry.isBefore(LocalDateTime.now())) {
            setStatus(false); // Cập nhật trạng thái sang false nếu đã hết hạn
        }
    }
    
    public String getFormattedExpiry() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return this.getExpiry().format(formatter);
    }

    @Override
    public String toString() {
        return "Discount{" + 
                "discountId=" + discountId + 
                ", productId=" + productId + 
                ", title=" + title + 
                ", description=" + description + 
                ", discountValue=" + discountValue + 
                ", createdBy=" + createdBy + 
                ", modifiedBy=" + modifiedBy + 
                ", createdAt=" + createdAt + 
                ", modifiedAt=" + modifiedAt + 
                ", expiry=" + expiry + 
                ", status=" + status + '}';
    }
    
}
