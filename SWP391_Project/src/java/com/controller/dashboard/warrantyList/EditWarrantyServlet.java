package com.controller.dashboard.warrantyList;


import com.model.DAO.ProductSerialNumberDAO;
import com.model.DAO.WarrantyDAO;
import com.model.Manager;

import com.model.ProductSerialNumber;
import com.model.Warranty;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kirit
 */
@MultipartConfig
@WebServlet(name = "EditWarrantyServlet", urlPatterns = {"/editWarranty"})
public class EditWarrantyServlet extends HttpServlet {

    private static final String IMAGE_UPLOAD_DIR = "media/warranty/";

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
            out.println("<title>Servlet EditWarrantyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditWarrantyServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String post_id_raw = request.getParameter("id");
            int id = 0;
            try {
                id = Integer.parseInt(post_id_raw);
            } catch (NumberFormatException e) {

            }
            WarrantyDAO WarrantyDAO = new WarrantyDAO();
            Warranty Warranty = WarrantyDAO.getWarranty(id);
            ProductSerialNumberDAO ProductSerialNumberDAO = new ProductSerialNumberDAO();
            String serviceTag = ProductSerialNumberDAO.getById(Warranty.getSerialNumberId()).getServiceTag();
            request.setAttribute("serviceTag", serviceTag);
            request.setAttribute("warranty", Warranty);
            request.getRequestDispatcher("editWarranty.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(EditWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            Date guaranteeDate = null;
            String serviceTag = request.getParameter("serviceTag");
            ProductSerialNumberDAO ProductSerialNumberDAO = new ProductSerialNumberDAO();
            ProductSerialNumber ProductSerialNumber = ProductSerialNumberDAO.getSerialNumberByServiceTag(serviceTag);
            String guaranteeDateStr = request.getParameter("guaranteeDate");
            String status = request.getParameter("status");

            Part imagesParameter = request.getPart("images");

            String type = request.getParameter("warrantyType");
            int warrantyType = (type != null && !type.isEmpty()) ? Integer.parseInt(type) : 2;
            int id = Integer.parseInt(request.getParameter("id"));
            guaranteeDate = ((guaranteeDateStr == null) || (guaranteeDateStr.equals("")))
                ? null : Date.valueOf(guaranteeDateStr);
            
            WarrantyDAO WarrantyDAO = new WarrantyDAO();
            Warranty warranty = WarrantyDAO.getWarranty(id);
            warranty.setSerialNumberId(ProductSerialNumber.getSerialNumberId());
            warranty.setGuaranteeDate(guaranteeDate);
            Manager manager =(Manager) request.getSession().getAttribute("manager");
            warranty.setModifiedBy(manager.getManagerId());
            warranty.setWarrantyType(warrantyType);
     
            warranty.setStatus(status);
            warranty.setIsDone(Boolean.valueOf(request.getParameter("isDone")));
            if (imagesParameter != null && imagesParameter.getSize()>0) {
                Collection<Part> parts = request.getParts();
                StringBuilder imagePaths = new StringBuilder();
                for (Part part : parts) {
                    if (part.getName().equals("images") && part.getSize() > 0) {
                        String imagePath = saveImage(request, part);
                        if (imagePaths.length() > 0) {
                            imagePaths.append(",");
                        }
                        imagePaths.append(imagePath);
                    }
                }
                warranty.setImages(imagePaths.toString());
            }
            WarrantyDAO.updateWarranty(warranty);
        } catch (SQLException ex) {
            Logger.getLogger(AddWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddWarrantyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("manageWarranty");
    }

    private String saveImage(HttpServletRequest request, Part image) throws IOException {
        String imageName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
        String imagePath = IMAGE_UPLOAD_DIR + imageName;
        String fullPath = request.getServletContext().getRealPath(imagePath);
        image.write(fullPath);
        return imagePath;
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
