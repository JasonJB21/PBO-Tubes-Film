<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Film - Shutter Island</title>
    <link rel="stylesheet" href="Styles/DesignReviewFilm.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <nav>
        <img src="Images/logo.png" alt="Logo" />
        <a href="indexPengguna.jsp">MOVIES</a>
        <a href="">MY REVIEW</a>
        <a href="watchlist.jsp">WATCHLIST</a>
        <a href="profile.jsp">PROFILE</a>
    </nav>

    <div class="container" id="review-section">
        <div class="poster">
            <img src="Images/shutter-island.jpg" alt="Shutter Island Poster">
        </div>

        <div class="review-form">
            <h1 class="section-title">Review Film: Shutter Island</h1>
            <form action="submitReview" method="POST"> <!-- Arahkan ke servlet -->
                <input type="hidden" name="filmId" value="5"> <!-- ID film untuk Shutter Island -->

                <div class="rating">
                    <label for="rating">Rating (1-10):</label>
                    <input type="number" id="rating" name="rating" min="1" max="10" required>
                </div>

                <label for="pengirim">Pengirim:</label>
                <input type="text" id="pengirim" name="pengirim" class="input-field" placeholder="Your Name" required><br>

                <textarea name="review" class="review-textarea" placeholder="Write your review here..." required></textarea>

                <button type="submit" class="submit-btn">Submit Review</button>
            </form>
        </div>
    </div>
</body>
</html>
