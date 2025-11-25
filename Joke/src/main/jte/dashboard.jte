@import com.example.joke.StudyGuide
@import com.example.joke.Quiz
@import java.time.format.DateTimeFormatter
@param String username
@param java.util.List<StudyGuide> studyGuides
@param java.util.List<Quiz> quizzes

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyGuide AI - Dashboard</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .app-container {
            min-height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        nav {
            display: flex;
            gap: 24px;
            align-items: center;
        }

        nav a {
            text-decoration: none;
            color: #64748b;
            font-weight: 500;
            font-size: 15px;
            padding: 10px 16px;
            border-radius: 12px;
            transition: all 0.3s ease;
            position: relative;
        }

        nav a:hover {
            color: #2563eb;
            background: rgba(37, 99, 235, 0.1);
            transform: translateY(-2px);
        }

        nav a.active {
            color: #2563eb;
            background: rgba(37, 99, 235, 0.1);
            font-weight: 600;
        }

        .new-guide-btn {
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
        }

        .new-guide-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
        }

        /* Main Content */
        .container {
            display: flex;
            padding: 40px;
            max-width: 1400px;
            margin: 0 auto;
            gap: 40px;
        }

        /* Main Content Area */
        .main-content {
            flex: 2;
        }

        .welcome-section {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 40px;
            border-radius: 20px;
            margin-bottom: 40px;
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }

        .welcome-title {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .welcome-subtitle {
            font-size: 18px;
            opacity: 0.9;
        }

        .section-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 16px;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: #2563eb;
        }

        .section-subtitle {
            font-size: 16px;
            color: #64748b;
            margin-bottom: 32px;
        }

        /* Study Guides */
        .guides-container, .quizzes-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
            margin-bottom: 50px;
        }

        .guide-card, .quiz-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .guide-card::before, .quiz-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
        }

        .guide-card:hover, .quiz-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .guide-title, .quiz-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #1e293b;
            line-height: 1.4;
        }

        .guide-meta, .quiz-meta {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .guide-actions, .quiz-actions {
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: none;
        }

        .btn-view {
            background: rgba(37, 99, 235, 0.1);
            color: #2563eb;
            border: 1px solid rgba(37, 99, 235, 0.2);
        }

        .btn-view:hover {
            background: #2563eb;
            color: white;
            transform: translateY(-2px);
        }

        .btn-delete {
            background: rgba(220, 38, 38, 0.1);
            color: #dc2626;
            border: 1px solid rgba(220, 38, 38, 0.2);
        }

        .btn-delete:hover {
            background: #dc2626;
            color: white;
            transform: translateY(-2px);
        }

        .btn-quiz {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
        }

        .btn-quiz:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        /* Quiz Status */
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

        /* Empty States */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            grid-column: 1 / -1;
        }

        .empty-state i {
            font-size: 48px;
            color: #cbd5e1;
            margin-bottom: 16px;
        }

        .empty-state p {
            color: #64748b;
            font-size: 16px;
            margin-bottom: 20px;
        }

        /* Sidebar */
        .sidebar {
            flex: 1;
        }

        .account-card, .quick-links-card, .overview-card {
            background: white;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 24px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-title i {
            color: #2563eb;
        }

        .account-info {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
        }

        .avatar {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 20px;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
        }

        .account-name {
            font-weight: 600;
            color: #1e293b;
            font-size: 18px;
        }

        .quick-links-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .quick-link {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px;
            background: #f8fafc;
            border-radius: 12px;
            text-decoration: none;
            color: #374151;
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }

        .quick-link:hover {
            background: white;
            border-color: #2563eb;
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .quick-link-icon {
            width: 44px;
            height: 44px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .overview-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        .stat {
            text-align: center;
            padding: 20px;
            background: #f8fafc;
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .stat:hover {
            background: white;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .stat-number {
            font-size: 28px;
            font-weight: 800;
            color: #2563eb;
            margin-bottom: 4px;
        }

        .stat-label {
            font-size: 14px;
            color: #64748b;
            font-weight: 500;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .container {
                flex-direction: column;
            }

            .guides-container, .quizzes-container {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            }
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                gap: 20px;
                padding: 20px;
            }

            nav {
                flex-wrap: wrap;
                justify-content: center;
                gap: 12px;
            }

            .container {
                padding: 20px;
            }

            .welcome-section {
                padding: 30px;
            }

            .welcome-title {
                font-size: 28px;
            }

            .guides-container, .quizzes-container {
                grid-template-columns: 1fr;
            }

            .guide-actions, .quiz-actions {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Header -->
    <header>
        <div class="logo">StudyGuide AI</div>
        <nav>
            <a href="/dashboard" class="active"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="/guides/create"><i class="fas fa-plus-circle"></i> Create Guide</a>
            <a href="/guides/list"><i class="fas fa-book"></i> Guides</a>
            <a href="/guides/quizzes-list"><i class="fas fa-question-circle"></i> Quizzes</a>
            <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            <a href="/guides/create" class="new-guide-btn">
                <i class="fas fa-plus"></i> New Study Guide
            </a>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">
        <!-- Main Content Area -->
        <div class="main-content">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <h1 class="welcome-title">Welcome back, ${username}! 👋</h1>
                <p class="welcome-subtitle">Ready to continue your learning journey? Create new study guides or review your existing materials.</p>
            </div>

            <!-- Study Guides Section -->
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-book-open"></i> Your Study Guides
                </h2>
                <p class="section-subtitle">All created guides with subject and creation date. Click to view, edit, or create quizzes.</p>
            </div>

            <div class="guides-container">
                @if(studyGuides != null && !studyGuides.isEmpty())
                    @for(StudyGuide guide : studyGuides)
                        <div class="guide-card">
                            <h3 class="guide-title">${guide.title}</h3>
                            <p class="guide-meta">
                                <i class="fas fa-calendar"></i> ${guide.createdAt.format(DateTimeFormatter.ofPattern("MMM d, yyyy"))}
                                • <i class="fas fa-tag"></i> ${guide.subject != null ? guide.subject : "General"}
                            </p>
                            <div class="guide-actions">
                                <a href="/guides/${guide.id}" class="btn btn-view">
                                    <i class="fas fa-eye"></i> View / Edit
                                </a>
                                <form action="/guides/${guide.id}/delete" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this guide?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    @endfor
                @else
                    <div class="empty-state">
                        <i class="fas fa-book"></i>
                        <p>No study guides created yet.</p>
                        <a href="/guides/create" class="new-guide-btn">
                            <i class="fas fa-plus"></i> Create Your First Guide
                        </a>
                    </div>
                @endif
            </div>

            <!-- Quizzes Section -->
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-question-circle"></i> Your Quizzes
                </h2>
                <p class="section-subtitle">Track your progress and test your knowledge with interactive quizzes.</p>
            </div>

            <div class="quizzes-container">
                @if(quizzes != null && !quizzes.isEmpty())
                    @for(Quiz quiz : quizzes)
                        <div class="quiz-card">
                            <h3 class="quiz-title">${quiz.title}</h3>
                            <p class="quiz-meta">
                                <i class="fas fa-book"></i> From: ${quiz.studyGuide.title}
                            </p>
                            <span class="quiz-status status-${quiz.status.toLowerCase().replace('_', '-')}">
                                <i class="fas fa-circle"></i> ${quiz.status.replace('_', ' ')}
                            </span>
                            <div class="quiz-actions">
                                <a href="/quizzes/${quiz.id}" class="btn btn-quiz">
                                    <i class="fas fa-play"></i> Take Quiz
                                </a>
                            </div>
                        </div>
                    @endfor
                @else
                    <div class="empty-state">
                        <i class="fas fa-question-circle"></i>
                        <p>No quizzes created yet. Create a study guide first to generate quizzes!</p>
                    </div>
                @endif
            </div>
        </div>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Account Card -->
            <div class="account-card">
                <h3 class="card-title">
                    <i class="fas fa-user"></i> Your Account
                </h3>
                <div class="account-info">
                    <div class="avatar">${username.substring(0, 2).toUpperCase()}</div>
                    <div>
                        <div class="account-name">${username}</div>
                        <div style="color: #64748b; font-size: 14px;">Active User</div>
                    </div>
                </div>
            </div>

            <!-- Quick Links Card -->
            <div class="quick-links-card">
                <h3 class="card-title">
                    <i class="fas fa-rocket"></i> Quick Actions
                </h3>
                <div class="quick-links-list">
                    <a href="/guides/create" class="quick-link">
                        <div class="quick-link-icon">
                            <i class="fas fa-plus"></i>
                        </div>
                        <span>Create New Guide</span>
                    </a>
                    <a href="/dashboard" class="quick-link">
                        <div class="quick-link-icon">
                            <i class="fas fa-list"></i>
                        </div>
                        <span>View All Guides</span>
                    </a>
                    <a href="/dashboard" class="quick-link">
                        <div class="quick-link-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <span>Progress Analytics</span>
                    </a>
                </div>
            </div>

            <!-- Overview Card -->
            <div class="overview-card">
                <h3 class="card-title">
                    <i class="fas fa-chart-pie"></i> Study Overview
                </h3>
                <div class="overview-stats">
                    <div class="stat">
                        <div class="stat-number">${studyGuides != null ? studyGuides.size() : 0}</div>
                        <div class="stat-label">Total Guides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">${quizzes != null ? quizzes.stream().filter(q -> "IN_PROGRESS".equals(q.status)).count() : 0}</div>
                        <div class="stat-label">Active Quizzes</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">${quizzes != null ? quizzes.stream().filter(q -> "COMPLETED".equals(q.status)).count() : 0}</div>
                        <div class="stat-label">Completed</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">${(studyGuides != null ? studyGuides.size() : 0) + (quizzes != null ? quizzes.size() : 0)}</div>
                        <div class="stat-label">Total Items</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Add subtle animations
    document.addEventListener('DOMContentLoaded', function() {
        // Animate cards on load
        const cards = document.querySelectorAll('.guide-card, .quiz-card, .stat');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            setTimeout(() => {
                card.style.transition = 'all 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
</body>
</html>