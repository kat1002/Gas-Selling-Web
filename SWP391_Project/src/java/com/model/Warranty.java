/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author kirit
 */
public class Warranty {
    private int warrantyId;
    private int serialNumberId;
    private int managerId;
    private int warrantyType;
    private Date guaranteeDate;
    private String status;
    private boolean isDone;
    private String images;
    private Date createdAt;
    private Date modifiedAt;
    private int createdBy;
    private int modifiedBy;

    // Constructor
    public Warranty() {}

    public Warranty(int warrantyId, int serialNumberId, int managerId, int warrantyType, Date guaranteeDate, String status, boolean isDone, String images, Date createdAt, Date modifiedAt, int createdBy, int modifiedBy) {
        this.warrantyId = warrantyId;
        this.serialNumberId = serialNumberId;
        this.managerId = managerId;
        this.warrantyType = warrantyType;
        this.guaranteeDate = guaranteeDate;
        this.status = status;
        this.isDone = isDone;
        this.images = images;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
    }    

    // Getters and Setters
    public int getWarrantyId() {
        return warrantyId;
    }

    public void setWarrantyId(int warrantyId) {
        this.warrantyId = warrantyId;
    }

    public int getSerialNumberId() {
        return serialNumberId;
    }

    public void setSerialNumberId(int serialNumberId) {
        this.serialNumberId = serialNumberId;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public int getWarrantyType() {
        return warrantyType;
    }

    public void setWarrantyType(int warrantyType) {
        this.warrantyType = warrantyType;
    }

    public Date getGuaranteeDate() {
        return guaranteeDate;
    }

    public void setGuaranteeDate(Date guaranteeDate) {
        this.guaranteeDate = guaranteeDate;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isIsDone() {
        return isDone;
    }

    public void setIsDone(boolean isDone) {
        this.isDone = isDone;
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
}
