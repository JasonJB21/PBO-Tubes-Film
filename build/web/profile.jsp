<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="classes.JDBC, java.util.*" %>
<%
    // Periksa sesi pengguna
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("signIn.jsp");
        return;
    }

    Integer userId = (Integer) userSession.getAttribute("userId");
    JDBC jdbc = null;
    Map<String, Object> userProfile = new HashMap<>();
    List<Map<String, Object>> watchlist = new ArrayList<>();

    try {
        // Inisialisasi JDBC
        jdbc = new JDBC();

        // Ambil data profil pengguna
        userProfile = jdbc.getUserProfile(userId);

        // Ambil watchlist pengguna
        watchlist = jdbc.getWatchlist(userId);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (jdbc != null) {
            jdbc.disconnect();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="Styles/profile.css">
</head>
<body>
    <nav>
        <img src="Images/logo.png" alt="Logo" />
        <a href="indexPengguna.jsp">MOVIES</a>
        <a href="myReview.jsp">MY REVIEW</a>
        <a href="profile.jsp">PROFILE</a>
        <a href="watchlist.jsp">WATCHLIST</a>
    </nav>

    <div class="container">
        <h1>Profile</h1>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" id="email" value="<%= userProfile.get("email") %>" readonly>
        </div>
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" value="<%= userProfile.get("username") %>" readonly>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" value="<%= userProfile.get("password") %>" readonly>
        </div>
        <div class="form-group">
            <label for="umur">Umur</label>
            <input type="text" id="umur" value="<%= userProfile.get("umur") %>" readonly>
        </div>
        <div class="form-group">
            <label for="asalNegara">Asal Negara</label>
            <input type="text" id="asalNegara" value="<%= userProfile.get("asalNegara") %>" readonly>
        </div>
    </div>

    <div class="movies-list">
        <h1 class="section-title">My Watchlist</h1>
        <div class="genres-list">
            <% if (watchlist != null && !watchlist.isEmpty()) {
                for (Map<String, Object> film : watchlist) { %>
                    <div class="genre-item">
                        <p><strong>Judul:</strong> <%= film.get("judul") %></p>
                        <p><strong>Durasi:</strong> <%= film.get("duration") %> menit</p>
                        <p><strong>Rating:</strong> <%= String.format("%.1f", film.get("rating")) %></p>
                        <p><strong>Sutradara:</strong> <%= film.get("sutradara") %></p>
                        <p><strong>Genre:</strong> <%= film.get("genre") %></p>
                    </div>
            <% } } else { %>
                <p>Your watchlist is empty.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
