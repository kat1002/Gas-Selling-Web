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

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Product {

    private int productId;
    private int categoryId;
    private int discountId;
    private int reviewsRate;
    private String title;
    private String description;
    private int stock;
    private float price;
    private Date createdDate;
    private Date modifiedOn;
    private int createdBy;
    private int modifiedBy;
    private int warranty_months;
    private List<String> images;

    // Constructor
    public Product(int productId, int categoryId, int discountId, int reviewsRate, String title, String description,
                   int stock, float price, Date createdDate, Date modifiedOn, int createdBy, int modifiedBy) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.discountId = discountId;
        this.reviewsRate = reviewsRate;
        this.title = title;
        this.description = description;
        this.stock = stock;
        this.price = price;
        this.createdDate = createdDate;
        this.modifiedOn = modifiedOn;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        images = new ArrayList<String>();
    }

    public Product(int productId, int categoryId, int discountId, int reviewsRate, String title, String description, int stock, float price, Date createdDate, Date modifiedOn, int createdBy, int modifiedBy, int warranty_months, List<String> images) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.discountId = discountId;
        this.reviewsRate = reviewsRate;
        this.title = title;
        this.description = description;
        this.stock = stock;
        this.price = price;
        this.createdDate = createdDate;
        this.modifiedOn = modifiedOn;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        this.warranty_months = warranty_months;
        images = new ArrayList<String>();
    }

    public Product(int productId, int categoryId, int discountId, int reviewsRate, String title, String description, int stock, float price, Date createdDate, Date modifiedOn, int createdBy, int modifiedBy, int warranty_months) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.discountId = discountId;
        this.reviewsRate = reviewsRate;
        this.title = title;
        this.description = description;
        this.stock = stock;
        this.price = price;
        this.createdDate = createdDate;
        this.modifiedOn = modifiedOn;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        this.warranty_months = warranty_months;
    }
    
    
    

    // Default Constructor
    public Product() {
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getDiscountId() {
        return discountId;
    }

    public String getCategory() throws SQLException, ClassNotFoundException {
        return WebManager.getInstance().categoryDAO.getCategory(categoryId).getTitle();
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public int getReviewsRate() {
        return reviewsRate;
    }

    public void setReviewsRate(int reviewsRate) {
        this.reviewsRate = reviewsRate;
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

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
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

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public int getWarranty_months() {
        return warranty_months;
    }

    public void setWarranty_months(int warranty_months) {
        this.warranty_months = warranty_months;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", categoryId=" + categoryId + ", discountId=" + discountId + ", reviewsRate=" + reviewsRate + ", title=" + title + ", description=" + description + ", stock=" + stock + ", price=" + price + ", createdDate=" + createdDate + ", modifiedOn=" + modifiedOn + ", createdBy=" + createdBy + ", modifiedBy=" + modifiedBy + ", warranty_months=" + warranty_months + ", images=" + images + '}';
    }
    
    
}
