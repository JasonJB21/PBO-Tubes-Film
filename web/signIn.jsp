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

        .error-message {
            color: red;
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
    <title>Sign In</title>
</head>
<body>
    <div class="split kiri">
        <div class="text">
            <h1 class="signup-heading">SIGN IN</h1>
            
            <form method="post" action="signin">
                <label for="username" class="form-label">Username</label><br>
                <input type="text" id="username" name="username" class="input-field" placeholder="Masukkan username" required><br>

                <label for="password" class="form-label">Password</label><br>
                <input type="password" id="password" name="password" class="input-field" placeholder="Masukkan kata sandi" required><br>
                <button type="submit" class="submit-button">Sign In</button>
            </form>

            <!-- Menampilkan pesan error -->
            <% String errorMessage = (String) request.getAttribute("error"); %>
            <% if (errorMessage != null) { %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
            <% } %>
        </div>
    </div>

    <div class="split kanan">
        <!-- Bagian kanan dengan gradient -->
    </div>
</body>
</html>
