package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import classes.JDBC;

@WebServlet("/addToWatchlist")
public class addToWatchlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String filmIdParam = request.getParameter("filmId");
        String userIdParam = request.getParameter("userId");

        int filmId;
        int userId;
        filmId = Integer.parseInt(filmIdParam);
        userId = Integer.parseInt(userIdParam);


        JDBC jdbc = new JDBC();
        if (jdbc.isConnected) {
            boolean added = jdbc.addToWatchlist(userId, filmId);
            jdbc.disconnect();

            if (added) {
                response.getWriter().write("<script>alert('Successfully added to watchlist!'); window.history.back();</script>");
            } else {
                response.getWriter().write("<script>alert('Failed to add to watchlist!'); window.history.back();</script>");
            }
        } else {
            response.getWriter().write("<script>alert('Database connection failed!'); window.history.back();</script>");
        }
    }
}
