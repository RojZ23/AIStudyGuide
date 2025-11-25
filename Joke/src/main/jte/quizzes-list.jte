@import com.example.joke.Quiz
@import java.time.format.DateTimeFormatter
@param String username
@param java.util.List<Quiz> quizzes

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>All Quizzes - StudyGuide AI</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
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
        .quizzes-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
        }
        .quiz-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
        }
        .quiz-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        .quiz-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #1e293b;
        }
        .quiz-meta {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 12px;
        }
        .quiz-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 12px;
        }
        .status-in-progress {
            background: rgba(245, 158, 11, 0.1);
            color: #d97706;
            border: 1px solid rgba(245, 158, 11, 0.2);
        }
        .status-completed {
            background: rgba(16, 185, 129, 0.1);
            color: #059669;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        .status-not-started {
            background: rgba(107, 114, 128, 0.1);
            color: #6b7280;
            border: 1px solid rgba(107, 114, 128, 0.2);
        }
        .btn-take-quiz {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
        }
        .btn-take-quiz:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
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
            <a href="/guides/list">Guides</a>
            <a href="/guides/quizzes-list" class="active">Quizzes</a>
            <a href="/logout">Logout</a>
        </nav>
    </header>
    <h1>All Your Quizzes</h1>
    <div class="quizzes-container">
        @if(quizzes != null && !quizzes.isEmpty())
            @for(Quiz quiz : quizzes)
                <div class="quiz-card">
                    <h3 class="quiz-title">${quiz.title}</h3>
                    <p class="quiz-meta"><i class="fas fa-book"></i> From: ${quiz.studyGuide.title}</p>
                    <span class="quiz-status status-${quiz.status.toLowerCase().replace('_', '-')}">
                        <i class="fas fa-circle"></i> ${quiz.status.replace('_', ' ')}
                    </span>
                    <form action="/quizzes/${quiz.id}" method="get" style="display:inline;">
                        <button type="submit" class="btn-take-quiz">
                            <i class="fas fa-play"></i> Take Quiz
                        </button>
                    </form>
                </div>
            @endfor
        @else
            <p>No quizzes found. Generate quizzes from your study guides!</p>
        @endif
    </div>
</div>
</body>
</html>
