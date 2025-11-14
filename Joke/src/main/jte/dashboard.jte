@param String username
@param java.util.List<String> assets

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Dashboard - ${username}</title>
</head>
<body>
<h1>Welcome, ${username}!</h1>
<nav><a href="/logout">Logout</a></nav>

<section>
    <h2>Your AI Generated Study Guides</h2>
    @if(assets != null && !assets.isEmpty())
        <ul>
            @for(String asset : assets)
                <li><pre style="white-space: pre-wrap; font-family: monospace;">${asset}</pre></li>
            @endfor
        </ul>
    @else
        <p>No study guides generated yet.</p>
    @endif
</section>

<section>
    <h2>Generate New Study Guide</h2>
    <form action="/generate" method="post">
        <label for="prompt">Enter a topic or prompt:</label>
        <input type="text" id="prompt" name="prompt" required />
        <button type="submit">Generate</button>
    </form>
</section>
</body>
</html>
