package servlets;

import classes.JDBC;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet to remove a movie from the user's watchlist.
 */
@WebServlet("/RemoveFromWatchlistServlet")
public class RemoveFromWatchlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session and ensure user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get userId and filmId from the request
        int userId = (int) session.getAttribute("userId");
        int filmId = Integer.parseInt(request.getParameter("filmId"));

        // Initialize JDBC and call the removeFromWatchlist method
        JDBC jdbc = new JDBC();
        if (jdbc.isConnected) {
            boolean isRemoved = jdbc.removeFromWatchlist(userId, filmId);
            if (isRemoved) {
                response.getWriter().write("Success: Movie removed from watchlist.");
            } else {
                response.getWriter().write("Error: Failed to remove movie from watchlist."+ isRemoved);
            }
        } else {
            response.getWriter().write("Error: Database connection failed.");
        }

        // Close the database connection
        jdbc.disconnect();
    }
}
