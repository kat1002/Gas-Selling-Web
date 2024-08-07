/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller.dashboard.order_management;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.OutputStream;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ExportOrderDetailServlet", urlPatterns = {"/exportorderdetail"})
public class ExportOrderDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportOrderDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportOrderDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        processRequest(request, response);
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
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"order_detail.pdf\"");

        try (OutputStream out = response.getOutputStream()) {
            // Tạo đối tượng Document của iText PDF
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Thêm nội dung vào PDF từ request
            String customerName = request.getParameter("customerName");
            String customerTel = request.getParameter("customerTel");
            String customerAddress1 = request.getParameter("customerAddress1");
            String customerAddress2 = request.getParameter("customerAddress2");
            String orderId = request.getParameter("orderId");
            String orderDate = request.getParameter("orderDate");

            // Thêm dữ liệu vào PDF
            Paragraph title = new Paragraph("BLAZO GAS/STOVE ONLINE STORE", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18));
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(Chunk.NEWLINE);

            document.add(new Paragraph("Customer Name: " + customerName));
            document.add(new Paragraph("Customer Tel: " + customerTel));
            document.add(new Paragraph("Customer Address 1: " + customerAddress1));
            document.add(new Paragraph("Customer Address 2: " + customerAddress2));
            document.add(new Paragraph("Order ID: " + orderId));
            document.add(new Paragraph("Order Date: " + orderDate));
            document.add(Chunk.NEWLINE);

            // Đóng document và hoàn thành việc tạo PDF
            document.close();
        } catch (DocumentException | IOException e) {
            throw new ServletException("Exception in generating PDF", e);
        }
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
