<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jaws Review</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <style>
        /* Navigation Bar */
        nav {
            display: flex;
            justify-content: center;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            gap: 2.5rem;
            background-color: white;
        }

        nav img {
            height: 30px;
            width: 10%;
        }

        nav a {
            font-family: 'Montserrat', sans-serif;
            font-weight: bold;
            color: #FF0000;
            text-decoration: none;
        }

        nav a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
    <nav>
        <img src="Images/logo.png" alt="Logo" />
        <a href="indexPengguna.jsp">MOVIES</a>
        <a href="">MY REVIEW</a>
        <a href="watchlist.jsp">WATCHLIST</a>
        <a href="profile.jsp">PROFILE</a>
    </nav>

    <div class="movie-header bg-white shadow rounded-lg p-6 m-6 flex">
        <img src="Images/jaws.jpg" alt="Jaws Movie Poster" class="w-64 h-auto rounded-md shadow-md">
        <div class="details ml-6">
            <h1 class="text-2xl font-bold text-gray-800">Jaws 
                <a href="reviewJaws.jsp" class="ml-4 px-4 py-2 bg-blue-500 text-white rounded-md shadow hover:bg-blue-600">Review</a>
            </h1>
            <div class="synopsis mt-4">
                <h2 class="text-xl font-semibold text-gray-700">Sinopsis :</h2>
                <p class="mt-2 text-gray-600">Ketika seorang perenang muda ditemukan tewas di pantai sebuah kota kecil, polisi kepala Martin Brody menduga hiu putih besar adalah pelakunya. Namun, upaya untuk menutup pantai menghadapi tentangan dari walikota dan penduduk setempat yang khawatir akan dampaknya terhadap pariwisata. Ketika serangan berikutnya terjadi, Brody bekerja sama dengan ahli biologi laut Matt Hooper dan pemburu hiu Quint untuk memburu predator mematikan tersebut. Film ini adalah perjalanan mendebarkan tentang ketakutan, keberanian, dan kekuatan alam yang tak terduga.</p>
            </div>
            <!-- Watchlist Button -->
            <form action="addToWatchlist" method="POST" class="mt-6">
                <input type="hidden" name="filmId" value="3"> <!-- Film ID for Jaws -->
                <% 
                    // Get pengguna_id from session
                    Integer userId = (Integer) session.getAttribute("userId");
                    if (userId != null) { 
                %>
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <button type="submit" class="px-6 py-2 bg-red-500 text-white font-semibold rounded-md shadow hover:bg-red-600">
                        Add to Watchlist
                    </button>
                <% } else { %>
                    <p class="text-red-500 mt-4">Please log in to add this movie to your watchlist.</p>
                <% } %>
            </form>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="reviews-section bg-white shadow rounded-lg p-6 m-6">
        <h2 class="text-xl font-bold text-gray-800">Reviews</h2>
        <%
            // Hardcoded film_id = 3 for Jaws
            int filmId = 3;
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            List<Map<String, Object>> reviews = new ArrayList<>();

            try {
                // Koneksi ke database
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/tubes1_pbo", "root", "");

                // Query untuk mengambil ulasan berdasarkan film_id
                String query = "SELECT pengirim, rating, pesan FROM ulasan WHERE film_id = ?";
                statement = connection.prepareStatement(query);
                statement.setInt(1, filmId);
                resultSet = statement.executeQuery();

                // Loop melalui hasil query dan tambahkan ke daftar ulasan
                while (resultSet.next()) {
                    Map<String, Object> review = new HashMap<>();
                    review.put("pengirim", resultSet.getString("pengirim"));
                    review.put("rating", resultSet.getInt("rating"));
                    review.put("pesan", resultSet.getString("pesan"));
                    reviews.add(review);
                }
                request.setAttribute("reviews", reviews);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Menutup koneksi
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <%-- Menampilkan ulasan di halaman --%>
        <% if (reviews != null && !reviews.isEmpty()) { %>
            <% for (Map<String, Object> review : reviews) { %>
                <div class="review-item mt-4">
                    <p class="text-gray-700"><strong><%= review.get("pengirim") %></strong> - Rating: <%= review.get("rating") %>/5</p>
                    <p class="text-gray-600 mt-2"><%= review.get("pesan") %></p>
                </div>
            <% } %>
        <% } else { %>
            <p class="text-gray-500 mt-4">No reviews available for this movie.</p>
        <% } %>
    </div>
    
    <div class="recommended-movies bg-white shadow rounded-lg p-6 m-6">
            <h2 class="text-xl font-bold text-gray-800">Recommended Movies</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-4">
                <!-- Movie 1 -->
                <a href="Interstellar.jsp" class="movie-item hover:shadow-lg text-center">
                    <img src="Images/interstellar.jpg" alt="Interstellar Movie Poster" class="w-58 h-auto mx-auto">
                    <h3 class="text-lg font-semibold mt-0">Interstellar</h3>
                    <p class="text-gray-600 mt-3">A mind-bending thriller by Christopher Nolan.</p>
                </a>
                <!-- Movie 2 -->
                <a href="ShutterIsland.jsp" class="movie-item hover:shadow-lg text-center text-center">
                    <img src="Images/shutter-island.jpg" alt="Back to the Future Movie Poster" class="w-58 h-auto mx-auto ">
                    <h3 class="text-lg font-semibold mt-0">Back To The Future</h3>
                    <p class="text-gray-600 mt-3">is a 1985 science fiction film directed by Robert Zemeckis.</p>
                </a>
                <!-- Movie Item 3 -->
                <a href="BackToTheFuture.jsp" class="movie-item hover:shadow-lg text-center text-center">
                    <img src="Images/back-to-future.jpg" alt="Jaws Movie Poster" class="w-58 h-auto mx-auto">
                    <h3 class="text-lg font-semibold mt-0">Back To The Future</h3>
                    <p class="text-gray-600 mt-3">Shutter Island thriller film directed by Martin Scorsese.</p>
                </a>
                <!-- Movie 4 -->
                <a href="Joker.jsp" class="movie-item hover:shadow-lg text-center text-center">
                    <img src="Images/joker.jpg" alt="Shutter Island Movie Poster" class="w-58 h-auto mx-auto ">
                    <h3 class="text-lg font-semibold mt-0">Joker</h3>
                    <p class="text-gray-600 mt-3">A cult classic exploring identity and chaos.</p>
                </a>
            </div>
        </div>
</body>
</html>
