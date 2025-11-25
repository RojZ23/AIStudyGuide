<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login to Your Account</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 40px 35px;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo {
            text-align: center;
            margin-bottom: 25px;
        }

        .logo-text {
            font-size: 28px;
            font-weight: 700;
            color: #4299e1;
            margin-bottom: 5px;
        }

        .logo-subtitle {
            font-size: 15px;
            color: #718096;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #4a5568;
            font-weight: 500;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            background-color: #f8fafc;
        }

        input:focus {
            outline: none;
            border-color: #4299e1;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background-color: #4299e1;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background-color: #3182ce;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #718096;
            font-size: 15px;
        }

        .register-link a {
            color: #4299e1;
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e2e8f0;
        }

        .divider span {
            padding: 0 15px;
            color: #a0aec0;
            font-size: 14px;
        }

        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }

        .forgot-password a {
            color: #718096;
            font-size: 14px;
            text-decoration: none;
        }

        .forgot-password a:hover {
            color: #4299e1;
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 25px;
            }

            h2 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logo">
        <div class="logo-text">Study Guide Generator</div>
        <div class="logo-subtitle">Welcome back</div>
    </div>

    <h2>Login to Your Account</h2>

    <form action="/login" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <div class="forgot-password">
            <a href="/forgot-password">Forgot password?</a>
        </div>

        <button type="submit" class="submit-btn">Sign In</button>
    </form>

    <div class="divider">
        <span>OR</span>
    </div>

    <p class="register-link">Don't have an account? <a href="/register">Register here</a></p>
</div>
</body>
</html>