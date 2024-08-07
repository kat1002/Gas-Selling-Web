/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controller;

import com.model.DAO.*;
import com.model.Order;

import java.sql.SQLException;

/**
 *
 * @author kat1002
 */
public class WebManager {

    public ProductDAO productDAO;
    public CategoryDAO categoryDAO;
    public CustomerDAO customerDAO;
    public CartDAO cartDAO;
    public CartItemDAO cartItemDAO;
    public ManagerDAO managerDAO;
    public OrderDAO orderDAO;
    public OrderItemDAO orderItemDAO;
    public DiscountDAO discountDAO;
    public ProductSerialNumberDAO productSerialNumberDAO; 
    public RateDAO rateDAO;
    public VoucherDAO voucherDAO;
    public headerDAO headerDAO;
    public footerDAO footerDAO;
    public InventoryDAO inventoryDAO;
    public InventoryItemDAO inventoryItemDAO;

    private static WebManager instance;

    private WebManager() throws SQLException, ClassNotFoundException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        customerDAO = new CustomerDAO();
        cartDAO = new CartDAO();
        cartItemDAO = new CartItemDAO();
        managerDAO = new ManagerDAO();
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        discountDAO = new DiscountDAO();
        productSerialNumberDAO = new ProductSerialNumberDAO();
        rateDAO = new RateDAO();
        voucherDAO = new VoucherDAO();
        headerDAO = new headerDAO();
        footerDAO = new footerDAO();
        inventoryDAO = new InventoryDAO();
        inventoryItemDAO = new InventoryItemDAO();
    }

    public static WebManager getInstance() throws SQLException, ClassNotFoundException {
        if (instance == null) {
            instance = new WebManager();
        }
        return instance;
    }

  
}
