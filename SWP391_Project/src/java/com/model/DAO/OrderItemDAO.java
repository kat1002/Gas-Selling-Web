/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

/**
 * @author kat1002
 */
import com.model.OrderItem;
import com.utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderItemDAO {

    private static final Logger logger = Logger.getLogger(OrderItemDAO.class.getName());

    public boolean insert(OrderItem orderItem) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

//            String sql = "INSERT INTO order_item (order_id, product_id, service_tag, guarantee_date, quantity, price) VALUES (?, ?, ?, ?, ?, ?)";
            String sql = "INSERT INTO order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            // Log giá trị được set vào PreparedStatement
            System.out.println("Inserting OrderItem: " + orderItem);

            stmt.setInt(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getProductId());
//            stmt.setString(3, getServiceTag(orderItem.getProductId())); // Assuming getServiceTag is a method to fetch service tag
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setDouble(4, orderItem.getPrice());

            // Log giá trị đã set vào PreparedStatement
            System.out.println("PreparedStatement values: ");
            System.out.println("Order ID: " + orderItem.getOrderId());
            System.out.println("Product ID: " + orderItem.getProductId());
//            System.out.println("Service Tag: " + getServiceTag(orderItem.getProductId()));
            System.out.println("Quantity: " + orderItem.getQuantity());
            System.out.println("Price: " + orderItem.getPrice());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating order item failed, no rows affected.");
            }

            // Retrieve auto-generated keys (orderItemId)
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return true; // Indicate that the insert was successful
            } else {
                throw new SQLException("Creating order item failed, no ID obtained.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Log the exception
            e.printStackTrace(); // Thêm dòng này để in chi tiết lỗi ra console
            logger.log(Level.SEVERE, "Error occurred while inserting order item", e);
            return false; // Indicate that the insert failed
        } finally {
            // Close resources in finally block
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Failed to close ResultSet", e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Failed to close PreparedStatement", e);
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Failed to close Connection", e);
                }
            }
        }
    }

    public void add(OrderItem orderItem) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "INSERT INTO [dbo].[order_item]\n"
                + "           ([order_id]\n"
                + "           ,[product_id]\n"
                + "           ,[quantity]\n"
                + "           ,[price])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?)";
        try{
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getProductId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getPrice());
            ps.executeUpdate();
        }catch (SQLException ex){
            ex.printStackTrace();
        }finally{
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Failed to close PreparedStatement", e);
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Failed to close Connection", e);
                }
            }
        }
    }

    // Read: Fetch all OrderItems for a specific order from the database
    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<OrderItem> orderItems = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

            String sql = "SELECT order_item_id FROM order_item WHERE order_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);

            rs = stmt.executeQuery();

            while (rs.next()) {
                orderItems.add(getOrderItemById(rs.getInt("order_item_id")));
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

        return orderItems;
    }

    // Read: Fetch a specific OrderItem by its ID
    public OrderItem getOrderItemById(int orderItemId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

            String sql = "SELECT * FROM order_item WHERE order_item_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderItemId);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return new OrderItem(
                        rs.getInt("order_item_id"),
                        rs.getInt("order_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("price")
                );
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return null;
    }

    // Update: Update an existing OrderItem in the database
    public void update(OrderItem orderItem) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

            String sql = "UPDATE order_item SET order_id = ?, product_id = ?, quantity = ?, price = ? "
                    + "WHERE order_item_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getProductId());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setDouble(4, orderItem.getPrice());
            stmt.setInt(5, orderItem.getOrderItemId());

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

    // Delete: Delete an OrderItem from the database
    public void delete(int orderItemId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

            String sql = "DELETE FROM order_item WHERE order_item_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderItemId);

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

    public void deleteOrderItemByProductId(int productid) {
        String sql = "DELETE FROM order_item WHERE product_id = ?";
        Connection conn = null; // Declare the connection outside the try block
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            PreparedStatement stmt = conn.prepareStatement(sql); // Prepare the statement
            stmt.setInt(1, productid); // Set parameter value
            stmt.executeUpdate(); // Execute the update
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            DBContext.closeConnection(conn); // Close the connection
        }
    }

    public void deleteOrderItemByOrderId(int orderid) {
        String sql = "DELETE FROM order_item WHERE order_id = ?";
        Connection conn = null; // Declare the connection outside the try block
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            PreparedStatement stmt = conn.prepareStatement(sql); // Prepare the statement
            stmt.setInt(1, orderid); // Set parameter value
            stmt.executeUpdate(); // Execute the update
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            DBContext.closeConnection(conn); // Close the connection
        }
    }

    // Method to fetch a service tag that does not exist in order_items for a given product ID
    public String getServiceTag(int productId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String serviceTag = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method

            // Query to get a service tag from product_serialnumber that does not exist in order_items
            String sql = "SELECT TOP 1 psn.service_tag FROM product_serialnumber psn \" +\n"
                    + "                     \"LEFT JOIN order_item oi ON psn.order_item_id = oi.order_item_id AND oi.product_id = ? \" +\n"
                    + "                     \"WHERE psn.product_id = ? AND psn.service_tag IS NULL"; // Retrieve one random service tag

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.setInt(2, productId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("service_tag");
            }

        } finally {
            // Close resources
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return null;
    }
    
    public int countNumberOfProductSold(int product_id) throws SQLException, ClassNotFoundException{
        String sql = "SELECT [product_id], SUM([quantity]) AS total_sold FROM [dbo].[order_item] WHERE [product_id] = ? GROUP BY [product_id]";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, product_id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_sold");
            }
        } catch (Exception ex){
            ex.printStackTrace();
        }finally {
            // Close resources
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null){
                DBContext.closeConnection(conn);
            }
        }
        return 0;
    }

}
