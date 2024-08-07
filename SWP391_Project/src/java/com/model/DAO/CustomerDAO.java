/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.model.Customer;
import com.model.GoogleAcc;
import com.utils.DBContext;
import com.utils.UtilHashPass;
import jdk.jshell.execution.Util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author WuanTun
 */
public class CustomerDAO {

    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());

    public boolean checkUsername(String username) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE username = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    try (ResultSet rs = ps.executeQuery()) {
                        return rs.next(); // If a record is found, return true
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Error checking username", ex);
        }
        return false; // Return false if connection is null or if an exception occurs
    }

    //CHECK LOGIN = PASSWORD
    public boolean checkPassword(String username, String password) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT password FROM customer WHERE username = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            String storedPassword = rs.getString("password");
                            String hashedPassword = UtilHashPass.EncodePassword(password); // Encode the input password
                            return storedPassword.equals(hashedPassword); // Compare the hashed passwords
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error checking password", e);
        }
        return false;
    }

    public boolean checkGmail(String gmail) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE gmail = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, gmail);
                    try (ResultSet rs = ps.executeQuery()) {
                        return rs.next(); // If a record is found, return true
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Error checking username", ex);
        }
        return false; // Return false if connection is null or if an exception occurs
    }

//    CHECK LOGIN = EMAIL
//    public boolean checkGmail(String gmail) {
//        if (connection != null) {
//            String sql = "SELECT * FROM customer WHERE gmail = ?";
//            try (PreparedStatement ps = connection.prepareStatement(sql)) {
//                ps.setString(1, gmail);
//                ResultSet rs = ps.executeQuery();
//                return rs.next(); // Nếu tìm thấy bản ghi, trả về true
//            } catch (SQLException ex) {
//                ex.printStackTrace(); // In ra lỗi để dễ dàng kiểm tra
//            }
//        }
//        return false; // Trả về false nếu connection là null hoặc có exception xảy ra
//    }
    // Kiểm tra xem username hoặc gmail đã tồn tại trong database chưa
    public boolean existsByUsernameOrGmail(String username, String gmail) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE username = ? OR gmail = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    ps.setString(2, gmail);
                    try (ResultSet rs = ps.executeQuery()) {
                        return rs.next();
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error checking existence by username or gmail", e);
        }
        return false;
    }

    //CHECK IF EXIST USERNAME 
//    public boolean existsByUsername(String username) {
//        String sql = "SELECT * FROM customer WHERE username = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, username);
//            ResultSet rs = ps.executeQuery();
//            return rs.next();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
    //CHECK IF EXIST EMAIL
//    public boolean existByEmail(String email) {
//        String sql = "SELECT * FROM customer WHERE gmail = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, email);
//            ResultSet rs = ps.executeQuery();
//            return rs.next();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
    public boolean addCustomer(Customer customer, String password) throws SQLException {
        Connection conn = null;

        String sql = "INSERT INTO customer (customer_type, username, password, gmail, phone_number, first_name, last_name, address_line1, address_line2, postal_code, city,customer_img,receiveNotif) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customer.getCustomerType());
            stmt.setString(2, customer.getUsername());
            stmt.setString(3, UtilHashPass.EncodePassword(password));
            stmt.setString(4, customer.getGmail());
            stmt.setString(5, customer.getPhone_number());
            stmt.setString(6, customer.getFirst_name());
            stmt.setString(7, customer.getLast_name());
            stmt.setString(8, customer.getAddress_line1());
            stmt.setString(9, customer.getAddress_line2());
            stmt.setInt(10, customer.getPostal_code());
            stmt.setString(11, customer.getCity());
            stmt.setString(12, customer.getCustomerImage());
            stmt.setInt(13, customer.getReceiveNotif());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating new customer", e);
        } finally {
            DBContext.closeConnection(conn);
        }

        return false;
    }

    public void createNewCustomer(String username, String gmail, String first_name, String last_name, String password) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String hashedPassword = password != null ? UtilHashPass.EncodePassword(password) : null; // Encode password if not null
                String sql = "INSERT INTO customer (username, password, first_name, last_name, gmail, customer_type,customer_img,receiveNotif) VALUES (?, ?, ?, ?, ?, 1,'media/customerImage.jpg',1)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    ps.setString(2, hashedPassword); // Save hashed password, could be null
                    ps.setString(3, first_name);
                    ps.setString(4, last_name);
                    ps.setString(5, gmail);
                    ps.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating new customer", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public void createNewCusGoogle(GoogleAcc googleAcc) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO customer (username, gmail, first_name, last_name, customer_type,customer_img,receiveNotif) VALUES (?, ?, ?, ?, 1, 'media/customerImage.jpg',1)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, googleAcc.getName());
                    ps.setString(2, googleAcc.getEmail());
                    ps.setString(3, googleAcc.getGiven_name());
                    ps.setString(4, googleAcc.getFamily_name());

                    ps.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating new customer from Google account", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

    public String getPassword(String username) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT password FROM customer WHERE username = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) { // If a record is found, return the password
                            return rs.getString("password");
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Error getting password", ex);
        }
        return null; // Return null if connection is null, no record found, or if an exception occurs
    }

    public boolean updatePassword(String newPassword, String username) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                // Hash the new password using SHA-1 with static salt
                String hashedPassword = newPassword != null ? UtilHashPass.EncodePassword(newPassword) : null;


                String sql = "UPDATE customer SET password = ? WHERE username = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, hashedPassword);
                    ps.setString(2, username);

                    int rowsAffected = ps.executeUpdate();
                    return rowsAffected > 0; // Return true if update successful
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Error changing password", ex);
        }
        return false; // Return false if connection is null or if an exception occurs
    }
    
    public Customer findCustomerByGmail(String gmail) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT customer_id FROM customer WHERE gmail = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, gmail);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            return getCustomer(rs.getInt("customer_id"));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error finding customer by gmail", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return null;
    }

    public boolean insertCustomer(Customer customer) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO customer (username, gmail, address_line1, phone_number, first_name, last_name) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, customer.getUsername());
                    statement.setString(2, customer.getGmail());
                    statement.setString(3, customer.getAddress_line1());
                    statement.setString(4, customer.getPhone_number());
                    statement.setString(5, customer.getFirst_name());
                    statement.setString(6, customer.getLast_name());

                    return statement.executeUpdate() > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error inserting customer", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return false;
    }

    public List<Customer> listAllcustomer() {
        List<Customer> listCustomer = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT customer_id FROM customer";
                try (Statement statement = conn.createStatement(); ResultSet resultSet = statement.executeQuery(sql)) {
                    while (resultSet.next()) {
                        listCustomer.add(getCustomer(resultSet.getInt("customer_id")));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error listing all customers", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return listCustomer;
    }

    public boolean deleteCustomer(int customerId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "DELETE FROM customer WHERE customer_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setInt(1, customerId);
                    return statement.executeUpdate() > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting customer", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return false;
    }

    public boolean updateCustomer(Customer customer) {
        Connection conn = null;
        boolean updateSuccessful = false;

        //System.out.println(customer);
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "UPDATE customer SET customer_type = ?, first_name = ?, last_name = ?,phone_number =?, address_line1 = ?, address_line2 = ?, postal_code = ?, city = ?,customer_img=?,receiveNotif=? WHERE customer_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setInt(1, customer.getCustomerType());
                    statement.setString(2, customer.getFirst_name());
                    statement.setString(3, customer.getLast_name());
                    statement.setString(4, customer.getPhone_number());
                    statement.setString(5, customer.getAddress_line1());
                    statement.setString(6, customer.getAddress_line2());
                    statement.setInt(7, customer.getPostal_code());
                    statement.setString(8, customer.getCity());
                    statement.setString(9, customer.getCustomerImage());
                    statement.setInt(10, customer.getReceiveNotif());
                    statement.setInt(11, customer.getCustomerId());

                    int rowsAffected = statement.executeUpdate();
                    updateSuccessful = rowsAffected > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating customer", e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing connection", e);
                }
            }
        }

        return updateSuccessful;
    }

    public void updateCustomer2(Customer customer) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "UPDATE customer SET customer_type = ?, first_name = ?, last_name = ?,phone_number =?, address_line1 = ?, address_line2 = ?, postal_code = ?, city = ?,username=?,customer_img=?,receiveNotif=? WHERE customer_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setInt(1, customer.getCustomerType());
                    statement.setString(2, customer.getFirst_name());
                    statement.setString(3, customer.getLast_name());
                    statement.setString(4, customer.getPhone_number());
                    statement.setString(5, customer.getAddress_line1());
                    statement.setString(6, customer.getAddress_line2());
                    statement.setInt(7, customer.getPostal_code());
                    statement.setString(8, customer.getCity());
                    statement.setString(9, customer.getUsername());
                    statement.setString(10, customer.getCustomerImage());
                    statement.setInt(11, customer.getReceiveNotif());
                    statement.setInt(12, customer.getCustomerId());
                    statement.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating customer", e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error closing connection", e);
                }
            }
        }
    }

    public Customer getCustomer(int id) {
        Connection conn = null;
        Customer customer = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE customer_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setInt(1, id);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            customer = new Customer(id,
                                    resultSet.getInt("customer_type"),
                                    resultSet.getString("username"),
                                    resultSet.getString("password"),
                                    resultSet.getString("gmail"),
                                    resultSet.getString("phone_number"),
                                    resultSet.getString("first_name"),
                                    resultSet.getString("last_name"),
                                    resultSet.getString("address_line1"),
                                    resultSet.getString("address_line2"),
                                    resultSet.getInt("postal_code"),
                                    resultSet.getString("city"),
                            resultSet.getString("customer_img"),
                            resultSet.getInt("receiveNotif"));

                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer", e);
        }
        return customer;
    }
    
    

    public List<String> getCustomerType() {
        List<String> type = new ArrayList<>();
        Connection connection = null;
        String sql = "select distinct customer_type from customer";
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    type.add(String.valueOf(rs.getInt("customer_type")));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting cus tupe", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return type;
    }

    public List<Customer> getCustomerByFilter(String[] searchTermsUname, String[] searchTermsEmail,
            String[] searchTermsFname, String[] searchTermsLname,
            String[] searchTermsAddr1, String[] searchTermsAddr2,
            String[] searchTermsPhoneNumber, String[] searchTermsCity) {
        Connection connection = null;
        List<Customer> cList = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM customer WHERE 1=1");

        if (searchTermsUname != null && searchTermsUname.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsUname.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("username LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsFname != null && searchTermsFname.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsFname.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("first_name LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsLname != null && searchTermsLname.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsLname.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("last_name LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsEmail != null && searchTermsEmail.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsEmail.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("gmail LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsAddr1 != null && searchTermsAddr1.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsAddr1.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("address_line1 LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsAddr2 != null && searchTermsAddr2.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsAddr2.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("address_line2 LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsCity != null && searchTermsCity.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsCity.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("city LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (searchTermsPhoneNumber != null && searchTermsPhoneNumber.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsPhoneNumber.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("phone_number LIKE ?");
            }
            sqlBuilder.append(")");
        }

        // Order by clause
        sqlBuilder.append(" ORDER BY customer_id DESC");

        // Execute the SQL query
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sqlBuilder.toString());

            int index = 1;
            if (searchTermsUname != null) {
                for (String term : searchTermsUname) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsFname != null) {
                for (String term : searchTermsFname) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsLname != null) {
                for (String term : searchTermsLname) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsEmail != null) {
                for (String term : searchTermsEmail) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsAddr1 != null) {
                for (String term : searchTermsAddr1) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsAddr2 != null) {
                for (String term : searchTermsAddr2) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsCity != null) {
                for (String term : searchTermsCity) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (searchTermsPhoneNumber != null) {
                for (String term : searchTermsPhoneNumber) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cList.add(new Customer(rs.getInt("customer_id"),
                            rs.getInt("customer_type"),
                                    rs.getString("username"),
                                    rs.getString("password"),
                                    rs.getString("gmail"),
                                    rs.getString("phone_number"),
                                    rs.getString("first_name"),
                                    rs.getString("last_name"),
                                    rs.getString("address_line1"),
                                    rs.getString("address_line2"),
                                    rs.getInt("postal_code"),
                                    rs.getString("city"),
                            rs.getString("customer_img"),
                    rs.getInt("receiveNotif")));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer with filters", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return cList;
    }

    public Customer getCustomerByUsername(String username) {
        Connection conn = null;
        Customer customer = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE username = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, username);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            customer = getCustomer(resultSet.getInt("customer_id"));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by username", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return customer;
    }

    public Customer getNewestCustomer() {
        Connection conn = null;
        Customer customer = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT TOP 1 [customer_id]\n"
                        + "      ,[customer_type]\n"
                        + "      ,[customer_img]\n"
                        + "      ,[username]\n"
                        + "      ,[password]\n"
                        + "      ,[first_name]\n"
                        + "      ,[last_name]\n"
                        + "      ,[phone_number]\n"
                        + "      ,[gmail]\n"
                        + "      ,[receive_sms]\n"
                        + "      ,[receive_email]\n"
                        + "      ,[address_line1]\n"
                        + "      ,[address_line2]\n"
                        + "      ,[postal_code]\n"
                        + "      ,[city]\n"
                        + "      ,[receiveNotif]\n"
                        + "  FROM [dbo].[customer] ORDER BY customer_id DESC";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            customer = getCustomer(resultSet.getInt("customer_id"));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by username", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return customer;
    }
    
     public Customer getCustomerByGmail(String gmail) {
        Connection conn = null;
        Customer customer = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE gmail = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, gmail);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            customer = getCustomer(resultSet.getInt("customer_id"));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by username", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return customer;
    }
   

//    public Customer getNewestCustomer() {
//        Connection conn = null;
//        Customer customer = null;
//        try {
//            conn = DBContext.getConnection();
//            if (conn != null) {
//                String sql = "SELECT TOP 1 [customer_id]\n"
//                        + "      ,[customer_type]\n"
//                        + "      ,[username]\n"
//                        + "      ,[password]\n"
//                        + "      ,[first_name]\n"
//                        + "      ,[last_name]\n"
//                        + "      ,[phone_number]\n"
//                        + "      ,[gmail]\n"
//                        + "      ,[receive_sms]\n"
//                        + "      ,[receive_email]\n"
//                        + "      ,[address_line1]\n"
//                        + "      ,[address_line2]\n"
//                        + "      ,[postal_code]\n"
//                        + "      ,[city]\n"
//                        + "  FROM [dbo].[customer] ORDER BY customer_id DESC";
//                try (PreparedStatement statement = conn.prepareStatement(sql)) {
//                    try (ResultSet resultSet = statement.executeQuery()) {
//                        if (resultSet.next()) {
//                            customer = getCustomer(resultSet.getInt("customer_id"));
//                        }
//                    }
//                }
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            LOGGER.log(Level.SEVERE, "Error getting customer by username", e);
//        } finally {
//            DBContext.closeConnection(conn);
//        }
//        return customer;
//    }

    public int getTotalCustomerCount(String searchType, String searchQuery) {
        Connection conn = null;
        int count = 0;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS count FROM customer");

                // Adjust the SQL query based on the searchType
                if ("username".equals(searchType)) {
                    sql.append(" WHERE username LIKE ?");
                } else if ("gmail".equals(searchType)) {
                    sql.append(" WHERE gmail LIKE ?");
                } else if ("first_name".equals(searchType)) {
                    sql.append(" WHERE first_name LIKE ?");
                } else if ("customer_id".equals(searchType)) {
                    sql.append(" WHERE customer_id LIKE ?");
                }

                try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                    // Set the parameter for the search query if needed
                    if ("username".equals(searchType) || "gmail".equals(searchType) || "first_name".equals(searchType) || "customer_id".equals(searchType)) {
                        ps.setString(1, "%" + searchQuery + "%");
                    }

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            count = rs.getInt("count");
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting total customer count", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return count;
    }

    public List<Customer> getCustomers(int page, int rowsPerPage, String searchType, String searchQuery, String sortBy) {
        List<Customer> customers = new ArrayList<>();
        Connection conn = null;
        int offset = (page - 1) * rowsPerPage;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "";
                if ("username".equals(searchType)) {
                    sql = "SELECT customer_id, username, gmail FROM customer WHERE username LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                } else if ("gmail".equals(searchType)) {
                    sql = "SELECT customer_id, username, gmail FROM customer WHERE gmail LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                } else if ("first_name".equals(searchType)) {
                    sql = "SELECT customer_id, username, gmail, first_name FROM customer WHERE first_name LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                } else if ("customer_id".equals(searchType)) {
                    sql = "SELECT customer_id FROM customer WHERE customer_id LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                }

                System.out.println(sql);

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    if ("username".equals(searchType) || "gmail".equals(searchType) || "first_name".equals(searchType) || "customer_id".equals(searchType)) {
                        ps.setString(1, "%" + searchQuery + "%");
                        ps.setInt(2, offset);
                    } else {
                        ps.setInt(1, offset);
                    }

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            int id = rs.getInt("customer_id");
                            //System.out.println(id);
                            customers.add(getCustomer(id));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customers", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return customers;
    }

    public List<Customer> getListCustomerByName(String customer) {
        Connection conn = null;
        List<Customer> customers = new ArrayList<>();
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM customer WHERE username LIKE ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, "%" + customer + "%");
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            customers.add(getCustomer(resultSet.getInt("customer_id")));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by username", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return null;
    }
    
//        public static void main(String[] args) {
//        CustomerDAO c= new CustomerDAO();
//        
//        System.out.println(c.checkPassword("tientien", "tientien2"));
//    }

}
