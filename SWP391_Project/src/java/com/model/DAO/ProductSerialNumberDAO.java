/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.model.ProductSerialNumber;
import com.utils.DBContext;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Date;

/**
 * DAO class for ProductSerialNumber
 */
public class ProductSerialNumberDAO {

    // Insert a new ProductSerialNumber into the database
    public void insert(ProductSerialNumber psn) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBContext.getConnection();
            String sql = "INSERT INTO product_serialnumber (order_item_id, product_id, service_tag) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            if (psn.getOrderItemId() == 0) {
                stmt.setNull(1, psn.getOrderItemId());
            } else {
                stmt.setInt(1, psn.getOrderItemId());
            }

            stmt.setInt(2, psn.getProductId());
            stmt.setString(3, psn.getServiceTag());
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Inserting product serial number failed, no rows affected.");
            }

            generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                psn.setSerialNumberId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Inserting product serial number failed, no ID obtained.");
            }
        } finally {
            if (generatedKeys != null) {
                generatedKeys.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public ProductSerialNumber getById(int serialNumberId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT * FROM product_serialnumber WHERE serialNumber_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, serialNumberId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new ProductSerialNumber(
                        rs.getInt("serialNumber_id"),
                        rs.getInt("order_item_id"),
                        rs.getInt("product_id"),
                        rs.getString("service_tag")
                );
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public List<ProductSerialNumber> getAll() throws SQLException, ClassNotFoundException {
        List<ProductSerialNumber> serialNumbers = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT serialNumber_id, order_item_id, product_id, service_tag FROM product_serialnumber";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                serialNumbers.add(new ProductSerialNumber(
                        rs.getInt("serialNumber_id"),
                        rs.getInt("order_item_id"),
                        rs.getInt("product_id"),
                        rs.getString("service_tag")
                ));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return serialNumbers;
    }

    public List<ProductSerialNumber> getListSerialByOrderItemId(int id) throws SQLException {
        String sql = "SELECT serialNumber_id, order_item_id, product_id, service_tag FROM product_serialnumber WHERE order_item_id = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<ProductSerialNumber> PSNs = new ArrayList<>();
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PSNs.add(new ProductSerialNumber(
                        resultSet.getInt("serialNumber_id"),
                        resultSet.getInt("order_item_id"),
                        resultSet.getInt("product_id"),
                        resultSet.getString("service_tag")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return PSNs;
    }

    public List<ProductSerialNumber> getListSerialByProductId(int id) throws SQLException {
        String sql = "SELECT serialNumber_id, order_item_id, product_id, service_tag FROM product_serialnumber WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<ProductSerialNumber> PSNs = new ArrayList<>();
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PSNs.add(new ProductSerialNumber(
                        resultSet.getInt("serialNumber_id"),
                        resultSet.getInt("order_item_id"),
                        resultSet.getInt("product_id"),
                        resultSet.getString("service_tag")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return PSNs;
    }

    public List<ProductSerialNumber> getListTopSerialByProductId(int id, int top) throws SQLException {
        String sql = "SELECT TOP " + top + " serialNumber_id, order_item_id, product_id, service_tag FROM product_serialnumber WHERE product_id = ? and order_item_id IS NULL";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<ProductSerialNumber> PSNs = new ArrayList<>();
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PSNs.add(new ProductSerialNumber(
                        resultSet.getInt("serialNumber_id"),
                        resultSet.getInt("order_item_id"),
                        resultSet.getInt("product_id"),
                        resultSet.getString("service_tag")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return PSNs;
    }

    public List<ProductSerialNumber> getListSerialByProductAndOrderItem(int productid, int orderitemid) throws SQLException {
        String sql = "SELECT [serialNumber_id]\n"
                + "      ,[order_item_id]\n"
                + "      ,[product_id]\n"
                + "      ,[service_tag]\n"
                + "  FROM [dbo].[product_serialnumber] WHERE [product_id] = ? AND [order_item_id] = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<ProductSerialNumber> PSNs = new ArrayList<>();
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, productid);
            statement.setInt(2, orderitemid);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PSNs.add(new ProductSerialNumber(
                        resultSet.getInt("serialNumber_id"),
                        resultSet.getInt("order_item_id"),
                        resultSet.getInt("product_id"),
                        resultSet.getString("service_tag")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return PSNs;
    }

    public void update(ProductSerialNumber psn) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE product_serialnumber\n"
                    + "   SET order_item_id = ?,\n"
                    + "       product_id = ?,\n"
                    + "       service_tag = ?\n"
                    + " WHERE serialNumber_id = ?";
            stmt = conn.prepareStatement(sql);
            if (psn.getOrderItemId() == 0) {
                stmt.setNull(1, psn.getOrderItemId());
            } else {
                stmt.setInt(1, psn.getOrderItemId());
            }
            stmt.setInt(2, psn.getProductId());
            stmt.setString(3, psn.getServiceTag());
            stmt.setInt(4, psn.getSerialNumberId());
            stmt.executeUpdate();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void delete(int serialNumberId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection();
            String sql = "DELETE FROM product_serialnumber WHERE serialNumber_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, serialNumberId);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public boolean deleteProductSerialByProductId(int productid) throws SQLException {
        String sql = "DELETE FROM [dbo].[product_serialnumber]\n"
                + "      WHERE [product_id] = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        boolean rowDeleted = false;
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, productid);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn);
            }
        }
        return rowDeleted;
    }

//    public static void main(String[] args) throws SQLException {
//        for (ProductSerialNumber psn : new ProductSerialNumberDAO().getListTopSerialByProductId(1, 5)){
//            System.out.println(psn);
//        }
//        for (ProductSerialNumber psn : new ProductSerialNumberDAO().getListSerialByOrderItemId(2)){
//            System.out.println(psn);
//        }
//    }
    public ProductSerialNumber getSerialNumberByServiceTag(String serviceTag) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT * FROM product_serialnumber WHERE service_tag = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, serviceTag);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new ProductSerialNumber(
                        rs.getInt("serialNumber_id"),
                        rs.getInt("order_item_id"),
                        rs.getInt("product_id"),
                        rs.getString("service_tag")
                );
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }
}
