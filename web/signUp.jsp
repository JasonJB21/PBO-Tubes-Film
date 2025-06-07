<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Outfit', sans-serif;
            display: flex;
            height: 100vh;
        }

        .split {
            width: 50%;
            height: 100%;
        }

        /* Kiri: Form Sign Up */
        .kiri {
            background-color: #fff;
            padding: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .text {
            width: 100%;
            max-width: 400px;
            text-align: left;
        }

        .signup-heading {
            color: #8d0000;
            font-size: 48px;
            font-weight: 700;
            align-self: center;
            margin-bottom: 40px;
        }

        .form-label {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .input-field {
            border-radius: 15px;
            background-color: #fff;
            display: flex;
            margin-top: 8px;
            height: 39px;
            border: 1px solid #000;
            padding-left: 15px;
            width: 100%;
        }

        .submit-button {
            border-radius: 14px;
            background-color: #8d0000;
            align-self: center;
            margin-top: 37px;
            width: 184px;
            max-width: 100%;
            font-size: 20px;
            color: #fff;
            font-weight: 700;
            padding: 10px 55px 18px;
            border: none;
            cursor: pointer;
        }

        /* Kanan: Gradient */
        .kanan {
            background: linear-gradient(to bottom right, #000000, #FF0000); /* Gradient dari kiri atas ke kanan bawah */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @media (max-width: 991px) {
            .split {
                width: 100%;
                height: 50%;
            }
            .kiri, .kanan {
                height: 100%;
            }
        }
    </style>
    <title>Sign Up</title>
</head>
<body>
    <div class="split kiri">
        <div class="text">
            <h1 class="signup-heading">SIGN UP</h1>
            <form method="POST" action="signup"> <!-- Form mengarah ke servlet /signup -->
                <!-- Email -->
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" name="email" class="input-field" required><br>

                <!-- Username -->
                <label for="username" class="form-label">Username:</label>
                <input type="text" id="username" name="username" class="input-field" required><br>

                <!-- Password -->
                <label for="password" class="form-label">Password:</label>
                <input type="password" id="password" name="password" class="input-field" required><br>

                <!-- Umur -->
                <label for="umur" class="form-label">Umur:</label>
                <input type="number" id="umur" name="umur" class="input-field" min="1" max="120" required><br>

                <!-- Asal Negara -->
                <label for="asalNegara" class="form-label">Asal Negara:</label>
                <input type="text" id="asalNegara" name="asalNegara" class="input-field" required><br>

                <!-- Submit Button -->
                <button type="submit" class="submit-button">Daftar</button>
            </form>

            <!-- Menampilkan pesan hasil dari backend -->
            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
                <div class="message">
                    <%= message %>
                </div>
            <% } %>
        </div>
    </div>


    <div class="split kanan">
        <!-- Bagian kanan dengan gradient -->
    </div>
</body>
</html>
