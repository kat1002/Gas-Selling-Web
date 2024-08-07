/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author kat1002
 */
import java.util.Date;

public class Category {
    private int categoryId;
    private String title;
    private String description;
    private Date createdDate;
    private Date modifiedOn;
    private int createdBy;
    private int modifiedBy;
    private int role;

    public Category() {}

    public Category(int categoryId, String title, String description, Date createdDate, Date modifiedOn, int createdBy, int modifiedBy) {
        this.categoryId = categoryId;
        this.title = title;
        this.description = description;
        this.createdDate = createdDate;
        this.modifiedOn = modifiedOn;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
    }

    public Category(int categoryId, String title, String description, Date createdDate, Date modifiedOn, int createdBy, int modifiedBy, int role) {
        this.categoryId = categoryId;
        this.title = title;
        this.description = description;
        this.createdDate = createdDate;
        this.modifiedOn = modifiedOn;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        this.role = role;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(Date modifiedOn) {
        this.modifiedOn = modifiedOn;
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

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
    

    @Override
    public String toString() {
        return "Category{" +
                "categoryId=" + categoryId +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", role=" + role +
                ", createdDate=" + createdDate +
                ", modifiedOn=" + modifiedOn +
                ", createdBy=" + createdBy +
                ", modifiedBy=" + modifiedBy +
                '}';
    }
}

