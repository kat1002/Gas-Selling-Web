/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author kat1002
 */
public class Cart {
    private int cartId;
    private int userId;
    private float total;

    public Cart() {
    }

    public Cart(int cartId, int userId, float total) {
        this.cartId = cartId;
        this.userId = userId;
        this.total = total;
    }

    public Cart(int cartId, int userId) {
        this.cartId = cartId;
        this.userId = userId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartId=" + cartId +
                ", userId=" + userId +
                ", total=" + total +
                '}';
    }
}

