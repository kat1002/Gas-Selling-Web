/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

import com.model.Category;
import com.model.News;
import com.utils.DBContext;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
public class headerDAO {

    private static final Logger LOGGER = Logger.getLogger(headerDAO.class.getName());

    public List<Category> getAllCategory() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM category";
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
            LOGGER.log(Level.SEVERE, "Error getting header categories", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return categories;
    }

    public List<Category> getAllNavFilter(String[] searchTermsName, Date createDateFrom, Date createDateTo, Date modifyDateFrom, Date modifyDateTo, int createdBy, int modifiedBy) {
        List<Category> categories = new ArrayList<>();
        Connection connection = null;

        // Create a base SQL query
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM category WHERE role <> 0 ");

        // Append conditions based on the search terms and filters
        if (searchTermsName != null && searchTermsName.length > 0) {
            sqlBuilder.append(" AND (");
            for (int i = 0; i < searchTermsName.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(" OR ");
                }
                sqlBuilder.append("title LIKE ?");
            }
            sqlBuilder.append(")");
        }

        if (createDateFrom != null) {
            sqlBuilder.append(" AND created_date >= ?");
        }

        if (createDateTo != null) {
            sqlBuilder.append(" AND created_date <= ?");
        }

        if (modifyDateFrom != null) {
            sqlBuilder.append(" AND modified_on >= ?");
        }

        if (modifyDateTo != null) {
            sqlBuilder.append(" AND modified_on <= ?");
        }

        if (createdBy > 0) {
            sqlBuilder.append(" AND created_by = ?");
        }

        if (modifiedBy > 0) {
            sqlBuilder.append(" AND modified_by = ?");
        }

        // Order by clause
        sqlBuilder.append(" ORDER BY role DESC");

        // Execute the SQL query
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sqlBuilder.toString());

            int index = 1;
            if (searchTermsName != null) {
                for (String term : searchTermsName) {
                    stmt.setString(index++, "%" + term + "%");
                }
            }

            if (createDateFrom != null) {
                stmt.setDate(index++, new java.sql.Date(createDateFrom.getTime()));
            }

            if (createDateTo != null) {
                stmt.setDate(index++, new java.sql.Date(createDateTo.getTime()));
            }

            if (modifyDateFrom != null) {
                stmt.setDate(index++, new java.sql.Date(modifyDateFrom.getTime()));
            }

            if (modifyDateTo != null) {
                stmt.setDate(index++, new java.sql.Date(modifyDateTo.getTime()));
            }

            if (createdBy > 0) {
                stmt.setInt(index++, createdBy);
            }

            if (modifiedBy > 0) {
                stmt.setInt(index++, modifiedBy);
            }

            try (ResultSet rs = stmt.executeQuery()) {
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
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting nav with filters", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
        return categories;
    }

    public List<Category> getHeader() {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM category WHERE role > 0 ORDER BY role";
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
            LOGGER.log(Level.SEVERE, "Error getting header categories", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return categories;
    }

    public Category getNav(int id) {
        String sql = "SELECT * FROM category WHERE category_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Category(
                            rs.getInt("category_id"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getDate("created_date"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by"),
                            rs.getInt("role")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting header categories", e);
        } finally {
            DBContext.closeConnection(connection);
        }
        return null;
    }

    public List<Category> getCategoryTitle() {
        List<Category> titles = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                String sql = "SELECT DISTINCT category_id, title FROM category WHERE role = 0";
                try (PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
                    while (rs.next()) {
                        Category c = new Category();
                        c.setCategoryId(rs.getInt("category_id"));
                        c.setTitle(rs.getString("title"));
                        titles.add(c);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting category titles", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return titles;
    }

    public void addNav(Category category) {
        String sql = "INSERT INTO category (title, description,role, created_date, modified_on, created_by, modified_by) VALUES (?, ?, ?, GETDATE(), GETDATE(),?,?)";
        Connection connection = null;
        try {
            connection = DBContext.getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, category.getTitle());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getRole());
            stmt.setInt(4, category.getCreatedBy());
            stmt.setInt(5, category.getModifiedBy());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error add news", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }

    public void updateNav(Category category) {
        String sql = "UPDATE category SET title = ?, description = ?,role=?, modified_on = GETDATE(), modified_by = ? WHERE category_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, category.getTitle());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getRole());
            stmt.setInt(4, category.getModifiedBy());
            stmt.setInt(5, category.getCategoryId());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error update nav", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }

    public void deleteNav(int id) {
        String sql = "DELETE FROM category WHERE category_id = ?";
        Connection connection = null;
        try {
            connection = DBContext.getConnection(); // Get connection
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error delete nav", e);
        } finally {
            DBContext.closeConnection(connection); // Close connection in finally block
        }
    }

//    public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        headerDAO d = new headerDAO();
//        Category t =d.getNav(21);
//        System.out.println(t.getRole());
//    }
}
