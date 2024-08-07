/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.controller.product_detail.ProductDetailServlet;
import com.model.Inventory;
import com.utils.DBContext;
import com.model.InventoryItem;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class InventoryDAO extends DBContext {

    public Inventory getInventoryById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT [inventory_id]\n"
                + "      ,[customer_id]\n"
                + "  FROM [dbo].[inventory] WHERE [inventory_id] = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Inventory(rs.getInt("inventory_id"), rs.getInt("customer_id"));
            }
        } catch (Exception ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return null;
    }

    public Inventory getInventoryByCustomerId(int customer_id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT [inventory_id]\n"
                + "      ,[customer_id]\n"
                + "  FROM [dbo].[inventory]\n"
                + "  WHERE [customer_id] = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customer_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Inventory(rs.getInt("inventory_id"), rs.getInt("customer_id"));
            }
        } catch (Exception ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return null;
    }

    public void createInventory(int customer_id) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO [dbo].[inventory]\n"
                + "           ([customer_id])\n"
                + "     VALUES\n"
                + "           (?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customer_id);
            ps.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        System.out.println(new InventoryDAO().getInventoryByCustomerId(2));
    }
}
