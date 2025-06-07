/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author rafly
 */
@WebServlet(name = "submitReview", urlPatterns = {"/submitReview"})
public class submitReview extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mengatur tipe konten
        response.setContentType("text/html;charset=UTF-8");

        // Mengambil parameter dari form
        int rating;
        String pesan = request.getParameter("review");
        String pengirim = request.getParameter("pengirim");
        int filmId;

        try {
            rating = Integer.parseInt(request.getParameter("rating"));
            filmId = Integer.parseInt(request.getParameter("filmId"));
        } catch (NumberFormatException e) {
            System.err.println("Invalid input: " + e.getMessage());
            response.sendRedirect("indexPengguna.jsp?error=Invalid+input");
            return;
        }

        // Validasi rating
        if (rating < 1 || rating > 5) {
            response.sendRedirect("indexPengguna.jsp?error=Rating+must+be+between+1+and+5");
            return;
        }

        // Menyimpan review ke database
        JDBC jdbc = new JDBC();
        boolean isSuccess = jdbc.submitReview(rating, pesan, pengirim, filmId);

        // Redirect ke indexPengguna.jsp berdasarkan hasil
        if (isSuccess) {
            response.sendRedirect("indexPengguna.jsp?success=Review+submitted");
        } else {
            response.sendRedirect("indexPengguna.jsp?error=Failed+to+submit+review");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet untuk menangani submit review";
    }
}


