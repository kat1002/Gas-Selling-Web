package com.model.DAO;

import com.controller.WebManager;
import com.model.Customer;
import com.model.Order;
import com.model.Voucher;
import com.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO {

    private static final Logger logger = Logger.getLogger(OrderDAO.class.getName());

//    public boolean insert(Order order) throws SQLException, ClassNotFoundException {
//        //System.out.println(order);
//
//        Connection conn = null;
//        PreparedStatement stmt = null;
//        ResultSet generatedKeys = null;
//
//        try {
//            conn = DBContext.getConnection(); // Replace with your database connection method
//            String sql = "INSERT INTO [order] (customer_id, voucher_id, total_price, order_date, payment_method, address_line1, address_line2, postal_code, city, phone_number, created_at) VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, GETDATE())";
//
////            // Log the SQL statement with parameters
////            System.out.println("Executing SQL statement: " + sql);
////            System.out.println("Parameters:");
////            System.out.println("customer_id: " + order.getCustomerId());
////            System.out.println("voucher_id: " + ((order.getVoucherId() == 0) ? null : order.getVoucherId()));
////            System.out.println("total_price: " + order.getTotalPrice());
////            System.out.println("order_date: " + new java.sql.Date(order.getOrderDate().getTime()));
////            System.out.println("payment_method: " + order.getPaymentMethod());
////            System.out.println("address_line1: " + order.getAddressLine1());
////            System.out.println("address_line2: " + order.getAddressLine2());
////            System.out.println("postal_code: " + order.getPostalCode());
////            System.out.println("city: " + order.getCity());
////            System.out.println("phone_number: " + order.getPhoneNumber());
////            System.out.println("created_at: " + new java.sql.Date(order.getCreatedAt().getTime()));
////
//
//            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
//            stmt.setInt(1, order.getCustomerId());
//            stmt.setInt(2, (order.getVoucherId() == 0) ? null : order.getVoucherId());
//            stmt.setDouble(3, order.getTotalPrice());
//            stmt.setInt(4, order.getPaymentMethod());
//            stmt.setString(5, order.getAddressLine1());
//            stmt.setString(6, order.getAddressLine2());
//            stmt.setString(7, order.getPostalCode());
//            stmt.setString(8, order.getCity());
//            stmt.setString(9, order.getPhoneNumber());
//
//            int affectedRows = stmt.executeUpdate();
//
//            System.out.println(affectedRows);
//
//            if (affectedRows == 0) {
//                throw new SQLException("Creating order failed, no rows affected.");
//            }
//
//            // Retrieve the generated keys (order ID)
//            generatedKeys = stmt.getGeneratedKeys();
//            if (generatedKeys.next()) {
//                return generatedKeys.getInt(1); // Retrieve the generated order ID
//            } else {
//                throw new SQLException("Creating order failed, no ID obtained.");
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            // Log the exception
//            logger.log(Level.SEVERE, "Error occurred while inserting order", e);
//            throw e; // Re-throw the exception to the caller
//        } finally {
//            // Close resources in finally block
//            if (generatedKeys != null) {
//                try {
//                    generatedKeys.close();
//                } catch (SQLException e) {
//                    logger.log(Level.WARNING, "Failed to close ResultSet", e);
//                }
//            }
//            if (stmt != null) {
//                try {
//                    stmt.close();
//                } catch (SQLException e) {
//                    logger.log(Level.WARNING, "Failed to close PreparedStatement", e);
//                }
//            }
//            if (conn != null) {
//                try {
//                    conn.close();
//                } catch (SQLException e) {
//                    logger.log(Level.WARNING, "Failed to close Connection", e);
//                }
//            }
//        }
//    }
    public boolean insert(Order order) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "INSERT INTO [order] (customer_id, voucher_id, total_price, order_date, payment_method, address_line1, address_line2, postal_code, city, phone_number, created_at, [status]) VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, GETDATE(), ?)";

            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, order.getCustomerId());

            // Handling nullable voucher_id
            if (order.getVoucherId() == 0) {
                stmt.setNull(2, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(2, order.getVoucherId());
            }

            stmt.setDouble(3, order.getTotalPrice());
            stmt.setInt(4, order.getPaymentMethod());
            stmt.setString(5, order.getAddressLine1());
            stmt.setString(6, order.getAddressLine2());
            stmt.setString(7, order.getPostalCode());
            stmt.setString(8, order.getCity());
            stmt.setString(9, order.getPhoneNumber());
            stmt.setInt(10, order.getStatus());
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            // Retrieve the generated keys (order ID)
            generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                return true; // Order successfully created
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Log the exception
            logger.log(Level.SEVERE, "Error occurred while inserting order", e);
            throw e; // Re-throw the exception to the caller
        } finally {
            // Close resources in finally block
            if (generatedKeys != null) {
                try {
                    generatedKeys.close();
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

    public int getLastOrderId(int customerId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT TOP 1 * FROM [order] WHERE customer_id = ? ORDER BY order_date DESC, created_at DESC";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("order_id");
            }

        } catch (SQLException | ClassNotFoundException e) {
            // Log the exception
            logger.log(Level.SEVERE, "Error occurred while retrieving the last order for customer ID: " + customerId, e);
            throw e; // Re-throw the exception to the caller
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
        return 0;
    }
    
    public int getLastOrderReturnId() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT TOP 1 * FROM [order] ORDER BY [order_id] DESC";

            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("order_id");
            }

        } catch (SQLException | ClassNotFoundException e) {
            // Log the exception
            logger.log(Level.SEVERE, "Error occurred while retrieving the last order for customer", e);
            throw e; // Re-throw the exception to the caller
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
        return 0;
    }

    // Update an order in the database
    public void update(Order order) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "UPDATE [order] SET customer_id=?, voucher_id=?, total_price=?, order_date=?, payment_method=?, "
                    + "address_line1=?, address_line2=?, postal_code=?, city=?, phone_number=?, created_at=?, [status] = ? "
                    + "WHERE order_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, order.getCustomerId());
            stmt.setInt(2, order.getVoucherId());
            stmt.setDouble(3, order.getTotalPrice());
            stmt.setDate(4, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setInt(5, order.getPaymentMethod());
            stmt.setString(6, order.getAddressLine1());
            stmt.setString(7, order.getAddressLine2());
            stmt.setString(8, order.getPostalCode());
            stmt.setString(9, order.getCity());
            stmt.setString(10, order.getPhoneNumber());
            stmt.setDate(11, new java.sql.Date(order.getCreatedAt().getTime()));
            stmt.setInt(12, order.getStatus());
            stmt.setInt(13, order.getOrderId());

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

    // Delete an order from the database
    public void delete(int orderId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "DELETE FROM [order] WHERE order_id =?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);

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

    // Delete an order from the database
    public void deleteCustomerOrders(int customerId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "DELETE FROM [order] WHERE customer_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);

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

    public List<Order> getListOrderByPage(List<Order> listO, int start, int end) {
        List<Order> orders = new ArrayList<>();
        for (int i = start; i < end; i++) {
            orders.add(listO.get(i));
        }
        return orders;
    }

    public List<Order> getListOrderByFilter(String customer,
            String totalpricefrom,
            String totalpriceto,
            String orderdatefrom,
            String orderdateto,
            String phonenumber,
            String payment,
            String sortprice,
            String city,
            int status) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        List<Order> orders = new ArrayList<>();
        List<Object> values = new ArrayList<>();
        try {
            String sql = "SELECT [order_id]\n"
                    + "      ,[customer_id]\n"
                    + "      ,[voucher_id]\n"
                    + "      ,[total_price]\n"
                    + "      ,[order_date]\n"
                    + "      ,[payment_method]\n"
                    + "      ,[address_line1]\n"
                    + "      ,[address_line2]\n"
                    + "      ,[postal_code]\n"
                    + "      ,[city]\n"
                    + "      ,[phone_number]\n"
                    + "      ,[created_at], [status]\n"
                    + "  FROM [dbo].[order] WHERE 1 = 1";
            if (customer != null && !customer.isEmpty()) {
                customer = customer.trim().replaceAll("\\s+", " ");
                List<Customer> customers = WebManager.getInstance().customerDAO.getListCustomerByName(customer);
                if (customers != null && !customers.isEmpty()) {
                    sql += " AND ( ";
                    for (int i = 0; i < customers.size(); i++) {
                        if (i > 0) {
                            sql += " OR ";
                        }
                        sql += " [customer_id] = ? ";
                        values.add(customers.get(i).getId());
                    }
                    sql += " ) ";
                } else {
                    sql += " AND 1 = 0";
                }
            }
            if (totalpricefrom != null && !totalpricefrom.isEmpty()) {
                sql += " AND [total_price] >= ?";
                values.add(totalpricefrom);
            } else if (totalpriceto != null && !totalpriceto.isEmpty()) {
                sql += " AND [total_price] <= ?";
                values.add(totalpriceto);
            } else if (totalpricefrom != null && !totalpricefrom.isEmpty()
                    && totalpriceto != null && !totalpriceto.isEmpty()) {
                sql += " AND [total_price] BETWEEN ? AND ? ";
                values.add(totalpricefrom);
                values.add(totalpriceto);
            }
            if (orderdatefrom != null && !orderdatefrom.isEmpty()) {
                sql += " AND [order_date] >= ? ";
                values.add(orderdatefrom);
            } else if (orderdateto != null && !orderdateto.isEmpty()) {
                sql += " AND [order_date] <= ? ";
                values.add(orderdateto);
            } else if (orderdatefrom != null && !orderdatefrom.isEmpty()
                    && orderdateto != null && !orderdateto.isEmpty()) {
                sql += " AND [order_date] BETWEEN ? AND ? ";
                values.add(orderdatefrom);
                values.add(orderdateto);
            }
            if (phonenumber != null && !phonenumber.isEmpty()) {
                sql += " AND [phone_number] LIKE ?";
                values.add("%" + phonenumber + "%");
            }
            if (payment != null && !payment.isEmpty()) {
                sql += " AND [payment_method] = ?";
                values.add(payment);
            }
            if (city != null && !city.isEmpty()) {
                city = city.trim().replaceAll("\\s+", " ");
                sql += " AND [city] LIKE ? ";
                values.add("%" + city + "%");
            }
            if (status == 0) {
            } else {
                sql += " AND [status] = ? ";
                values.add(status);
            }
            if (sortprice != null && !sortprice.isEmpty()) {
                switch (sortprice) {
                    case "Increase":
                        sql += " ORDER BY [total_price] ASC, [order_id] DESC";
                        break;
                    case "Decrease":
                        sql += " ORDER BY [total_price] DESC, [order_id] DESC";
                        break;
                }
            }else{
                sql += " ORDER BY [order_id] DESC ";
            }
            conn = DBContext.getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (int i = 0; i < values.size(); i++) {
                    ps.setObject(i + 1, values.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        orders.add(extractOrderFromResultSet(rs));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            DBContext.closeConnection(conn);
        }
        return orders;
    }

    // Retrieve all orders from the database
    public List<Order> getAllOrders() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Order> orders = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT order_id FROM [order]";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(getOrder(rs.getInt("order_id")));
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

        return orders;
    }

    public double getTotalRevenue() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT SUM(total_price) AS total FROM dbo.[order] WHERE [status] IN (2, 3)";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
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
        return 0;
    }

    public double getTotalRevenueByMonth(int month, int year) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT SUM(total_price) AS total FROM dbo.[order] WHERE DATEPART(month, [order_date]) = ? AND DATEPART(year, [order_date]) = ? AND [status] IN (2, 3)";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
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
        return 0;
    }

    public double getTotalRevenueOfPreviousMonth(int month, int year) throws SQLException {
        if (month == 1) {
            month = 12;
            year--;
        } else {
            month--;
        }
        return getTotalRevenueByMonth(month, year);
    }

    public double getTotalRevenueByCategory(int categoryId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        double totalRevenue = 0;

        try {
            String sql = "SELECT SUM(oi.quantity * p.price) AS total_revenue "
                    + "FROM product p "
                    + "JOIN category c ON p.category_id = c.category_id "
                    + "JOIN order_item oi ON p.product_id = oi.product_id "
                    + "JOIN [order] o ON oi.order_id = o.order_id "
                    + "WHERE p.category_id = ? "
                    + "AND o.status IN (2, 3)";

            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getDouble("total_revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
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

        return totalRevenue;
    }

    public double getTotalSaled() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT SUM(total_price) AS total FROM dbo.[order] WHERE [status] = 3";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
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
        return 0;
    }

    public double getTotalSaledByMonth(int month, int year) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT SUM(total_price) AS total\n"
                    + "FROM dbo.[order]\n"
                    + "WHERE DATEPART(month, [order_date]) = ?\n"
                    + "  AND DATEPART(year, [order_date]) = ?\n"
                    + "  AND [status] = 3";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
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
        return 0;
    }

    public double getTotalSaledOfPreviousMonth(int month, int year) throws SQLException {
        if (month == 1) {
            month = 12;
            year--;
        } else {
            month--;
        }
        return getTotalSaledByMonth(month, year);
    }

    public int getTotalOrdersByMonth(int month, int year) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) AS total_orders\n"
                    + "FROM dbo.[order]\n"
                    + "WHERE DATEPART(month, [order_date]) = ?\n"
                    + "  AND DATEPART(year, [order_date]) = ?\n"
                    + "  AND [status] = 3";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
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
        return 0;
    }

    public int getTotalOrdersOfPreviousMonth(int month, int year) throws SQLException {
        if (month == 1) {
            month = 12;
            year--;
        } else {
            month--;
        }
        return getTotalOrdersByMonth(month, year);
    }

    public double getTotalDeliveringByMonth(int month, int year) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT SUM(total_price) AS total\n"
                    + "FROM dbo.[order]\n"
                    + "WHERE DATEPART(month, [order_date]) = ?\n"
                    + "  AND DATEPART(year, [order_date]) = ?\n"
                    + "  AND [status] = 2";
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
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
        return 0;
    }

    public List<Order> getAllOrdersByCustomerID(int customerID) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Order> orderList = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT * FROM [order] WHERE customer_id = ? ORDER BY order_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerID); // Set customerID parameter here
            System.out.println("Executing query with customer ID: " + customerID); // Log customer ID
            rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setVoucherId(rs.getInt("voucher_id"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setPaymentMethod(rs.getInt("payment_method"));
                order.setStatus(rs.getInt("status"));
                orderList.add(order);

                // Logging each order for debugging
                System.out.println("Retrieved Order: " + order.getOrderId() + " for Customer ID: " + customerID);
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

        System.out.println("Total orders retrieved: " + orderList.size());
        return orderList;
    }

    public List<Order> getOrderByCustomerFilter(int customerID,
            int paymentMethod,
            int status,
            String minPrice,
            String maxPrice,
            String startDate,
            String endDate,
            int sortprice) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        List<Order> orderList = new ArrayList<>();
        List<Object> values = new ArrayList<>();
        try {
            String sql = "SELECT [order_id]\n"
                    + "      ,[customer_id]\n"
                    + "      ,[voucher_id]\n"
                    + "      ,[total_price]\n"
                    + "      ,[order_date]\n"
                    + "      ,[payment_method]\n"
                    + "      ,[address_line1]\n"
                    + "      ,[address_line2]\n"
                    + "      ,[postal_code]\n"
                    + "      ,[city]\n"
                    + "      ,[phone_number]\n"
                    + "      ,[created_at]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[order] WHERE 1 = 1 ";
            sql += "  AND [customer_id] = ? ";
            values.add(customerID);
            if (paymentMethod == 1 || paymentMethod == 2) {
                sql += " AND [payment_method] = ? ";
                values.add(paymentMethod);
            }
            if (status == 0) {

            } else {
                sql += " AND [status] = ? ";
                values.add(status);
            }
            if (startDate != null && !startDate.isEmpty()) {
                sql += " AND [order_date] >= ? ";
                values.add(startDate);
                sql += " AND [order_date] <= ? ";
            } else if (endDate != null && !endDate.isEmpty()) {
                values.add(endDate);
            } else if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                sql += " AND [order_date] BETWEEN ? AND ? ";
                values.add(startDate);
                values.add(endDate);
            }
            if (minPrice != null && !minPrice.isEmpty()) {
                sql += " AND [total_price] >= ?";
                values.add(minPrice);
            } else if (maxPrice != null && !maxPrice.isEmpty()) {
                sql += " AND [total_price] <= ?";
                values.add(maxPrice);
            } else if (minPrice != null && !minPrice.isEmpty()
                    && maxPrice != null && !maxPrice.isEmpty()) {
                sql += " AND [total_price] BETWEEN ? AND ? ";
                values.add(minPrice);
                values.add(maxPrice);
            }

            switch (sortprice) {
                case 1:
                    sql += " ORDER BY [total_price] DESC, [order_id] DESC ";
                    break;
                case 2:
                    sql += " ORDER BY [total_price] ASC, [order_id] DESC ";
                    break;
                default:
                    sql += " ORDER BY [order_id] DESC ";
                    break;
            }
            conn = DBContext.getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                for (int i = 0; i < values.size(); i++) {
                    ps.setObject(i + 1, values.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        orderList.add(extractOrderFromResultSet(rs));
                    }
                }
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        System.out.println("Total orders retrieved: " + orderList.size());
        return orderList;
    }

    public Order getOrder(int orderId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Order order = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT * FROM [order] WHERE order_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = extractOrderFromResultSet(rs);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return order;
    }

    public Order getBiggestOrder() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Order order = null;

        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT [order_id]\n"
                    + "      ,[customer_id]\n"
                    + "      ,[voucher_id]\n"
                    + "      ,[total_price]\n"
                    + "      ,[order_date]\n"
                    + "      ,[payment_method]\n"
                    + "      ,[address_line1]\n"
                    + "      ,[address_line2]\n"
                    + "      ,[postal_code]\n"
                    + "      ,[city]\n"
                    + "      ,[phone_number]\n"
                    + "      ,[created_at]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[order] \n"
                    + "  WHERE [total_price] = (SELECT MAX(total_price) FROM [dbo].[order])\n"
                    + "  AND [status] = 3";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = extractOrderFromResultSet(rs);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return order;
    }

    public Order getNewestOrder() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Order order = null;
        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT TOP 1 [order_id]\n"
                    + "      ,[customer_id]\n"
                    + "      ,[voucher_id]\n"
                    + "      ,[total_price]\n"
                    + "      ,[order_date]\n"
                    + "      ,[payment_method]\n"
                    + "      ,[address_line1]\n"
                    + "      ,[address_line2]\n"
                    + "      ,[postal_code]\n"
                    + "      ,[city]\n"
                    + "      ,[phone_number]\n"
                    + "      ,[created_at]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[order] ORDER BY order_id DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = extractOrderFromResultSet(rs);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return order;
    }

    public Order getNewestOrderByCustomer(int customerid) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Order order = null;
        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT TOP 1 [order_id]\n"
                    + "      ,[customer_id]\n"
                    + "      ,[voucher_id]\n"
                    + "      ,[total_price]\n"
                    + "      ,[order_date]\n"
                    + "      ,[payment_method]\n"
                    + "      ,[address_line1]\n"
                    + "      ,[address_line2]\n"
                    + "      ,[postal_code]\n"
                    + "      ,[city]\n"
                    + "      ,[phone_number]\n"
                    + "      ,[created_at]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[order] WHERE customer_id = ? ORDER BY order_id DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerid);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = extractOrderFromResultSet(rs);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return order;
    }

    // Helper method to extract an Order object from the result set
    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setCustomerId(rs.getInt("customer_id"));
        order.setVoucherId(rs.getInt("voucher_id"));
        order.setTotalPrice(rs.getFloat("total_price"));
        order.setOrderDate(rs.getDate("order_date"));
        order.setPaymentMethod(rs.getInt("payment_method"));
        order.setAddressLine1(rs.getString("address_line1"));
        order.setAddressLine2(rs.getString("address_line2"));
        order.setPostalCode(rs.getString("postal_code"));
        order.setCity(rs.getString("city"));
        order.setPhoneNumber(rs.getString("phone_number"));
        order.setCreatedAt(rs.getDate("created_at"));
        order.setStatus(rs.getInt("status"));
        return order;
    }

    public List<Order> selectAllOrders() throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Order> orders = new ArrayList<>();
        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "SELECT * FROM [order]"; // Note: [order] might need escaping in some databases
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setVoucherId(rs.getInt("voucher_id"));
                order.setTotalPrice(rs.getInt("total_price"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setPaymentMethod(rs.getInt("payment_method"));
                order.setStatus(rs.getInt("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
        return orders;
    }

    public void updateOrderStatus(int id, int status) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection(); // Replace with your database connection method
            String sql = "UPDATE [dbo].[order]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE order_id = ?"; // Note: [order] might need escaping in some databases
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
    }

    public int returnOrderStatus(int orderid) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT [status] FROM [order] WHERE order_id = ?";
        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderid);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
        return 0;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        for (Order o : WebManager.getInstance().orderDAO.getOrderByCustomerFilter(2, 0, 0, null, null, null, null, 0)) {
            System.out.println(o);
        }
    }

}
