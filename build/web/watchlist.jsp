<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="classes.JDBC, java.util.*" %>
<%
    // Get the session and check if user is logged in
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("signIn.jsp");
        return;
    }

    Integer userId = (Integer) userSession.getAttribute("userId");
    JDBC jdbc = null;
    List<Map<String, Object>> watchlist = new ArrayList<>();

    try {
        // Initialize JDBC connection
        jdbc = new JDBC();

        // Get user's watchlist
        watchlist = jdbc.getWatchlist(userId);

        // Handle sorting
        String sortBy = request.getParameter("sortBy");
        if (sortBy != null && !watchlist.isEmpty()) {
            switch (sortBy) {
                case "title":
                    Collections.sort(watchlist, new Comparator<Map<String, Object>>() {
                        public int compare(Map<String, Object> a, Map<String, Object> b) {
                            String titleA = (String) a.get("judul");
                            String titleB = (String) b.get("judul");
                            return titleA.compareTo(titleB);
                        }
                    });
                    break;
                case "rating":
                    Collections.sort(watchlist, new Comparator<Map<String, Object>>() {
                        public int compare(Map<String, Object> a, Map<String, Object> b) {
                            Float ratingA = (Float) a.get("rating");
                            Float ratingB = (Float) b.get("rating");
                            return ratingB.compareTo(ratingA); // Descending order
                        }
                    });
                    break;
            }
        }
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
    <!-- Rest of your HTML code remains the same until the script section -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Watchlist</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#ff0000'
                        }
                    }
                }
            }
        </script>
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
    <body>
        <!-- Your existing nav section -->
        <nav>
            <img src="Images/logo.png" alt="Logo" />
            <a href="indexPengguna.jsp">MOVIES</a>
            <a href="">MY REVIEW</a>
            <a href="watchlist.jsp">WATCHLIST</a>
            <a href="profile.jsp">PROFILE</a>
        </nav>
        <!-- Main Content -->
        <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <!-- Sort Controls -->
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-3xl font-bold text-gray-900">My Watchlist</h1>
                <div class="flex space-x-4">
                    <form action="watchlist.jsp" method="get" class="flex items-center">
                        <select name="sortBy" onchange="this.form.submit()" 
                                class="bg-white text-gray-900 px-4 py-2 rounded-md border border-gray-300 focus:border-primary focus:ring-1 focus:ring-primary">
                            <option value="">Sort by Date Added</option>
                            <option value="rating" <%= "rating".equals(request.getParameter("sortBy")) ? "selected" : ""%>>Sort by Rating</option>
                            <option value="title" <%= "title".equals(request.getParameter("sortBy")) ? "selected" : ""%>>Sort by Title</option>
                        </select>
                    </form>
                </div>
            </div>

            <!-- Watchlist Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <% if (watchlist != null && !watchlist.isEmpty()) {
                    for (Map<String, Object> film : watchlist) {%>
                <div id="film-<%= film.get("id")%>" class="movie-card bg-white rounded-lg overflow-hidden shadow-md border border-gray-200 hover:border-primary hover:shadow-lg transition-all duration-300">
                    <div class="p-6">
                        <div class="flex justify-between items-start mb-4">
                            <div>
                                <h3 class="text-xl font-bold text-gray-900 mb-2"><%= film.get("judul")%></h3>
                                <div class="flex items-center space-x-3 text-sm">
                                    <span class="bg-primary/10 text-primary px-2 py-1 rounded font-medium">
                                        <%= String.format("%.1f", film.get("rating"))%> ★
                                    </span>
                                    <span class="text-gray-600"><%= film.get("duration")%> min</span>
                                </div>
                            </div>
                            <button onclick="removeFromWatchlist(<%= film.get("id")%>)" 
                                    class="text-gray-400 hover:text-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                </svg>
                            </button>
                        </div>

                        <p class="text-gray-600 text-sm mb-4 line-clamp-2"><%= film.get("deskripsi")%></p>

                        <div class="space-y-2 mb-4">
                            <div class="flex items-start">
                                <span class="text-gray-500 w-20 flex-shrink-0">Director:</span>
                                <span class="text-gray-900"><%= film.get("sutradara")%></span>
                            </div>
                            <div class="flex items-start">
                                <span class="text-gray-500 w-20 flex-shrink-0">Cast:</span>
                                <span class="text-gray-900"><%= film.get("cast")%></span>
                            </div>
                            <div class="flex items-start">
                                <span class="text-gray-500 w-20 flex-shrink-0">Genre:</span>
                                <span class="text-gray-900"><%= film.get("genre")%></span>
                            </div>
                        </div>

                    </div>
                </div>
                <% }
                    }%>
            </div>

            <!-- Empty State - Updated condition -->
            <div id="empty-state" class="<%= watchlist.isEmpty() ? "" : "hidden"%> text-center py-16">
                <div id="empty-state" class="<%= watchlist == null || watchlist.isEmpty() ? "" : "hidden"%> text-center py-16">
                    <div class="w-16 h-16 mx-auto mb-4 rounded-full bg-gray-100 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-medium text-gray-900 mb-2">Your watchlist is empty</h3>
                    <p class="text-gray-600 mb-4">Start adding movies to keep track of what you want to watch</p>
                    <a href="browse-movies.jsp" 
                       class="inline-block bg-primary text-white px-6 py-3 rounded-md hover:bg-red-700 transition-colors duration-300">
                        Browse Movies
                    </a>
                </div>
        </main>
        <script>

            function removeFromWatchlist(filmId) {
                fetch('RemoveFromWatchlistServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'filmId=' + filmId
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                alert('Film removed from your watchlist successfully!');
                                window.location.reload(); // Refresh the page
                            } else {
                                alert('Failed to remove from watchlist: ' + (data.message || 'Unknown error'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            window.location.reload(); // Optionally refresh the page in case of an error
                        });
            }

        </script>
    </body>
</html>