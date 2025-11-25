@import com.example.joke.StudyGuide
@param StudyGuide guide

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Study Guide - ${guide.title}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: #f8fafc;
            color: #333;
            min-height: 100vh;
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #2563eb;
        }

        nav {
            display: flex;
            gap: 28px;
        }

        nav a {
            text-decoration: none;
            color: #64748b;
            font-weight: 500;
            font-size: 15px;
            transition: color 0.2s;
        }

        nav a:hover {
            color: #2563eb;
        }

        /* Main Content */
        .container {
            display: flex;
            padding: 30px 40px;
            max-width: 1400px;
            margin: 0 auto;
            gap: 30px;
        }

        /* Main Content Area */
        .main-content {
            flex: 2;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 24px;
            color: #1e293b;
        }

        /* Cards */
        .card {
            background-color: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 24px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 16px;
            color: #1e293b;
        }

        /* Form Elements */
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

        input, textarea, select {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            background-color: #f8fafc;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #2563eb;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .text-area {
            min-height: 300px;
            resize: vertical;
        }

        /* Buttons */
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
            text-decoration: none;
            display: inline-block;
            border: none;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
        }

        .btn-secondary {
            background-color: #e5e7eb;
            color: #374151;
        }

        .btn-secondary:hover {
            background-color: #d1d5db;
        }

        /* Sidebar */
        .sidebar {
            flex: 1;
        }

        .instructions-card {
            background-color: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 24px;
        }

        .instructions-list {
            padding-left: 20px;
        }

        .instructions-list li {
            margin-bottom: 8px;
            color: #64748b;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .container {
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                gap: 16px;
                padding: 20px;
            }

            nav {
                flex-wrap: wrap;
                justify-content: center;
                gap: 16px;
            }

            .container {
                padding: 20px;
            }

            .btn-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="logo">StudyGuide AI</div>
    <nav>
        <a href="/dashboard">Dashboard</a>
        <a href="/guides/create">Create Guide</a>
        <a href="/dashboard">Guides</a>
        <a href="/logout">Logout</a>
    </nav>
</header>

<!-- Main Content -->
<div class="container">
    <!-- Main Content Area -->
    <div class="main-content">
        <h1 class="page-title">Edit Study Guide</h1>

        <form action="/guides/${guide.id}/edit" method="post">
            <!-- Guide Title -->
            <div class="card">
                <h2 class="card-title">Guide Information</h2>
                <div class="form-group">
                    <label for="title">Guide Title</label>
                    <input type="text" id="title" name="title" value="${guide.title}" required>
                </div>
                <div class="form-group">
                    <label for="subject">Subject (Optional)</label>
                    <input type="text" id="subject" name="subject" value="${guide.subject != null ? guide.subject : ""}" placeholder="e.g., Biology, Math, History">
                </div>
            </div>

            <!-- Notes Content -->
            <div class="card">
                <h2 class="card-title">Study Content</h2>
                <p>Edit your notes below. The AI will regenerate the summary, key terms, and practice questions when you save.</p>

                <div class="form-group">
                    <label for="notes">Your Notes</label>
                    <textarea class="text-area" id="notes" name="notes" required>${guide.originalNotes}</textarea>
                </div>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Save Changes & Regenerate AI Content</button>
                <a href="/guides/${guide.id}" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Instructions Card -->
        <div class="instructions-card">
            <h3 class="card-title">Editing Notes</h3>
            <p>When you save changes, the AI will automatically regenerate:</p>
            <ul class="instructions-list">
                <li>Concise summary</li>
                <li>Key terms and definitions</li>
                <li>Practice questions</li>
            </ul>
            <p style="margin-top: 16px; color: #64748b; font-size: 14px;">
                Make sure your notes are clear and well-structured for the best AI results.
            </p>
        </div>
    </div>
</div>
</body>
</html>