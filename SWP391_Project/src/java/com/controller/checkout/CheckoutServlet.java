/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.checkout;

import java.sql.Date;
import com.controller.WebManager;
import com.model.Cart;
import com.model.CartItem;
import com.model.Customer;
import com.model.DAO.OrderDAO;
import com.model.DAO.OrderItemDAO;
import com.model.DAO.ProductDAO;
import com.model.DAO.ProductSerialNumberDAO;
import com.model.Inventory;
import com.model.InventoryItem;
import com.model.Order;
import com.model.OrderItem;
import com.model.Product;
import com.model.ProductSerialNumber;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Acer Nitro 5
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        if (customer == null) {
            response.sendRedirect("login_system.jsp"); // Redirect to login if user is not logged in
            return;
        } else {
            try {
                Cart cart = WebManager.getInstance().cartDAO.getCart(customer.getCustomerId());
                if (WebManager.getInstance().cartItemDAO.getCartItemsFromCart(cart.getCartId()).size() <= 0) {
                    out.println("<script>");
                    out.println("alert('The cart is not existed !');");
                    out.println("window.location.href = 'home';"); // Trở về trang managebrand khi người dùng ấn OK
                    out.println("</script>");
                    return;
                } else {
                    double total = 0;
                    for (CartItem c : WebManager.getInstance().cartItemDAO.getCartItemsFromCart(cart.getCartId())) {
                        if (WebManager.getInstance().productDAO.getProduct(c.getProductId()).getDiscountId() == 0) {
                            total += c.getQuantity() * WebManager.getInstance().productDAO.getProduct(c.getProductId()).getPrice();
                        } else {
                            total += c.getQuantity() * (WebManager.getInstance().productDAO.getProduct(c.getProductId()).getPrice()
                                    - WebManager.getInstance().productDAO.getProduct(c.getProductId()).getPrice()
                                    * WebManager.getInstance().discountDAO.getDiscount(WebManager.getInstance().productDAO.getProduct(c.getProductId()).getDiscountId()).getDiscountValue());
                        }
                    }

                    request.setAttribute("total", total);
                    request.setAttribute("cartItemList", WebManager.getInstance().cartItemDAO.getCartItemsFromCart(cart.getCartId()));
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            out.close();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        if (customer == null) {
            response.sendRedirect("home"); // Redirect to login if user is not logged in
            return;
        }
        LocalDate now = LocalDate.now();
        Date sqlDate = Date.valueOf(now);
        try {
            Cart cart = WebManager.getInstance().cartDAO.getCart(customer.getCustomerId());
            List<CartItem> cartitems = WebManager.getInstance().cartItemDAO.getCartItemsFromCart(cart.getCartId());
            OrderDAO orderDAO = WebManager.getInstance().orderDAO;
            OrderItemDAO orderItemDAO = WebManager.getInstance().orderItemDAO;
            ProductDAO productDAO = WebManager.getInstance().productDAO;
            ProductSerialNumberDAO productserialnumberDAO = WebManager.getInstance().productSerialNumberDAO;
            String paymentMethod = request.getParameter("paymentMethod");
            String voucherid = request.getParameter("voucherid");
            String totalprice = request.getParameter("totalprice");
            String saveInfo = request.getParameter("saveInfo");
            if (saveInfo != null) {
                customer.setAddress_line1(request.getParameter("address1"));
                customer.setAddress_line2(request.getParameter("address2"));
                customer.setCity(request.getParameter("city"));
                customer.setPostal_code(Integer.parseInt(request.getParameter("postal")));
                customer.setPhone_number(request.getParameter("phonenumber"));
                customer.setGmail(request.getParameter("email"));
                customer.setFirst_name(request.getParameter("firstname"));
                customer.setLast_name(request.getParameter("lastname"));
                if (customer.getCustomerType() == 1) {
                    customer.setCustomerType(2);
                }
                boolean isUpdated = WebManager.getInstance().customerDAO.updateCustomer(customer);
            } else {

            }
            Order order = new Order();
            order.setCustomerId(customer.getCustomerId());
            order.setAddressLine1(request.getParameter("address1"));
            order.setAddressLine2(request.getParameter("address2"));
            order.setCity(request.getParameter("city"));
            order.setOrderDate(sqlDate);
            order.setCreatedAt(sqlDate);
            order.setPaymentMethod(Integer.parseInt(paymentMethod));
            if (voucherid == null || voucherid.isEmpty()) {
                order.setVoucherId(0);
            } else {
                order.setVoucherId(Integer.parseInt(voucherid));
            }
            order.setPostalCode(request.getParameter("postal"));
            order.setPhoneNumber(request.getParameter("phonenumber"));
            order.setTotalPrice(Double.parseDouble(totalprice));
            order.setStatus(2);
            request.getSession().setAttribute("order", order);
            request.getSession().setAttribute("cartitems", cartitems);
            if (paymentMethod.equals("2")) {
                request.setAttribute("amount", (int)order.getTotalPrice());
                request.getRequestDispatcher("vnpay_pay.jsp").forward(request, response);
                return;
            }
            if (customer.getCustomerType() == 1) {
                customer.setCustomerType(2);
                WebManager.getInstance().customerDAO.updateCustomer(customer);
            }
            if (orderDAO.insert(order)) {
                List<OrderItem> orderItemList = new ArrayList<>();
                for (CartItem ci : cartitems) {
                    orderItemList.add(new OrderItem(orderDAO.getNewestOrderByCustomer(customer.getCustomerId()).getOrderId(),
                            ci.getProductId(),
                            ci.getQuantity(),
                            productDAO.getProduct(ci.getProductId()).getPrice()));
                }
                for (OrderItem oi : orderItemList) {
                    orderItemDAO.add(oi);
                }
                for (OrderItem ord : orderItemDAO.getOrderItemsByOrderId(orderDAO.getLastOrderReturnId())) {
                    int availableStock = WebManager.getInstance().productDAO.getProduct(ord.getProductId()).getStock();

                    if (ord.getQuantity() > availableStock) {
                        // If the quantity exceeds the available stock
                        productDAO.updateDecreaseQuantity(availableStock, ord.getProductId());
                        List<ProductSerialNumber> serialNumbers = productserialnumberDAO.getListTopSerialByProductId(ord.getProductId(), availableStock);

                        for (ProductSerialNumber psn : serialNumbers) {
                            psn.setProductId(ord.getProductId());
                            psn.setOrderItemId(ord.getOrderItemId());
                            productserialnumberDAO.update(psn);
                        }
                    } else {
                        // If the quantity is within the available stock
                        productDAO.updateDecreaseQuantity(ord.getQuantity(), ord.getProductId());
                        List<ProductSerialNumber> serialNumbers = productserialnumberDAO.getListTopSerialByProductId(ord.getProductId(), ord.getQuantity());

                        for (ProductSerialNumber psn : serialNumbers) {
                            psn.setProductId(ord.getProductId());
                            psn.setOrderItemId(ord.getOrderItemId());
                            productserialnumberDAO.update(psn);
                        }
                    }

                    // Update the stock value after the operation
                    availableStock = WebManager.getInstance().productDAO.getProduct(ord.getProductId()).getStock();

                    // If the product is out of stock, break out of the loop or handle as needed
                    if (availableStock <= 0) {
                        break; // Stop further processing if the product is out of stock
                    }
                }
                if (order.getVoucherId() == 0) {

                } else {
                    Inventory inventory = WebManager.getInstance().inventoryDAO.getInventoryByCustomerId(customer.getCustomerId());
                    InventoryItem item = WebManager.getInstance().inventoryItemDAO.getInventoryItemByInventoryAndVoucher(inventory.getInventoryId(), order.getVoucherId());
                    WebManager.getInstance().inventoryItemDAO.reduceInventoryItemAmount(item.getItemId(), 1);
                }
                WebManager.getInstance().cartItemDAO.deleteCartItems(WebManager.getInstance().cartDAO.getCart(customer.getId()).getCartId());
                WebManager.getInstance().cartDAO.deleteCartByCustomer(customer.getCustomerId());
                out.println("<script>");
                out.println("alert('Checkout sucessfully !');");
                out.println("window.location.href='home';");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('Cannot checkout !');");
                out.println("window.location.href='checkout';");
                out.println("</script>");
            }

        } catch (SQLException ex) {
            out.println("<script>");
            out.println("alert('Cannot checkout);");
            out.println("window.location.href='checkout';");
            out.println("</script>");
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            out.println("<script>");
            out.println("alert('Cannot checkout);");
            out.println("window.location.href='checkout';");
            out.println("</script>");
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            out.println("<script>");
            out.println("alert('Cannot checkout);");
            out.println("window.location.href='checkout';");
            out.println("</script>");
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        out.close();

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
