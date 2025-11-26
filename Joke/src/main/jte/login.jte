<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login to Your Account</title>
    <style>
        :root {
            --space-xs: 6px;
            --space-sm: 10px;
            --space-md: 16px;
            --space-lg: 24px;
            --radius-full: 999px;
        }
        body {
            margin: 0;
            min-height: 100vh;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background:
                    radial-gradient(circle at top, #1d4ed8 0, transparent 55%),
                    radial-gradient(circle at bottom, #0f766e 0, transparent 55%),
                    #020617;
            color: #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--space-lg);
        }
        .container {
            align-items: center;
            background:
                    radial-gradient(circle at top left, rgba(56, 189, 248, 0.16), transparent 55%),
                    radial-gradient(circle at bottom right, rgba(129, 140, 248, 0.18), transparent 55%),
                    rgba(15, 23, 42, 0.96);
            border: 1px solid rgba(148, 163, 184, 0.35);
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(24px);
            border-radius: 20px;
            padding: 50px 45px; /* increased padding to add more space inside */
            max-width: 520px; /* increased max-width to be wider than input width */
            min-width: 350px; /* minimum width to ensure card doesn't shrink too small */
            width: 100%;
        }
        .logo {
            text-align: center;
            margin-bottom: 25px;
        }
        .logo-text {
            font-size: 28px;
            font-weight: 700;
            background: linear-gradient(120deg, #60a5fa, #a855f7, #22c55e);
            -webkit-background-clip: text;
            color: transparent;
            margin-bottom: 5px;
        }
        .logo-subtitle {
            font-size: 15px;
            color: #9ca3af;
        }
        h2 {
            color: #e5e7eb;
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
            color: #9ca3af;
            font-weight: 500;
            font-size: 14px;
        }
        input {
            width: 100%;
            padding: 12px 7px;
            border: 1px solid rgba(148, 163, 184, 0.6);
            border-radius: var(--radius-full);
            font-size: 16px;
            background-color: rgba(15, 23, 42, 0.8);
            color: #e5e7eb;
            transition: all 0.3s;
        }
        input::placeholder {
            color: #9ca3af;
        }
        input:focus {
            outline: none;
            border-color: #60a5fa;
            background-color: rgba(15, 23, 42, 0.95);
            box-shadow: 0 0 0 3px rgba(96, 165, 250, 0.5);
            color: #e5e7eb;
        }
        .submit-btn {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            background: radial-gradient(circle at top left, #4f46e5, #2563eb);
            color: #e5e7eb;
            border: none;
            border-radius: var(--radius-full);
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.1s;
            box-shadow:
                    0 12px 30px rgba(37, 99, 235, 0.7),
                    0 0 0 1px rgba(129, 140, 248, 0.7);
        }
        .submit-btn:hover {
            background-color: #2563eb;
            box-shadow:
                    0 18px 40px rgba(37, 99, 235, 0.9),
                    0 0 0 1px rgba(191, 219, 254, 0.9);
            transform: translateY(-1px);
        }
        .forgot-password {
            text-align: right;
            margin-top: 0px;
        }
        .forgot-password a {
            color: #9ca3af;
            font-size: 14px;
            text-decoration: none;
        }
        .forgot-password a:hover {
            color: #60a5fa;
            text-decoration: underline;
        }
        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #9ca3af;
            font-size: 15px;
        }
        .register-link a {
            color: #60a5fa;
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
            border-bottom: 1px solid rgba(148, 163, 184, 0.35);
        }
        .divider span {
            padding: 0 15px;
            color: #9ca3af;
            font-size: 14px;
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