@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyGuide AI - Create New Study Guide</title>
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
            color: #111827;
            min-height: 100vh;
        }

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
            gap: 20px;
        }

        nav a {
            text-decoration: none;
            color: #64748b;
            font-weight: 500;
            font-size: 15px;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.2s;
        }

        nav a:hover {
            color: #2563eb;
            background-color: #f1f5f9;
        }

        nav a.active {
            color: #2563eb;
            background-color: #e0f2fe;
            font-weight: 600;
        }

        .container {
            display: flex;
            padding: 30px 40px;
            max-width: 1200px;
            margin: 0 auto;
            gap: 30px;
        }

        .main-content {
            flex: 2;
        }

        .sidebar {
            flex: 1;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 24px;
            color: #1f2933;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-title i {
            color: #2563eb;
        }

        .card {
            background-color: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            margin-bottom: 24px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 16px;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .card-title i {
            color: #2563eb;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #374151;
            font-weight: 500;
            font-size: 14px;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s;
            background-color: white;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .text-area {
            min-height: 200px;
            resize: vertical;
            line-height: 1.5;
        }

        .file-input-container {
            position: relative;
            margin-top: 8px;
        }

        .file-input-label {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            background-color: #f8fafc;
            border: 1px dashed #cbd5e1;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            color: #64748b;
            font-weight: 500;
        }

        .file-input-label:hover {
            background-color: #f1f5f9;
            border-color: #2563eb;
        }

        .file-input-label i {
            color: #2563eb;
        }

        .file-input {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.3);
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
        }

        .side-card {
            background-color: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .side-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .side-text {
            font-size: 14px;
            color: #6b7280;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .side-list {
            margin-top: 8px;
            padding-left: 18px;
            font-size: 14px;
            color: #6b7280;
        }

        .side-list li {
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .account-info {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .avatar {
            width: 44px;
            height: 44px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 16px;
        }

        .user-details {
            display: flex;
            flex-direction: column;
        }

        .username {
            font-weight: 600;
            color: #111827;
        }

        .user-status {
            font-size: 13px;
            color: #6b7280;
        }

        .form-note {
            font-size: 13px;
            color: #6b7280;
            margin-top: 6px;
            font-style: italic;
        }

        .form-divider {
            height: 1px;
            background-color: #e5e7eb;
            margin: 20px 0;
        }

        @media (max-width: 992px) {
            .container {
                flex-direction: column;
            }
        }

        @media (max-width: 640px) {
            header {
                flex-direction: column;
                gap: 12px;
                padding: 16px 20px;
            }

            nav {
                width: 100%;
                justify-content: center;
            }

            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">StudyGuide AI</div>
    <nav>
        <a href="/dashboard"><i class="fas fa-th-large"></i> Dashboard</a>
        <a href="/guides/create" class="active"><i class="fas fa-plus-circle"></i> Create Guide</a>
        <a href="/dashboard"><i class="fas fa-book"></i> Guides</a>
        <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>
</header>

<div class="container">
    <div class="main-content">
        <h1 class="page-title">
            <i class="fas fa-book-medical"></i> Create New Study Guide
        </h1>

        <div class="card">
            <form action="/guides/create" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">
                        <i class="fas fa-heading"></i> Guide Title
                    </label>
                    <input type="text" name="title" id="title" placeholder="Enter a descriptive title for your study guide" required/>
                </div>

                <div class="form-group">
                    <label for="notes">
                        <i class="fas fa-sticky-note"></i> Notes Content
                    </label>
                    <textarea name="notes" id="notes" class="text-area" placeholder="Enter your study notes here..."></textarea>
                    <p class="form-note">Or upload a file with your notes instead</p>
                </div>

                <div class="form-group">
                    <div class="file-input-container">
                        <label class="file-input-label">
                            <i class="fas fa-file-upload"></i>
                            <span id="file-label-text">Upload Notes File (.txt, .md, .docx)</span>
                            <input type="file" name="notesFile" id="notesFile" class="file-input" accept=".txt,.md,.docx" onchange="updateFileLabel()"/>
                        </label>
                    </div>
                </div>

                <div class="form-divider"></div>

                <div class="form-group">
                    <label for="difficulty">
                        <i class="fas fa-layer-group"></i> Difficulty Level
                    </label>
                    <select name="difficulty" id="difficulty">
                        <option value="basic" selected>Basic - Concise overview with key points</option>
                        <option value="detailed">Detailed - Comprehensive coverage with examples</option>
                        <option value="very detailed">Very Detailed - In-depth analysis with multiple examples</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-rocket"></i> Create Study Guide
                </button>
            </form>
        </div>
    </div>

    <div class="sidebar">
        <div class="side-card">
            <div class="side-title">
                <i class="fas fa-lightbulb"></i> Creating Effective Guides
            </div>
            <p class="side-text">
                Structure your notes with simple headings and bullets for best results:
            </p>
            <ul class="side-list">
                <li><strong>Use clear headings:</strong> Chapter, Section, Topic</li>
                <li><strong>Bullet key facts:</strong> Keep sentences concise and focused</li>
                <li><strong>Mark definitions clearly:</strong> Term - Definition format</li>
                <li><strong>Separate concepts:</strong> Use blank lines between topics</li>
                <li><strong>Include examples:</strong> Add practical examples after each concept</li>
                <li><strong>Highlight important points:</strong> Use emphasis for critical information</li>
            </ul>
        </div>

        <div class="side-card">
            <div class="side-title">
                <i class="fas fa-user-circle"></i> Your Account
            </div>
            <div class="account-info">
                <div class="avatar">${username.substring(0, 2).toUpperCase()}</div>
                <div class="user-details">
                    <div class="username">${username}</div>
                    <div class="user-status">Active User</div>
                </div>
            </div>
            <p class="side-text">
                Create comprehensive study guides that you can later use to generate personalized quizzes.
            </p>
        </div>
    </div>
</div>

<script>
    function updateFileLabel() {
        const fileInput = document.getElementById('notesFile');
        const fileLabel = document.getElementById('file-label-text');

        if (fileInput.files.length > 0) {
            fileLabel.textContent = fileInput.files[0].name;
        } else {
            fileLabel.textContent = 'Upload Notes File (.txt, .md, .docx)';
        }
    }
</script>
</body>
</html>