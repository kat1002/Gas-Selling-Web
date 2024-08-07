/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author ADMIN
 */
public class Inventory {
    private int inventoryId;
    private int customerId;
    public Inventory(){
        
    }

    public Inventory(int inventoryId, int customerId) {
        this.inventoryId = inventoryId;
        this.customerId = customerId;
    }

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Override
    public String toString() {
        return "Inventory{" + "inventoryId=" + inventoryId + ", customerId=" + customerId + '}';
    }
    
}
