<html>
<head>
    <title>Register</title>
</head>
<body>
<h2>User Registration</h2>
<form method="post" action="/register">
    <label>Username:
        <input type="text" name="username" required />
    </label><br/>
    <label>Password:
        <input type="password" name="password" required />
    </label><br/>
    <button type="submit">Register</button>
</form>
<p>Already have an account? <a href="/login">Login here</a></p>
</body>
</html>
