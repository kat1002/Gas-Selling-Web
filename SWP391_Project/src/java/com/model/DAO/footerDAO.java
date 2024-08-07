/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.model.Category;
import com.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
public class footerDAO {
    private static final Logger LOGGER = Logger.getLogger(DiscountDAO.class.getName());

    public List<Category> getFooterItem() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM category WHERE role < 0 AND role NOT LIKE '%0%' ORDER BY role DESC";
                try (PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
                    while (rs.next()) {
                        Category c = new Category(
                                rs.getInt("category_id"),
                                rs.getString("title"),
                                rs.getString("description"),
                                rs.getDate("created_date"),
                                rs.getDate("modified_on"),
                                rs.getInt("created_by"),
                                rs.getInt("modified_by"),
                                rs.getInt("role")
                        );
                        categories.add(c);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting footer items", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return categories;
    }


    public List<Category> getFooterContent() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM category WHERE role < 0 AND role LIKE '%0%' ORDER BY role DESC";
                try (PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
                    while (rs.next()) {
                        Category c = new Category(
                                rs.getInt("category_id"),
                                rs.getString("title"),
                                rs.getString("description"),
                                rs.getDate("created_date"),
                                rs.getDate("modified_on"),
                                rs.getInt("created_by"),
                                rs.getInt("modified_by"),
                                rs.getInt("role")
                        );
                        categories.add(c);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting footer content", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return categories;
    }


    public static void main(String[] args) {
        footerDAO d = new footerDAO();
        List<Category> a = d.getFooterContent();
        for(Category t : a){
            System.out.println(t.getTitle());
        }
    }
}
