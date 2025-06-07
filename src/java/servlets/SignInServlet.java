package servlets;

import classes.JDBC;
import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        JDBC jdbc = new JDBC();
        Map<String, Object> loginResult = jdbc.login(username, password);
        
        if ((Boolean) loginResult.get("success")) {
            // Create new session
            HttpSession session = request.getSession(true);
            
            // Store user data in session
            session.setAttribute("userId", loginResult.get("userId"));
            session.setAttribute("username", loginResult.get("username"));
            session.setAttribute("email", loginResult.get("email"));
            session.setAttribute("isLoggedIn", true);
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Redirect to dashboard
            response.sendRedirect("indexPengguna.jsp");
        } else {
            // Login failed
            request.setAttribute("error", "Username atau Password salah. Coba lagi.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("signIn.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Add logout functionality
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // Destroy the session
            }
            response.sendRedirect("signIn.jsp");
        }
    }
}