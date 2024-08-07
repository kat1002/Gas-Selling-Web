/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.model.Customer;
import com.model.Manager;
import com.utils.DBContext;
import com.utils.UtilHashPass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kat1002
 */
public class ManagerDAO {

    private static final Logger LOGGER = Logger.getLogger(ManagerDAO.class.getName());

    public boolean addManager(Manager manager, String password) throws SQLException {
        Connection conn = null;

        String sql = "INSERT INTO manager (role_id, username, password, email, phone_number, first_name, last_name) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, manager.getRole());
            stmt.setString(2, manager.getUsername());
            stmt.setString(3, UtilHashPass.EncodePassword(password));
            stmt.setString(4, manager.getEmail());
            stmt.setString(5, manager.getPhone_number());
            stmt.setString(6, manager.getFirst_name());
            stmt.setString(7, manager.getLast_name());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating new manager", e);
        } finally {
            DBContext.closeConnection(conn);
        }

        return false;
    }

    public boolean checkUsername(String username) {
        String sql = "SELECT * FROM manager WHERE username = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    try (ResultSet rs = ps.executeQuery()) {
                        return rs.next(); // Return true if a record is found
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Error checking username", ex);
        } finally {
            DBContext.closeConnection(conn);
        }
        return false; // Return false if connection is null or an exception occurs
    }
    
    public int getTotalManagersWithRole_1() {
        int totalManagers = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // SQL query to count managers with role_id = 1
            String sql = "SELECT COUNT(*) AS total_managers FROM [dbo].[manager] WHERE [role_id] = 1";
            
            // Get connection from DBContext
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            
            // Execute the query
            rs = stmt.executeQuery();
            
            // Process the result
            if (rs.next()) {
                totalManagers = rs.getInt("total_managers");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Log or handle the exception as needed
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Log or handle the exception as needed
            }
        }

        return totalManagers;
    }
    
    // Method to get the newest manager based on highest manager_id
    public Manager getNewestManager() {
        Manager newestManager = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // SQL query to get the manager with the highest manager_id
            String sql = "SELECT TOP 1 [manager_id], [role_id], [username], [password], [email], [phone_number], [first_name], [last_name] " +
                         "FROM [dbo].[manager] " +
                         "ORDER BY [manager_id] DESC";

            // Get connection from DBContext
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(sql);
            
            // Execute the query
            rs = stmt.executeQuery();
            
            // Process the result
            if (rs.next()) {
                newestManager = getManager(rs.getInt("manager_id"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Log or handle the exception as needed
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Log or handle the exception as needed
            }
        }

        return newestManager;
    }

    public boolean checkPassword(String username, String password) {
        String sql = "SELECT password FROM manager WHERE username = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
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
        } finally {
            DBContext.closeConnection(conn);
        }
        return false;
    }
    
    public List<Manager> getManagerByFilter(String[] searchTermsUname, String[] searchTermsEmail,
            String[] searchTermsFname, String[] searchTermsLname,String[] searchTermsPhoneNumber) {
        Connection connection = null;
        List<Manager> cList = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM manager WHERE 1=1");

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
                sqlBuilder.append("email LIKE ?");
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
        sqlBuilder.append(" ORDER BY manager_id DESC");

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
            
            if (searchTermsPhoneNumber != null) {
                for (String term : searchTermsPhoneNumber) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }
            
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cList.add(new Manager(rs.getInt("manager_id"),
                                    rs.getString("username"),
                                    rs.getString("phone_number"),
                                    rs.getString("email"),
                                    rs.getString("first_name"),
                                    rs.getString("last_name"),
                                    rs.getInt("role_id")));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer with filters", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return cList;
    }

    public boolean checkEmail(String email){
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM manager WHERE email = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, email);
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

    public Manager getManagerByUsername(String username) {
        Connection conn = null;
        Manager manager = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM manager WHERE username = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, username);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            manager = getManager(resultSet.getInt("manager_id"));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer by username", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return manager;
    }


    public Manager getManager(int id) {
        Connection conn = null;
        Manager manager = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM manager WHERE manager_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setInt(1, id);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            manager = new Manager(id,
                                    resultSet.getString("username"),
                                    resultSet.getString("phone_number"),
                                    resultSet.getString("email"),
                                    resultSet.getString("first_name"),
                                    resultSet.getString("last_name"),
                                    resultSet.getInt("role_id"));

                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting customer", e);
        }
        return manager;
    }

    public boolean updateManager(Manager manager) {
        Connection conn = null;
        boolean updateSuccessful = false;

        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "UPDATE manager SET phone_number = ?, email = ?, first_name = ?, last_name = ?, role_id = ?,username=? WHERE manager_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, manager.getPhone_number());
                    statement.setString(2, manager.getEmail());
                    statement.setString(3, manager.getFirst_name());
                    statement.setString(4, manager.getLast_name());
                    statement.setInt(5, manager.getRole());
                    statement.setString(6, manager.getUsername());
                    statement.setInt(7, manager.getManagerId());

                    int rowsAffected = statement.executeUpdate();
                    updateSuccessful = rowsAffected > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating manager", e);
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
    
    public boolean deleteManager(int id) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "DELETE FROM manager WHERE manager_id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setInt(1, id);
                    return statement.executeUpdate() > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting maanger", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return false;
    }

    public int getTotalManagerCount(String searchType, String searchQuery) {
        Connection conn = null;
        int count = 0;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS count FROM manager");

                // Adjust the SQL query based on the searchType
                if ("username".equals(searchType)) {
                    sql.append(" WHERE username LIKE ?");
                } else if ("email".equals(searchType)) {
                    sql.append(" WHERE email LIKE ?");
                } else if ("first_name".equals(searchType)) {
                    sql.append(" WHERE first_name LIKE ?");
                } else if ("manager_id".equals(searchType)) {
                    sql.append(" WHERE manager_id LIKE ?");
                }

                try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                    // Set the parameter for the search query if needed
                    if ("username".equals(searchType) || "email".equals(searchType) || "first_name".equals(searchType) || "manager_id".equals(searchType)) {
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
            LOGGER.log(Level.SEVERE, "Error getting total manager count", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return count;
    }


    public List<Manager> getManagers(int page, int rowsPerPage, String searchType, String searchQuery, String sortBy) {
        List<Manager> managers = new ArrayList<>();
        Connection conn = null;
        int offset = (page - 1) * rowsPerPage;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "";
                if ("username".equals(searchType)) {
                } else if ("email".equals(searchType)) {
                    sql = "SELECT manager_id, username, phone_number, email, first_name, last_name, role_id FROM manager WHERE email LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                } else if ("first_name".equals(searchType)) {
                    sql = "SELECT manager_id, username, phone_number, email, first_name, last_name, role_id FROM manager WHERE first_name LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                } else if ("manager_id".equals(searchType)) {
                    sql = "SELECT manager_id, username, phone_number, email, first_name, last_name, role_id FROM manager WHERE manager_id LIKE ? ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                } else {
                    sql = "SELECT manager_id, username, phone_number, email, first_name, last_name, role_id FROM manager ORDER BY " + sortBy + " OFFSET ? ROWS FETCH FIRST " + rowsPerPage + " ROWS ONLY";
                }

                System.out.println(sql);

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    if ("username".equals(searchType) || "email".equals(searchType) || "first_name".equals(searchType) || "manager_id".equals(searchType)) {
                        ps.setString(1, "%" + searchQuery + "%");
                        ps.setInt(2, offset);
                    } else {
                        ps.setInt(1, offset);
                    }

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            managers.add(getManager(rs.getInt("manager_id")));
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting managers", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return managers;
    }
    
    public List<Manager> getManagerByPartName(String search) {
        List<Manager> managers = new ArrayList<>();
        String sql = "SELECT [manager_id]\n"
                + "      ,[role_id]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[email]\n"
                + "      ,[phone_number]\n"
                + "      ,[first_name]\n"
                + "      ,[last_name]\n"
                + "  FROM [dbo].[manager] WHERE [username] LIKE ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, "%" + search + "%");
                    try (ResultSet rs = ps.executeQuery();) {
                        if (rs.next()) {
                            managers.add(new Manager(rs.getInt("manager_id"),
                            rs.getInt("role_id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("email"),
                            rs.getString("phone_number")));
                        }
                    }
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error get manager", e);
        }

        return managers;
    }
}

