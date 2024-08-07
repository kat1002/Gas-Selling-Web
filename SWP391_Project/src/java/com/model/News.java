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

public class News {
    private int newsId;
    private String theme_image;
    private String short_description;
    private String title;
    private String body;
    private Date createdAt;
    private Date modifiedOn;
    private int createdBy;
    private int modifiedBy;
    private int banner;
    private String newsCategory;

    public News() {}

    public News(int newsId, String theme_image, String short_description, String title, String body, Date createdAt, Date modifiedOn, int createdBy, int modifiedBy, int banner, String newsCategory) {
        this.newsId = newsId;
        this.theme_image = theme_image;
        this.short_description = short_description;
        this.title = title;
        this.body = body;
        this.createdAt = createdAt;
        this.modifiedOn = modifiedOn;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
        this.banner = banner;
        this.newsCategory = newsCategory;
    }

    
    

    public String getTheme_image() {
        return theme_image;
    }

    public void setTheme_image(String theme_image) {
        this.theme_image = theme_image;
    }

    public String getShort_description() {
        return short_description;
    }

    public void setShort_description(String short_description) {
        this.short_description = short_description;
    }  

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
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

    public int getBanner() {
        return banner;
    }

    public void setBanner(int banner) {
        this.banner = banner;
    }

    public String getNewsCategory() {
        return newsCategory;
    }

    public void setNewsCategory(String newsCategory) {
        this.newsCategory = newsCategory;
    }

    
    @Override
    public String toString() {
        return "News{" +
                "newsId=" + newsId +
                ", title='" + title + '\'' +
                ", body='" + body + '\'' +
                ", createdAt=" + createdAt +
                ", modifiedOn=" + modifiedOn +
                ", createdBy=" + createdBy +
                ", modifiedBy=" + modifiedBy +
                '}';
    }
}

