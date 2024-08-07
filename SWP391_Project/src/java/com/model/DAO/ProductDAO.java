/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model.DAO;

/**
 *
 * @author kat1002
 */
import com.controller.WebManager;
import com.model.Manager;
import com.model.Product;
import com.utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDAO {

    private Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    public ProductDAO() throws SQLException, ClassNotFoundException {
    }

    public void addProductImages(int id, String image) throws SQLException {
        String sql = "INSERT INTO [dbo].[product_image]\n"
                + "           ([product_id]\n"
                + "           ,[url])\n"
                + "     VALUES\n"
                + "           (?, ?)";
        Connection conn = null;
        PreparedStatement statement = null;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            statement.setString(2, image);
            statement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public boolean insertProduct(Product product) throws SQLException {
        String sql = "INSERT INTO product (category_id, discount_id, reviews_rate, title, description, stock, price, created_date, modified_on, created_by, modified_by, warranty_months) VALUES (?, NULL, NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement statement = null;
        boolean rowInserted = false;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);

            statement.setInt(1, product.getCategoryId());
////            statement.setInt(2, product.getDiscountId());
//            statement.setInt(2, product.getReviewsRate());
            statement.setString(2, product.getTitle());
            statement.setString(3, product.getDescription());
            statement.setInt(4, product.getStock());
            statement.setFloat(5, product.getPrice());
            statement.setDate(6, new java.sql.Date(product.getCreatedDate().getTime()));
            statement.setDate(7, new java.sql.Date(product.getModifiedOn().getTime()));
            statement.setInt(8, product.getCreatedBy());
            statement.setInt(9, product.getModifiedBy());
            statement.setInt(10, product.getWarranty_months());
            rowInserted = statement.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return rowInserted;
    }

    public boolean checkProductNameExistsById(String title, int id) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT [product_id] FROM [dbo].[product] WHERE [title] = ? AND [product_id] != ?";
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setString(1, title);
            statement.setInt(2, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return false;
    }

    public boolean checkProductNameExists(String title) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT [product_id] FROM [dbo].[product] WHERE [title] = ?";
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setString(1, title);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return false;
    }

    public List<Product> getProductByPage(List<Product> list, int start, int end) {
        List<Product> productList = new ArrayList<>();
        for (int i = start; i < end; i++) {
            productList.add(list.get(i));
        }
        return productList;
    }

    public List<Product> listProductsMultipleChoice(int cid,
            int choicebyprice,
            String search,
            String fromprice,
            String toprice,
            String datecreatedfrom,
            String datecreatedto,
            String datemodifiedfrom,
            String datemodifiedto,
            String createdby,
            String modifiedby,
            String star) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        List<Product> products = new ArrayList<>();

        try {
            conn = DBContext.getConnection();

            StringBuilder sql = new StringBuilder("SELECT [product_id]\n"
                    + "      ,[category_id]\n"
                    + "      ,[discount_id]\n"
                    + "      ,[reviews_rate]\n"
                    + "      ,[title]\n"
                    + "      ,[description]\n"
                    + "      ,[stock]\n"
                    + "      ,[price]\n"
                    + "      ,[created_date]\n"
                    + "      ,[modified_on]\n"
                    + "      ,[created_by]\n"
                    + "      ,[modified_by]\n"
                    + "      ,[warranty_months]\n"
                    + "  FROM [dbo].[product] WHERE 1 = 1");

            List<Object> values = new ArrayList<>();

            if (cid != 0) {
                sql.append(" AND [category_id] = ?");
                values.add(cid);
            }

            if (createdby != null && !createdby.isEmpty()) {
                createdby = createdby.trim().replaceAll("\\s+", " ");
                List<Manager> managers = new ManagerDAO().getManagerByPartName(createdby);
                if (managers != null && !managers.isEmpty()) {
                    sql.append(" AND (");
                    for (int i = 0; i < managers.size(); i++) {
                        if (i > 0) {
                            sql.append(" OR ");
                        }
                        sql.append("[created_by] = ?");
                        values.add(managers.get(i).getManagerId());
                    }
                    sql.append(")");
                } else {
                    // Người quản lý không tồn tại, không thực hiện tìm kiếm
                    sql.append(" AND 1=0"); // hoặc sql.append(" AND [created_by] IS NULL") nếu NULL là hợp lệ
                }
            }

            if (modifiedby != null && !modifiedby.isEmpty()) {
                modifiedby = modifiedby.trim().replaceAll("\\s+", " ");
                List<Manager> managers = new ManagerDAO().getManagerByPartName(modifiedby);
                if (managers != null && !managers.isEmpty()) {
                    sql.append(" AND (");
                    for (int i = 0; i < managers.size(); i++) {
                        if (i > 0) {
                            sql.append(" OR ");
                        }
                        sql.append("[modified_by] = ?");
                        values.add(managers.get(i).getManagerId());
                    }
                    sql.append(")");
                } else {
                    // Người quản lý không tồn tại, không thực hiện tìm kiếm
                    sql.append(" AND 1=0"); // hoặc sql.append(" AND [created_by] IS NULL") nếu NULL là hợp lệ
                }
            }

            if (search != null && !search.isEmpty()) {
                search = search.trim().replaceAll("\\s+", " ");
                String[] ss = search.split(" ");
                sql.append(" AND (");
                for (int i = 0; i < ss.length; i++) {
                    if (i > 0) {
                        sql.append(" OR ");
                    }
                    sql.append(" [title] LIKE ?");
                    values.add("%" + ss[i] + "%");
                }
                sql.append(" ) ");
            }
            if (fromprice != null && !fromprice.isEmpty()) {
                sql.append(" AND [price] >= ?");
                values.add(Float.parseFloat(fromprice));
            } else if (toprice != null && !toprice.isEmpty()) {
                sql.append(" AND [price] <= ?");
                values.add(Float.parseFloat(toprice));
            } else if (datemodifiedfrom != null && !datemodifiedfrom.isEmpty()
                    && datemodifiedto != null && !datemodifiedto.isEmpty()) {
                sql.append(" AND [modified_on] BETWEEN ? AND ? ");
                values.add(datemodifiedfrom);
                values.add(datemodifiedto);
            }
            if (datecreatedfrom != null && !datecreatedfrom.isEmpty()) {
                sql.append(" AND [created_date] >= ? ");
                values.add(datecreatedfrom);
            } else if (datecreatedto != null && !datecreatedto.isEmpty()) {
                sql.append(" AND [created_date] <= ? ");
                values.add(datecreatedto);
            } else if (datecreatedfrom != null && !datecreatedfrom.isEmpty()
                    && datecreatedto != null && !datecreatedto.isEmpty()) {
                sql.append(" AND [created_date] BETWEEN ? AND ?");
                values.add(datecreatedfrom);
                values.add(datecreatedto);
            }
            if (datemodifiedfrom != null && !datemodifiedfrom.isEmpty()) {
                sql.append(" AND [modified_on] >= ?");
                values.add(datemodifiedfrom);
            } else if (datemodifiedto != null && !datemodifiedto.isEmpty()) {
                sql.append(" AND [modified_on] <= ? ");
                values.add(datemodifiedto);
            } else if (fromprice != null && !fromprice.isEmpty() && toprice != null && !toprice.isEmpty()) {
                sql.append(" AND [price] BETWEEN ? AND ?");
                values.add(Float.parseFloat(fromprice));
                values.add(Float.parseFloat(toprice));
            }
            if (star != null && !star.isEmpty()) {
                if (star.equals("Unrated") || star.equals("0")) {
                    sql.append(" AND [reviews_rate] IS NULL ");
                } else {
                    sql.append(" AND [reviews_rate] = ? ");
                    values.add(star);
                }
            }
            switch (choicebyprice) {
                case 1:
                    sql.append(" ORDER BY [price] DESC");
                    break;
                case 2:
                    sql.append(" ORDER BY [price] ASC");
                    break;
            }
            statement = conn.prepareStatement(sql.toString());
            for (int i = 0; i < values.size(); i++) {
                statement.setObject(i + 1, values.get(i));
            }
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setDiscountId(resultSet.getInt("discount_id"));
                product.setReviewsRate(resultSet.getInt("reviews_rate"));
                product.setTitle(resultSet.getString("title"));
                product.setDescription(resultSet.getString("description"));
                product.setStock(resultSet.getInt("stock"));
                product.setPrice(resultSet.getFloat("price"));
                product.setCreatedDate(resultSet.getDate("created_date"));
                product.setModifiedOn(resultSet.getDate("modified_on"));
                product.setCreatedBy(resultSet.getInt("created_by"));
                product.setModifiedBy(resultSet.getInt("modified_by"));
                product.setWarranty_months(resultSet.getInt("warranty_months"));
                product.setImages(getImagesByProductId(product.getProductId()));

                products.add(product);

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return products;
    }

    public List<Product> listProductSearch(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Product> products = new ArrayList<>();
        List<Object> values = new ArrayList<>();
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT * FROM product WHERE 1 = 1";
            statement = conn.prepareStatement(sql);
            search = search.trim().replaceAll("\\s+", " ");
            String[] ss = search.split(" ");
            sql += " AND ( ";
            for (int i = 0; i < ss.length; i++) {
                if (i > 0) {
                    sql += " OR ";
                }
                sql += " [title] LIKE ?";
                values.add("%" + ss[i] + "%");
            }
            sql += " ) ";
            statement = conn.prepareStatement(sql);
            for (int i = 0; i < values.size(); i++) {
                statement.setObject(i + 1, values.get(i));
            }
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setDiscountId(resultSet.getInt("discount_id"));
                product.setReviewsRate(resultSet.getInt("reviews_rate"));
                product.setTitle(resultSet.getString("title"));
                product.setDescription(resultSet.getString("description"));
                product.setStock(resultSet.getInt("stock"));
                product.setPrice(resultSet.getFloat("price"));
                product.setCreatedDate(resultSet.getDate("created_date"));
                product.setModifiedOn(resultSet.getDate("modified_on"));
                product.setCreatedBy(resultSet.getInt("created_by"));
                product.setModifiedBy(resultSet.getInt("modified_by"));
                product.setWarranty_months(resultSet.getInt("warranty_months"));
                product.setImages(getImagesByProductId(product.getProductId()));
                products.add(product);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
        }

        //System.out.println(product.toString());
        return products;
    }

    public List<Product> listProductsByDiscount(int discountid) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Product> listProduct = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT product_id FROM product WHERE discount_id = ?";
            statement = conn.prepareStatement(sql);
            if (discountid != 0) {
                statement.setInt(1, discountid);
            } else {
                statement.setNull(1, discountid);
            }
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                System.out.println(resultSet.getString("product_id"));
                listProduct.add(getProduct(resultSet.getInt("product_id")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }

    public List<Product> listProductsByCategory(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Product> listProduct = new ArrayList<>();

        if (id == 0) {
            return listAllProducts();
        }

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT product_id FROM product WHERE category_id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                System.out.println(resultSet.getString("product_id"));
                listProduct.add(getProduct(resultSet.getInt("product_id")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }

    public List<Product> listProductsByCategoryRelated(int cid, int pid) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Product> listProduct = new ArrayList<>();

        if (cid == 0 || pid == 0) {
            return listAllProducts();
        }

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT product_id FROM product WHERE category_id = ? AND product_id != ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, cid);
            statement.setInt(2, pid);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                System.out.println(resultSet.getString("product_id"));
                listProduct.add(getProduct(resultSet.getInt("product_id")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }

    public List<Product> listAllProducts() throws SQLException {
        Connection conn = null;
        Statement statement = null;
        ResultSet resultSet = null;
        List<Product> listProduct = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT product_id FROM product";
            statement = conn.createStatement();
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                listProduct.add(getProduct(resultSet.getInt("product_id")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }

    public boolean deleteProduct(Product product) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "DELETE FROM product where product_id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, product.getProductId());

            boolean rowDeleted = statement.executeUpdate() > 0;
            return rowDeleted;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public boolean deleteProductImageByPath(String path) throws SQLException {
        String sql = "DELETE FROM [dbo].[product_image]\n"
                + "      WHERE [url] = ?";
        boolean rowDeleted = false;
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setString(1, path);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (ClassNotFoundException e) {

        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return rowDeleted;
    }

    public boolean deleteProductImage(Product product) throws SQLException {
        String sql = "DELETE FROM [dbo].[product_image]\n"
                + "      WHERE [product_id] = ?";
        boolean rowDeleted = false;
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, product.getProductId());
            rowDeleted = statement.executeUpdate() > 0;
        } catch (ClassNotFoundException e) {

        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return rowDeleted;
    }

    public boolean updateProduct(Product product) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "UPDATE product SET category_id = ?, discount_id = ?, reviews_rate = ?, title = ?, description = ?, stock = ?, price = ?, created_date = ?, modified_on = ?, created_by = ?, modified_by = ?, warranty_months = ? WHERE product_id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, product.getCategoryId());
            statement.setInt(2, product.getDiscountId());
            if (product.getDiscountId() == 0) {
                statement.setNull(2, product.getDiscountId());
            } else {
                statement.setInt(2, product.getDiscountId());
            }
            statement.setInt(3, product.getReviewsRate());
            statement.setString(4, product.getTitle());
            statement.setString(5, product.getDescription());
            statement.setInt(6, product.getStock());
            statement.setFloat(7, product.getPrice());
            statement.setDate(8, new java.sql.Date(product.getCreatedDate().getTime()));
            statement.setDate(9, new java.sql.Date(product.getModifiedOn().getTime()));
            statement.setInt(10, product.getCreatedBy());
            statement.setInt(11, product.getModifiedBy());
            statement.setInt(12, product.getWarranty_months());
            statement.setInt(13, product.getProductId());

            boolean rowUpdated = statement.executeUpdate() > 0;
            return rowUpdated;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public void updateDecreaseQuantity(int quantity, int productid) throws SQLException {
        String sql = "UPDATE product SET stock = stock - ? WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            statement.setInt(1, quantity);
            statement.setInt(2, productid);
            statement.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public void updateIncreaseQuantity(int quantity, int productid) throws SQLException {
        String sql = "UPDATE product\n"
                + "SET stock = stock + ?\n"
                + "WHERE product_id = ?;";
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            statement.setInt(1, quantity);
            statement.setInt(2, productid);
            statement.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public void updateDiscountProductNull(int productid) throws SQLException {
        String sql = "UPDATE [dbo].[product]\n"
                + "   SET [discount_id] = NULL\n"
                + " WHERE [product_id] = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            statement.setInt(1, productid);
            statement.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public void updateDiscountProduct(int discountid, int productid) throws SQLException {
        String sql = "UPDATE [dbo].[product]\n"
                + "   SET [discount_id] = ?\n"
                + " WHERE [product_id] = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        try {
            conn = DBContext.getConnection(); // Obtain the connection
            statement = conn.prepareStatement(sql);
            statement.setInt(1, discountid);
            statement.setInt(2, productid);
            statement.executeUpdate();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
    }

    public boolean addProductQuantity(int quantity, int productid) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        boolean added = false;
        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE [dbo].[product]\n"
                    + "   SET [stock] = [stock] + ?\n"
                    + " WHERE [product_id] = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, quantity);
            statement.setInt(2, productid);
            added = statement.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (statement != null) {
                statement.close();
            }
        }
        return added;
    }

    public Product getProduct(int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        Product product = null;

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT * FROM product WHERE product_id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                product = new Product(productId,
                        resultSet.getInt("category_id"),
                        resultSet.getInt("discount_id"),
                        resultSet.getInt("reviews_rate"),
                        resultSet.getString("title"),
                        resultSet.getString("description"),
                        resultSet.getInt("stock"),
                        resultSet.getFloat("price"),
                        resultSet.getDate("created_date"),
                        resultSet.getDate("modified_on"),
                        resultSet.getInt("created_by"),
                        resultSet.getInt("modified_by"),
                        resultSet.getInt("warranty_months"));
                product.setImages(getImagesByProductId(productId));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
        }

        //System.out.println(product.toString());
        return product;
    }

    public List<String> getImagesByProductId(int product_id) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT url FROM product_image WHERE product_id = ?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, product_id);
            rs = statement.executeQuery();

            while (rs.next()) {
                String url = rs.getString("url");
                list.add(url);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (statement != null) {
                statement.close();
            }
        }

        return list;
    }

    public int getProductIdByDiscountId(int discountid) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT [product_id] FROM [dbo].[product] WHERE [discount_id] = ?";
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setInt(1, discountid);
            rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("product_id");
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }
        return 0;
    }

    public List<Product> getHotDealProducts(int numberOfProducts) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<Product> listProduct = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT TOP " + numberOfProducts + " p.product_id, p.title, p.price, COALESCE((p.price - (p.price * d.discount_value)), p.price) AS discounted_price FROM product p LEFT JOIN discount d ON p.discount_id = d.discount_id ORDER BY discounted_price ASC";
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();

            while (rs.next()) {
                listProduct.add(getProduct(rs.getInt("product_id")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }

    public Product getProductByTitle(String title) throws SQLException, ClassNotFoundException {
        Product product = null;
        title = title.trim().replaceAll("\\s+", " ");
        String sql = "SELECT * FROM product WHERE title = ?";
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            conn = DBContext.getConnection();
            statement = conn.prepareStatement(sql);
            statement.setString(1, title);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                product = new Product(resultSet.getInt("product_id"),
                        resultSet.getInt("category_id"),
                        resultSet.getInt("discount_id"),
                        resultSet.getInt("reviews_rate"),
                        title,
                        resultSet.getString("description"),
                        resultSet.getInt("stock"),
                        resultSet.getFloat("price"),
                        resultSet.getDate("created_date"),
                        resultSet.getDate("modified_on"),
                        resultSet.getInt("created_by"),
                        resultSet.getInt("modified_by"),
                        resultSet.getInt("warranty_months"));
                product.setImages(getImagesByProductId(product.getProductId()));
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return product;
    }

    public List<Product> getBestSellerProducts(int numberOfProducts) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<Product> listProduct = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT TOP " + numberOfProducts + " \n"
                    + "p.product_id, \n"
                    + "p.category_id,\n"
                    + "p.discount_id,\n"
                    + "p.reviews_rate,\n"
                    + "p.title, \n"
                    + "p.price,\n"
                    + "p.stock,\n"
                    + "p.created_date,\n"
                    + "COUNT(oi.product_id) \n"
                    + "AS total_sold \n"
                    + "FROM product p JOIN order_item oi ON p.product_id = oi.product_id \n"
                    + "GROUP BY p.product_id, p.category_id,\n"
                    + "p.discount_id, p.title, p.reviews_rate, p.price, p.stock, p.created_date ORDER BY total_sold DESC";
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();

            while (rs.next()) {
                // Retrieve product details directly without using getProduct method
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setDiscountId(rs.getInt("discount_id"));
                product.setReviewsRate(rs.getInt("reviews_rate"));
                product.setStock(rs.getInt("stock"));
                product.setTitle(rs.getString("title"));
                product.setPrice(rs.getFloat("price"));
                product.setCreatedDate(rs.getDate("created_date"));
                product.setImages(getImagesByProductId(rs.getInt("product_id")));
                listProduct.add(product);
            }

            if (listProduct.isEmpty()) {
                // Close the previous statement to avoid resource leak
                statement.close();
                // Reuse the connection and statement
                statement = conn.prepareStatement("SELECT TOP " + numberOfProducts + " p.product_id, p.title, p.price, p.created_date FROM product p ORDER BY p.created_date DESC");
                rs = statement.executeQuery();

                while (rs.next()) {
                    listProduct.add(getProduct(rs.getInt("product_id")));
                }
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }

    public List<Product> getNewArrivalProducts(int numberOfProducts) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        List<Product> listProduct = new ArrayList<>();

        try {
            conn = DBContext.getConnection(); // Obtain the connection
            String sql = "SELECT TOP " + numberOfProducts + " product_id, title, price, created_date FROM product ORDER BY created_date DESC";
            statement = conn.prepareStatement(sql);
            rs = statement.executeQuery();

            while (rs.next()) {
                listProduct.add(getProduct(rs.getInt("product_id")));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                DBContext.closeConnection(conn); // Close the connection
            }
        }

        return listProduct;
    }
    
    public static void main(String[] args) throws SQLException, ClassNotFoundException{
        for (Product p :new ProductDAO().listProductsMultipleChoice(0, 0, null, null, null, null, null, null, null, null, null, "Unrated")){
            System.out.println(p);
        }
    }

}
