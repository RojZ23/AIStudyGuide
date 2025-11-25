@import com.example.joke.StudyGuide
@import java.time.format.DateTimeFormatter
@param StudyGuide guide

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyGuide AI - ${guide.title}</title>
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

        /* Main Content */
        .container {
            display: flex;
            padding: 30px 40px;
            max-width: 1400px;
            margin: 0 auto;
            gap: 30px;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 240px;
            background-color: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            height: fit-content;
        }

        .sidebar-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #1e293b;
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .sidebar-nav a {
            padding: 12px 16px;
            text-decoration: none;
            color: #64748b;
            border-radius: 8px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .sidebar-nav a:hover {
            background-color: #f1f5f9;
            color: #2563eb;
        }

        .sidebar-nav a.active {
            background-color: #e6f7ff;
            color: #2563eb;
            font-weight: 500;
        }

        /* Main Content Area */
        .main-content {
            flex: 1;
        }

        /* Guide Header */
        .guide-header {
            margin-bottom: 24px;
        }

        .guide-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #1e293b;
        }

        .guide-meta {
            font-size: 16px;
            color: #64748b;
        }

        /* Tabs */
        .tabs {
            display: flex;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 24px;
        }

        .tab {
            padding: 12px 24px;
            font-weight: 500;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
            border-bottom: 3px solid transparent;
        }

        .tab.active {
            color: #2563eb;
            border-bottom: 3px solid #2563eb;
        }

        .tab:hover:not(.active) {
            color: #475569;
            background-color: #f8fafc;
        }

        /* Content Card */
        .content-card {
            background-color: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 24px;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e293b;
        }

        .card-actions {
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid #cbd5e1;
            color: #64748b;
        }

        .btn-outline:hover {
            background-color: #f8fafc;
            border-color: #94a3b8;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
        }

        /* Summary Content */
        .summary-content {
            line-height: 1.6;
            color: #374151;
            font-size: 16px;
            white-space: pre-wrap;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 32px;
        }

        .btn-save {
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-save:hover {
            background-color: #1d4ed8;
        }

        .btn-delete {
            background-color: #fee2e2;
            color: #dc2626;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-delete:hover {
            background-color: #fecaca;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
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
                gap: 12px;
            }

            .container {
                padding: 20px;
            }

            .tabs {
                overflow-x: auto;
                white-space: nowrap;
            }

            .action-buttons {
                flex-direction: column;
                gap: 12px;
            }

            .btn-save, .btn-delete {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">StudyGuide AI</div>
    <nav>
        <a href="/dashboard">Dashboard</a>
        <a href="/guides/create">New Guide</a>
        <a href="/dashboard">Account</a>
        <a href="/logout">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="sidebar">
        <div class="sidebar-title">Navigation</div>
        <div class="sidebar-nav">
            <a href="/dashboard"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="/dashboard"><i class="fas fa-list"></i> View List</a>
            <a href="#" class="active"><i class="fas fa-book"></i> Study Guide</a>
            <a href="/dashboard"><i class="fas fa-user"></i> Your Account</a>
        </div>
    </div>

    <div class="main-content">
        <div class="guide-header">
            <h1 class="guide-title">${guide.title}</h1>
            <div class="guide-meta">
                Subject: ${guide.subject != null ? guide.subject : "General"} • Created ${guide.createdAt.format(DateTimeFormatter.ofPattern("MMM d, yyyy"))}
            </div>
        </div>

        <div class="regenerate-section">
            <h3><i class="fas fa-robot"></i> AI Content Management</h3>
            <p>Regenerate AI content or edit the current AI-generated content.</p>
            <div style="display: flex; gap: 12px; margin-top: 16px;">
                <form action="/guides/${guide.id}/regenerate" method="post" style="display: inline;">
                    <select name="difficulty" required style="padding: 6px; border-radius: 4px; border: 1px solid #ccc;">
                        <option value="basic">Basic</option>
                        <option value="detailed">Detailed</option>
                        <option value="very detailed">Very Detailed</option>
                    </select>
                    <button type="submit" class="btn btn-primary" onclick="return confirm('This will regenerate all AI content. Continue?')">
                        <i class="fas fa-sync-alt"></i> Regenerate All AI Content
                    </button>
                </form>
                <button class="btn btn-outline" onclick="toggleEditMode()">
                    <i class="fas fa-edit"></i> Edit AI Content
                </button>
            </div>
        </div>

        <div class="tabs">
            <div class="tab" onclick="showTab('original')">Original Notes</div>
            <div class="tab active" onclick="showTab('summary')">AI Summary</div>
            <div class="tab" onclick="showTab('terms')">Key Terms / Definitions</div>
            <div class="tab" onclick="showTab('questions')">Practice Questions</div>
        </div>

        <div class="content-card">
            <div class="card-header">
                <h3 class="card-title" id="content-title">AI Summary</h3>
                <div class="card-actions">
                    <a href="/guides/${guide.id}/edit" class="btn btn-primary"><i class="fas fa-edit"></i> Edit Guide</a>
                </div>
            </div>

            <div class="content-area" id="content-area">
                <div id="summary-content" class="summary-content">
                    ${guide.aiSummary != null ? guide.aiSummary : "No summary available."}
                </div>
                <div id="terms-content" class="summary-content" style="display: none;">
                    ${guide.keyTerms != null ? guide.keyTerms : "No key terms generated yet."}
                </div>
                <div id="questions-content" class="summary-content" style="display: none;">
                    ${guide.practiceQuestions != null ? guide.practiceQuestions : "No practice questions generated yet."}
                </div>
                <div id="original-content" class="summary-content" style="display: none;">
                    ${guide.originalNotes != null ? guide.originalNotes : "No original notes available."}
                </div>
            </div>

            <div id="edit-forms" style="display: none;">
                <form action="/guides/${guide.id}/update-ai" method="post">
                    <div id="edit-summary" class="edit-mode" style="display: none;">
                        <h4>Edit AI Summary</h4>
                        <textarea class="edit-textarea" name="aiSummary">${guide.aiSummary != null ? guide.aiSummary : ""}</textarea>
                        <div class="edit-buttons">
                            <button type="submit" class="btn btn-save">Save Summary</button>
                            <button type="button" class="btn btn-cancel" onclick="cancelEdit('summary')">Cancel</button>
                        </div>
                    </div>
                    <div id="edit-terms" class="edit-mode" style="display: none;">
                        <h4>Edit Key Terms</h4>
                        <textarea class="edit-textarea" name="keyTerms">${guide.keyTerms != null ? guide.keyTerms : ""}</textarea>
                        <div class="edit-buttons">
                            <button type="submit" class="btn btn-save">Save Key Terms</button>
                            <button type="button" class="btn btn-cancel" onclick="cancelEdit('terms')">Cancel</button>
                        </div>
                    </div>
                    <div id="edit-questions" class="edit-mode" style="display: none;">
                        <h4>Edit Practice Questions</h4>
                        <textarea class="edit-textarea" name="practiceQuestions">${guide.practiceQuestions != null ? guide.practiceQuestions : ""}</textarea>
                        <div class="edit-buttons">
                            <button type="submit" class="btn btn-save">Save Questions</button>
                            <button type="button" class="btn btn-cancel" onclick="cancelEdit('questions')">Cancel</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="action-buttons">
            <form action="/guides/${guide.id}/quiz" method="post" style="display: inline;">
                <button type="submit" class="btn-save"><i class="fas fa-play"></i> Generate & Save Quiz</button>
            </form>
            <form action="/guides/${guide.id}/delete" method="post" style="display: inline;">
                <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this guide?')">
                    <i class="fas fa-trash"></i> Delete Guide
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    let currentTab = 'summary';
    let editMode = false;

    function showTab(tabName) {
        if (editMode) {
            if (!confirm('You have unsaved changes. Continue?')) {
                return;
            }
            cancelEdit(currentTab);
        }

        document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
        event.target.classList.add('active');

        document.querySelectorAll('.summary-content').forEach(content => {
            content.style.display = 'none';
        });
        document.querySelectorAll('.edit-mode').forEach(form => {
            form.style.display = 'none';
        });

        currentTab = tabName;

        if (tabName === 'original') {
            document.getElementById('content-title').textContent = 'Original Notes';
            document.getElementById('original-content').style.display = 'block';
        } else if (tabName === 'terms') {
            document.getElementById('content-title').textContent = 'Key Terms / Definitions';
            document.getElementById('terms-content').style.display = 'block';
        } else if (tabName === 'questions') {
            document.getElementById('content-title').textContent = 'Practice Questions';
            document.getElementById('questions-content').style.display = 'block';
        } else {
            document.getElementById('content-title').textContent = 'AI Summary';
            document.getElementById('summary-content').style.display = 'block';
        }
    }

    function toggleEditMode() {
        if (editMode) {
            cancelEdit(currentTab);
        } else {
            enterEditMode(currentTab);
        }
    }

    function enterEditMode(tabName) {
        editMode = true;
        document.getElementById('content-area').style.display = 'none';
        document.getElementById('edit-forms').style.display = 'block';

        if (tabName === 'terms') {
            document.getElementById('edit-terms').style.display = 'block';
        } else if (tabName === 'questions') {
            document.getElementById('edit-questions').style.display = 'block';
        } else {
            document.getElementById('edit-summary').style.display = 'block';
        }
    }

    function cancelEdit(tabName) {
        editMode = false;
        document.getElementById('content-area').style.display = 'block';
        document.getElementById('edit-forms').style.display = 'none';
        document.querySelectorAll('.edit-mode').forEach(form => {
            form.style.display = 'none';
        });
    }
</script>
</body>
</html>