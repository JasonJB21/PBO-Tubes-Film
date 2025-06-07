/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author rafly
 */
@WebServlet(name = "InterstellarReviewServlet", urlPatterns = {"/Interstellar"})
public class InterstellarReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int filmId = 1; // ID untuk film Interstellar

        JDBC jdbc = new JDBC();
        List<Map<String, Object>> reviews = jdbc.getReviewsByFilmId(filmId);

        // Debugging
        System.out.println("Reviews fetched: " + reviews.size());

        // Teruskan data ulasan ke JSP
        request.setAttribute("reviews", reviews);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Interstellar.jsp");
        dispatcher.forward(request, response);
    }
}



