@param String username
@param long totalGuides
@param long totalQuizzes
@param long quizzesCompleted
@param long quizzesInProgress
@param double averageScore

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Progress Analytics - StudyGuide AI</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&display=swap" />
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; margin: 0; padding: 20px; color: #333; }
        .container { max-width: 900px; margin: auto; }
        h1 { color: #2563eb; margin-bottom: 24px; }
        .card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgb(0 0 0 / 0.1);
            display: flex;
            justify-content: space-between;
        }
        .card span {
            font-weight: 700;
            font-size: 24px;
        }
        .card label { color: #64748b; font-weight: 500; }
        .btn-back {
            display: inline-block;
            padding: 10px 18px;
            margin-bottom: 20px;
            background-color: #2563eb;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }
        .btn-back:hover {
            background-color: #1d4ed8;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Progress Analytics for ${username}</h1>

    <div class="card">
        <label>Total Study Guides</label>
        <span>${totalGuides}</span>
    </div>

    <div class="card">
        <label>Total Quizzes</label>
        <span>${totalQuizzes}</span>
    </div>

    <div class="card">
        <label>Quizzes Completed</label>
        <span>${quizzesCompleted}</span>
    </div>

    <div class="card">
        <label>Quizzes In Progress</label>
        <span>${quizzesInProgress}</span>
    </div>

    <div class="card">
        <label>Average Quiz Score</label>
        <span>${String.format("%.2f", averageScore)}%</span>
    </div>
</div>
<div style="display: flex; justify-content: center; margin-bottom: 20px;">
    <a href="/dashboard" class="btn-back">← Back to Dashboard</a>
</div>
</body>
</html>
