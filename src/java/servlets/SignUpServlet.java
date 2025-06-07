/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Mengambil parameter dari form
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String asalNegara = request.getParameter("asalNegara");
        int umur;

        try {
            umur = Integer.parseInt(request.getParameter("umur"));
            System.out.println("Received data: email=" + email + ", username=" + username + ", password=" + password +
                    ", umur=" + umur + ", asalNegara=" + asalNegara);
        } catch (NumberFormatException e) {
            System.err.println("Invalid age input: " + request.getParameter("umur"));
            response.sendRedirect("signUp.jsp?error=Invalid+age");
            return;
        }

        // Membuat instance JDBC dan memanggil method signUp
        JDBC jdbc = new JDBC();
        boolean isSuccess = jdbc.signUp(email, username, password, umur, asalNegara);

        if (isSuccess) {
            response.sendRedirect("signIn.jsp");
        } else {
            response.sendRedirect("signUp.jsp?error=Signup+failed");
        }
    }
}
