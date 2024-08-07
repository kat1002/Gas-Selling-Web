package com.model.DAO;

import com.model.Category;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CategoryDAO {

    private static final Logger LOGGER = Logger.getLogger(CategoryDAO.class.getName());

    public void addCategory(Category category) {
        String sql = "INSERT INTO category (title, description, created_date, modified_on, created_by, modified_by) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        // Declare connection outside the try-with-resources block
        try {
            conn = DBContext.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                stmt.setString(1, category.getTitle());
                stmt.setString(2, category.getDescription());
                stmt.setDate(3, new java.sql.Date(category.getCreatedDate().getTime()));
                stmt.setDate(4, new java.sql.Date(category.getModifiedOn().getTime()));
                stmt.setInt(5, category.getCreatedBy());
                stmt.setInt(6, category.getModifiedBy());
                stmt.executeUpdate();

                // Get generated keys to set the category ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        category.setCategoryId(generatedKeys.getInt(1));
                    }
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error adding category", e);
        } finally {
            // Close the connection in a finally block to ensure it's always closed
            DBContext.closeConnection(conn);
        }
    }



    public Category getCategory(int categoryId) {
        String sql = "SELECT * FROM category WHERE category_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, categoryId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return new Category(
                                rs.getInt("category_id"),
                                rs.getString("title"),
                                rs.getString("description"),
                                rs.getDate("created_date"),
                                rs.getDate("modified_on"),
                                rs.getInt("created_by"),
                                rs.getInt("modified_by")
                        );
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting category", e);
        }
        return null;
    }


    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM category WHERE role = 0";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    categories.add(new Category(
                            rs.getInt("category_id"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getDate("created_date"),
                            rs.getDate("modified_on"),
                            rs.getInt("created_by"),
                            rs.getInt("modified_by")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error getting all categories", e);
        } finally {
            DBContext.closeConnection(conn);
        }
        return categories;
    }


    public void updateCategory(Category category) {
        String sql = "UPDATE category SET title = ?, description = ?, created_date = ?, modified_on = ?, created_by = ?, modified_by = ? WHERE category_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, category.getTitle());
                stmt.setString(2, category.getDescription());
                stmt.setDate(3, new java.sql.Date(category.getCreatedDate().getTime()));
                stmt.setDate(4, new java.sql.Date(category.getModifiedOn().getTime()));
                stmt.setInt(5, category.getCreatedBy());
                stmt.setInt(6, category.getModifiedBy());
                stmt.setInt(7, category.getCategoryId());
                stmt.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating category", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }


    public void deleteCategory(int categoryId) {
        String sql = "DELETE FROM category WHERE category_id = ?";
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, categoryId);
                stmt.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting category", e);
        } finally {
            DBContext.closeConnection(conn);
        }
    }

}
