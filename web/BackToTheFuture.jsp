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
    <title>Back To The Future Review</title>
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
        <img src="Images/back-to-future.jpg" alt="Back To The Future Movie Poster" class="w-64 h-auto rounded-md shadow-md">
        <div class="details ml-6">
            <h1 class="text-2xl font-bold text-gray-800">Back To the Future 
                <a href="reviewBackToTheFuture.jsp" class="ml-4 px-4 py-2 bg-blue-500 text-white rounded-md shadow hover:bg-blue-600">Review</a>
            </h1>
            <div class="synopsis mt-4">
                <h2 class="text-xl font-semibold text-gray-700">Sinopsis :</h2>
                <p class="mt-2 text-gray-600">Marty McFly adalah seorang remaja biasa yang secara tidak sengaja dikirim ke masa lalu tahun 1955 dengan mesin waktu yang diciptakan oleh ilmuwan eksentrik, Dr. Emmett Brown. Di tahun tersebut, Marty tanpa sengaja mencegah pertemuan pertama kedua orang tuanya, yang menyebabkan risiko dirinya tidak akan pernah lahir. Untuk memperbaiki keadaan, Marty harus menemukan cara agar orang tuanya jatuh cinta kembali sambil berjuang untuk kembali ke tahun 1985. Petualangan ini penuh dengan humor, ketegangan, dan pelajaran tentang pentingnya keberanian dan keluarga.</p>
            </div>
            <!-- Watchlist Button -->
            <form action="addToWatchlist" method="POST" class="mt-6">
                <input type="hidden" name="filmId" value="2"> <!-- Film ID for Back to the Future -->
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
            // Hardcoded film_id = 2 for Back to the Future
            int filmId = 2;
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
                  <h3 class="text-lg font-semibold mt-0">Shutter Island</h3>
                  <p class="text-gray-600 mt-3">Shutter Island thriller film directed by Martin Scorsese.</p>
              </a>
              <!-- Movie Item 3 -->
              <a href="Jaws.jsp" class="movie-item hover:shadow-lg text-center text-center">
                  <img src="Images/jaws.jpg" alt="Jaws Movie Poster" class="w-58 h-auto mx-auto">
                  <h3 class="text-lg font-semibold mt-0">Jaws</h3>
                  <p class="text-gray-600 mt-3">Jaws is a 1975 thriller film directed by Steven Spielberg.</p>
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
