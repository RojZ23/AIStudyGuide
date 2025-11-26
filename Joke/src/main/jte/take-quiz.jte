@import com.example.joke.Quiz
@param Quiz quiz

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Quiz - ${quiz.title}</title>
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

        .quiz-header-card {
            background-color: white;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .quiz-title {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #1f2933;
        }

        .quiz-meta {
            font-size: 14px;
            color: #6b7280;
        }

        .quiz-status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 600;
            margin-top: 12px;
        }

        .status-not-started {
            background: rgba(107, 114, 128, 0.1);
            color: #4b5563;
            border: 1px solid rgba(107, 114, 128, 0.3);
        }

        .status-in-progress {
            background: rgba(245, 158, 11, 0.1);
            color: #b45309;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .status-completed {
            background: rgba(16, 185, 129, 0.1);
            color: #047857;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .quiz-card {
            background-color: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            margin-bottom: 24px;
        }

        .quiz-card h2 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 16px;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .quiz-instructions {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 20px;
        }

        .question-block {
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            padding: 16px;
            margin-bottom: 16px;
            background-color: #f9fafb;
        }

        .question-text {
            font-weight: 600;
            margin-bottom: 10px;
            color: #111827;
        }

        .options-list {
            list-style: none;
        }

        .option-item {
            margin-bottom: 6px;
        }

        .option-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 14px;
            color: #374151;
        }

        .option-input {
            width: 16px;
            height: 16px;
            accent-color: #2563eb;
        }

        .answer-key {
            margin-top: 12px;
            font-size: 13px;
            color: #6b7280;
        }

        .answer-key strong {
            color: #111827;
        }

        .bottom-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            margin-top: 24px;
            flex-wrap: wrap;
        }

        .score-group {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .score-group label {
            font-size: 14px;
            color: #374151;
            font-weight: 500;
        }

        .score-input {
            width: 80px;
            padding: 8px 10px;
            border-radius: 8px;
            border: 1px solid #cbd5e1;
            font-size: 14px;
        }

        .score-display {
            font-size: 14px;
            color: #111827;
            font-weight: 600;
        }

        .actions-group {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .btn-secondary {
            background-color: #e5e7eb;
            color: #111827;
        }

        .btn-secondary:hover {
            background-color: #d1d5db;
        }

        .btn-save {
            background-color: #2563eb;
            color: white;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.3);
        }

        .btn-save:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
        }

        .btn-submit {
            background-color: #10b981;
            color: white;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
        }

        .btn-submit:hover {
            background-color: #059669;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.35);
        }

        .btn-newquiz {
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.35);
        }

        .btn-newquiz:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(79, 70, 229, 0.45);
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
        }

        .side-list {
            margin-top: 8px;
            padding-left: 18px;
            font-size: 14px;
            color: #6b7280;
        }

        .side-list li {
            margin-bottom: 4px;
        }

        .answer-result {
            margin-top: 4px;
            font-size: 13px;
        }

        .correct {
            color: #059669;
        }

        .incorrect {
            color: #dc2626;
        }

        .completed-message {
            background-color: #d1fae5;
            color: #065f46;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
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

            .container {
                padding: 20px;
            }

            .bottom-row {
                flex-direction: column;
                align-items: flex-start;
            }

            .actions-group {
                width: 100%;
            }

            .btn {
                flex: 1;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">StudyGuide AI</div>
    <nav>
        <a href="/dashboard" class="active"><i class="fas fa-th-large"></i> Dashboard</a>
        <a href="/guides/create"><i class="fas fa-plus-circle"></i> Create Guide</a>
        <a href="/dashboard"><i class="fas fa-book"></i> Guides</a>
        <a href="/dashboard"><i class="fas fa-question-circle"></i> Quizzes</a>
        <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>
</header>

<div class="container">
    <div class="main-content">
        <div class="quiz-header-card">
            <h1 class="quiz-title">${quiz.title}</h1>
            <div class="quiz-meta">
                From study guide: ${quiz.studyGuide != null ? quiz.studyGuide.title : "Unknown guide"}<br/>
                Saved score: ${quiz.score != null ? quiz.score : 0}
            </div>
            <div class="quiz-status-badge status-${quiz.status != null ? quiz.status.toLowerCase().replace('_','-') : "not-started"}">
                <i class="fas fa-circle"></i>
                ${quiz.status != null ? quiz.status.replace('_',' ') : "NOT STARTED"}
            </div>
        </div>

        <div class="quiz-card">
            <h2><i class="fas fa-question-circle"></i> Quiz Questions</h2>
            <p class="quiz-instructions">
                Select the best answer for each question. When you submit, your score is calculated,
                saved, and the correct answers are shown at the bottom.
            </p>

            <!-- hidden raw quiz text for JS parser -->
            <textarea id="rawQuiz" style="display:none;">${quiz.questions != null ? quiz.questions : ""}</textarea>

            <!-- interactive form -->
            <form id="saveForm" action="/quizzes/${quiz.id}/save" method="post">
                <input type="hidden" name="status" id="statusInput" value="${quiz.status != null ? quiz.status : "NOT_STARTED"}">
                <input type="hidden" name="score" id="scoreInput" value="${quiz.score != null ? quiz.score : 0}">

                <div id="questionsContainer"></div>

                <div class="bottom-row">
                    <!-- serialized answers + original questions go into answers field -->
                    <input type="hidden" id="answersField" name="answers" value="">

                    <div class="actions-group">
                        <button type="button" class="btn btn-save" id="saveButton" onclick="saveProgress()">
                            <i class="fas fa-save"></i> Save Progress
                        </button>
                        <button type="button" class="btn btn-submit" id="submitButton" onclick="submitQuiz()">
                            <i class="fas fa-check"></i> Submit Quiz
                        </button>
                        <button type="button" class="btn btn-secondary" id="deleteButton" onclick="confirmDelete()">
                            <i class="fas fa-trash"></i> Delete Quiz
                        </button>
                        <a href="/dashboard" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back
                        </a>
                    </div>
                </div>
            </form>

            <!-- answer key section (populated on submit) -->
            <div id="answerKeySection" style="margin-top:24px; display:none;">
                <h3 style="font-size:18px; font-weight:600; margin-bottom:8px;">
                    <i class="fas fa-list-ol"></i> Answer Key
                </h3>
                <div id="answerKeyContent" class="answer-key"></div>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div class="side-card">
            <div class="side-title">
                <i class="fas fa-lightbulb"></i> Quiz Tips
            </div>
            <p class="side-text">
                Each question has four options (A–D). Click to choose, then submit to see your score and the official answer key.
            </p>
            <ul class="side-list">
                <li>Use save if you are partway through.</li>
                <li>Submit only when finished; it will mark the quiz as completed.</li>
                <li>Review the answer key to understand mistakes.</li>
            </ul>
        </div>
    </div>
</div>

<script>
    // Parses quiz text in the format:
    // Q1: ...
    // A) ...
    // B) ...
    // C) ...
    // D) ...
    // Correct: A
    function parseQuizText(text) {
        const lines = text.split(/\r?\n/).map(l => l.trim()).filter(l => l.length > 0);
        const questions = [];
        let current = null;

        const qRegex = /^Q(\d+):\s*(.+)$/i;
        const optRegex = /^([A-D])\)\s*(.+)$/i;
        const correctRegex = /^Correct:\s*([A-D])$/i;

        for (const line of lines) {
            let m;
            if ((m = qRegex.exec(line))) {
                if (current) {
                    questions.push(current);
                }
                current = {
                    number: parseInt(m[1], 10),
                    text: m[2],
                    options: {},
                    correct: null
                };
            } else if (current && (m = optRegex.exec(line))) {
                current.options[m[1].toUpperCase()] = m[2];
            } else if (current && (m = correctRegex.exec(line))) {
                current.correct = m[1].toUpperCase();
            }
        }
        if (current) {
            questions.push(current);
        }
        return questions;
    }

    function renderQuestions(questions) {
        const container = document.getElementById('questionsContainer');
        container.innerHTML = '';

        questions.forEach(q => {
            const block = document.createElement('div');
            block.className = 'question-block';
            block.dataset.qnum = q.number;

            const qText = document.createElement('div');
            qText.className = 'question-text';
            qText.textContent = 'Q' + q.number + ': ' + q.text;
            block.appendChild(qText);

            const ul = document.createElement('ul');
            ul.className = 'options-list';

            ['A','B','C','D'].forEach(letter => {
                if (!q.options[letter]) return;
                const li = document.createElement('li');
                li.className = 'option-item';

                const label = document.createElement('label');
                label.className = 'option-label';

                const input = document.createElement('input');
                input.type = 'radio';
                input.name = 'q' + q.number;
                input.value = letter;
                input.className = 'option-input';

                label.appendChild(input);
                const span = document.createElement('span');
                span.textContent = letter + ') ' + q.options[letter];
                label.appendChild(span);

                li.appendChild(label);
                ul.appendChild(li);
            });

            block.appendChild(ul);

            const result = document.createElement('div');
            result.className = 'answer-result';
            result.id = 'result-q' + q.number;
            block.appendChild(result);

            container.appendChild(block);
        });
    }

    function collectAnswers(questions) {
        const answers = {};
        questions.forEach(q => {
            const selected = document.querySelector('input[name="q' + q.number + '"]:checked');
            answers['Q' + q.number] = selected ? selected.value : null;
        });
        return answers;
    }

    function gradeQuiz(questions, answers) {
        let correctCount = 0;
        questions.forEach(q => {
            const userAns = answers['Q' + q.number];
            const resultEl = document.getElementById('result-q' + q.number);
            if (!userAns) {
                resultEl.textContent = 'No answer selected.';
                resultEl.className = 'answer-result';
                return;
            }
            if (userAns === q.correct) {
                correctCount++;
                resultEl.textContent = 'Correct!';
                resultEl.className = 'answer-result correct';
            } else {
                resultEl.textContent = 'Incorrect. You chose ' + userAns + ', correct is ' + q.correct + '.';
                resultEl.className = 'answer-result incorrect';
            }
        });
        const total = questions.length;
        const score = total > 0 ? Math.round((correctCount / total) * 100) : 0;
        return { score, correctCount, total };
    }

    function buildAnswerKey(questions) {
        return questions.map(q => 'Q' + q.number + ': ' + q.correct).join(' | ');
    }

    function serializeForSave(rawText, answersObj) {
        // Store original quiz text + a simple answers line at the end so you can inspect later
        const ansParts = Object.keys(answersObj).map(k => k + '=' + (answersObj[k] || '') );
        const answerLine = '\n\nUserAnswers: ' + ansParts.join('; ');
        return rawText + answerLine;
    }

    function hideSaveAndSubmitButtons() {
        const saveButton = document.getElementById('saveButton');
        const submitButton = document.getElementById('submitButton');
        if (saveButton) saveButton.style.display = 'none';
        if (submitButton) submitButton.style.display = 'none';
    }

    let parsedQuestions = [];

    document.addEventListener('DOMContentLoaded', function() {
        const raw = document.getElementById('rawQuiz').value || '';
        parsedQuestions = parseQuizText(raw);
        renderQuestions(parsedQuestions);

        // Disable radio after completed and hide buttons
        if ('${quiz.status}'.toUpperCase() === 'COMPLETED') {
            lockQuizInputs();
            showAnswerKey();
            hideSaveAndSubmitButtons();
        }
    });

    function saveProgress() {
        const raw = document.getElementById('rawQuiz').value || '';
        const answers = collectAnswers(parsedQuestions);
        const graded = gradeQuiz(parsedQuestions, answers);
        const serialized = serializeForSave(raw, answers);

        document.getElementById('answersField').value = serialized;
        document.getElementById('statusInput').value = 'IN_PROGRESS';
        document.getElementById('scoreInput').value = graded.score;

        document.getElementById('saveForm').submit();
    }

    function submitQuiz() {
        const raw = document.getElementById('rawQuiz').value || '';
        const answers = collectAnswers(parsedQuestions);
        const graded = gradeQuiz(parsedQuestions, answers);
        const serialized = serializeForSave(raw, answers);

        document.getElementById('answersField').value = serialized;
        document.getElementById('statusInput').value = 'COMPLETED';
        document.getElementById('scoreInput').value = graded.score;

        // Show answer key
        showAnswerKey();

        // Disable inputs and hide buttons
        lockQuizInputs();
        hideSaveAndSubmitButtons();

        if (confirm('Submit this quiz as completed with score ' + graded.score + '%?')) {
            document.getElementById('saveForm').submit();
        }
    }

    function showAnswerKey() {
        const keyText = buildAnswerKey(parsedQuestions);
        document.getElementById('answerKeyContent').textContent = keyText;
        document.getElementById('answerKeySection').style.display = 'block';
    }

    function lockQuizInputs() {
        document.querySelectorAll('.option-input').forEach(inp => {
            inp.disabled = true;
        });
    }
    function confirmDelete() {
        if (confirm('Are you sure you want to delete this quiz? This action cannot be undone.')) {
            // Create and submit a form POSTing to the delete endpoint
            const form = document.createElement('form');
            form.method = 'post';
            form.action = '/quizzes/${quiz.id}/delete';
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>