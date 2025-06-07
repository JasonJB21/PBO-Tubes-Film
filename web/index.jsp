<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Review Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="Styles/index.css">
</head>
<body>
    <nav>
        <img src="Images/logo.png" alt="Logo" />
        <a href="signUp.jsp">CREATE ACCOUNT</a>
        <a href="#movies-section">MOVIES</a>
        <a href="#genres-section">GENRES</a>
        <a href="signIn.jsp">SIGN IN</a>
    </nav>

    <section>
        <div class="hero">
            <div class="hero-left">
                <h1>Bagikan Pendapatmu, Temukan Perspektif Baru.</h1>
                <h2>"Bagikan ulasan film favoritmu dan temukan perspektif baru dari sesama pecinta film. Jadilah bagian dari komunitas ini sekarang!"</h2>
                <a href="#">Ayo Mulai!</a>
            </div>
            <img src="Images/gambar.png" alt="Hero Image" />
        </div>
    </section>

    <div class="container" id="movies-section">
        <h1 class="section-title">MOVIES</h1>
        <div class="movies">
            <a href="signUp.jsp">
                <div class="movie">
                    <img src="Images/interstellar.jpg" alt="Interstellar">
                    <p>Interstellar</p>
                </div>
            </a>
            <a href="signUp.jsp">
                <div class="movie">
                    <img src="Images/back-to-future.jpg" alt="Back To The Future">
                    <p>Back To The Future</p>
                </div>
            </a>
            <a href="signUp.jsp">
                <div class="movie">
                    <img src="Images/jaws.jpg" alt="Jaws">
                    <p>Jaws</p>
                </div>
            </a>
            <a href="signUp.jsp">
                <div class="movie">
                    <img src="Images/joker.jpg" alt="Joker">
                    <p>Joker</p>
                </div>
            </a>
            <a href="signUp.jsp">
                <div class="movie">
                    <img src="Images/shutter-island.jpg" alt="Shutter Island">
                    <p>Shutter Island</p>
                </div>
            </a>
        </div>
    </div>

    <div class="container" id="genres-section">
        <h1 class="section-title">GENRES</h1>
        <div class="genres-list">
            <%
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Koneksi ke database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/tubes_pbo", "root", "");
                    statement = connection.createStatement();
                    String query = "SELECT judul, genre FROM film"; // Mengambil data dari kolom judul dan genre
                    resultSet = statement.executeQuery(query);

                    // Looping untuk menampilkan data genre
                    while (resultSet.next()) {
                        String judul = resultSet.getString("judul");
                        String genre = resultSet.getString("genre");
            %>
                        <div class="genre-item">
                            <p><strong>Judul:</strong> <%= judul %></p>
                            <p><strong>Genre:</strong> <%= genre %></p>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    // Menutup koneksi
                    if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                    if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                }
            %>
        </div>
    </div>
    <section class="ranking-section">
        <h2 class="section-title">Top Films</h2>
        <div class="ranking-container">
            <!-- Film 1 -->
            <div class="ranking-card">
                <div class="ranking-number">#1</div>
                <img class="ranking-poster" src="Images/interstellar.jpg" alt="Interstellar Poster">
                <h3 class="ranking-title">Interstellar</h3>
                <p class="ranking-rating">⭐ 4.9</p>
            </div>
            <!-- Film 2 -->
            <div class="ranking-card">
                <div class="ranking-number">#2</div>
                <img class="ranking-poster" src="Images/joker.jpg" alt="Joker Poster">
                <h3 class="ranking-title">Joker</h3>
                <p class="ranking-rating">⭐ 4.8</p>
            </div>
            <!-- Film 3 -->
            <div class="ranking-card">
                <div class="ranking-number">#3</div>
                <img class="ranking-poster" src="Images/back-to-future.jpg" alt="Back to the Future Poster">
                <h3 class="ranking-title">Back to the Future</h3>
                <p class="ranking-rating">⭐ 4.7</p>
            </div>
            <!-- Film 4 -->
            <div class="ranking-card">
                <div class="ranking-number">#4</div>
                <img class="ranking-poster" src="Images/jaws.jpg" alt="Jaws Poster">
                <h3 class="ranking-title">Jaws</h3>
                <p class="ranking-rating">⭐ 4.6</p>
            </div>
            <!-- Film 5 -->
            <div class="ranking-card">
                <div class="ranking-number">#5</div>
                <img class="ranking-poster" src="Images/shutter-island.jpg" alt="Shutter Island Poster">
                <h3 class="ranking-title">Shutter Island</h3>
                <p class="ranking-rating">⭐ 4.5</p>
            </div>
        </div>
    </section>
</body>
</html>
