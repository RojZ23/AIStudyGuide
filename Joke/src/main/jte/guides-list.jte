@import com.example.joke.StudyGuide
@import java.time.format.DateTimeFormatter
@param String username
@param java.util.List<StudyGuide> studyGuides

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>All Study Guides - StudyGuide AI</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        /* Use your existing dashboard styles here for consistency */
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            color: #333;
        }
        .app-container {
            background: rgba(255, 255, 255, 0.95);
            min-height: 100vh;
            backdrop-filter: blur(10px);
            padding: 20px 40px;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        .logo {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        nav a {
            text-decoration: none;
            color: #64748b;
            font-weight: 500;
            font-size: 15px;
            padding: 10px 16px;
            border-radius: 12px;
            margin-right: 12px;
        }
        nav a.active, nav a:hover {
            color: #2563eb;
            background: rgba(37, 99, 235, 0.1);
        }
        .guides-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
        }
        .guide-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
        }
        .guide-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        .guide-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #1e293b;
        }
        .guide-meta {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
        }
        .btn-view {
            background: rgba(37, 99, 235, 0.1);
            color: #2563eb;
            border: 1px solid rgba(37, 99, 235, 0.2);
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-view:hover {
            background: #2563eb;
            color: white;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="app-container">
    <header>
        <div class="logo">StudyGuide AI</div>
        <nav>
            <a href="/dashboard">Dashboard</a>
            <a href="/guides/create">Create Guide</a>
            <a href="/guides/list" class="active">Guides</a>
            <a href="/guides/quizzes-list">Quizzes</a>
            <a href="/logout">Logout</a>
        </nav>
    </header>
    <h1>All Your Study Guides</h1>
    <div class="guides-container">
        @if(studyGuides != null && !studyGuides.isEmpty())
            @for(StudyGuide guide : studyGuides)
                <div class="guide-card">
                    <h3 class="guide-title">${guide.title}</h3>
                    <p class="guide-meta">
                        <i class="fas fa-calendar"></i> ${guide.createdAt.format(DateTimeFormatter.ofPattern("MMM d, yyyy"))}
                        &nbsp;&nbsp;•&nbsp;&nbsp;
                        <i class="fas fa-tag"></i> ${guide.subject != null ? guide.subject : "General"}
                    </p>
                    <a href="/guides/${guide.id}" class="btn-view">
                        <i class="fas fa-eye"></i> View / Edit
                    </a>
                </div>
            @endfor
        @else
            <p>You have no study guides yet. <a href="/guides/create">Create your first guide here</a>.</p>
        @endif
    </div>
</div>
</body>
</html>
