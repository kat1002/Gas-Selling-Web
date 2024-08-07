/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import com.controller.WebManager;
import java.sql.SQLException;

/**
 *
 * @author kat1002
 */
public class InventoryItem {
    private int itemId;
    private int inventoryId;
    private int voucherId;
    private int amount;

    public InventoryItem() {}

    public InventoryItem(int itemId, int inventoryId, int voucherId, int amount) {
        this.itemId = itemId;
        this.inventoryId = inventoryId;
        this.voucherId = voucherId;
        this.amount = amount;
    }
    
    public InventoryItem(int inventoryId, int voucherId, int amount) {
        this.inventoryId = inventoryId;
        this.voucherId = voucherId;
        this.amount = amount;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public Voucher getVoucherById(int id) throws SQLException, ClassNotFoundException{
        return WebManager.getInstance().voucherDAO.getVoucher(this.getVoucherId());
    }

    @Override
    public String toString() {
        return "InventoryItem{" +
                "itemId=" + itemId +
                ", inventoryId=" + inventoryId +
                ", voucherId=" + voucherId +
                ", amount=" + amount +
                '}';
    }
}

