<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AI Study Guide Generator</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background:
                    radial-gradient(circle at top, #1d4ed8 0, transparent 55%),
                    radial-gradient(circle at bottom, #0f766e 0, transparent 55%),
                    #020617;
            color: #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .shell {
            width: 100%;
            max-width: 980px;
            display: grid;
            grid-template-columns: minmax(0, 3fr) minmax(0, 2fr);
            gap: 32px;
            align-items: center;
        }

        @media (max-width: 768px) {
            .shell {
                grid-template-columns: 1fr;
            }
        }

        .hero {
            max-width: 520px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 4px 10px;
            border-radius: 999px;
            border: 1px solid rgba(148, 163, 184, 0.5);
            background: rgba(15, 23, 42, 0.9);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: #9ca3af;
        }

        .badge-dot {
            width: 8px;
            height: 8px;
            border-radius: 999px;
            background: radial-gradient(circle at 30% 20%, #a5b4fc 0, #4f46e5 40%, #22c55e 100%);
            box-shadow: 0 0 16px rgba(129, 140, 248, 0.9);
        }

        h1 {
            margin: 18px 0 10px;
            font-size: clamp(2.4rem, 3vw + 1rem, 3.3rem);
            line-height: 1.05;
            letter-spacing: -0.04em;
        }

        h1 span {
            background: linear-gradient(120deg, #60a5fa, #a855f7, #22c55e);
            -webkit-background-clip: text;
            color: transparent;
        }

        .subtitle {
            margin: 0 0 20px;
            font-size: 14px;
            color: #9ca3af;
            max-width: 430px;
        }

        .subtitle strong {
            color: #e5e7eb;
            font-weight: 500;
        }

        .cta-row {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 18px;
        }

        .btn-primary, .btn-outline {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 10px 18px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: transform 0.07s ease-out, box-shadow 0.1s ease-out, background 0.1s ease-out, color 0.1s ease-out;
        }

        .btn-primary {
            background: radial-gradient(circle at top left, #4f46e5, #2563eb);
            color: #e5e7eb;
            box-shadow:
                    0 12px 30px rgba(37, 99, 235, 0.7),
                    0 0 0 1px rgba(129, 140, 248, 0.7);
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow:
                    0 18px 40px rgba(37, 99, 235, 0.9),
                    0 0 0 1px rgba(191, 219, 254, 0.9);
        }

        .btn-outline {
            border: 1px solid rgba(148, 163, 184, 0.8);
            color: #e5e7eb;
            background: rgba(15, 23, 42, 0.6);
        }

        .btn-outline:hover {
            background: rgba(15, 23, 42, 0.95);
            transform: translateY(-1px);
        }

        .cta-note {
            font-size: 11px;
            color: #9ca3af;
        }

        .cta-note span {
            color: #a5b4fc;
        }

        .panel {
            position: relative;
            border-radius: 20px;
            padding: 20px 18px;
            background:
                    radial-gradient(circle at top left, rgba(56, 189, 248, 0.16), transparent 55%),
                    radial-gradient(circle at bottom right, rgba(129, 140, 248, 0.18), transparent 55%),
                    rgba(15, 23, 42, 0.96);
            border: 1px solid rgba(148, 163, 184, 0.35);
            box-shadow:
                    0 24px 60px rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(24px);
        }

        .panel-title {
            font-size: 13px;
            color: #e5e7eb;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .pill {
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            padding: 2px 7px;
            border-radius: 999px;
            border: 1px solid rgba(129, 140, 248, 0.7);
            color: #c7d2fe;
            background: rgba(15, 23, 42, 0.8);
        }

        .panel-list {
            list-style: none;
            padding-left: 0;
            margin: 0;
            font-size: 12px;
            color: #9ca3af;
        }

        .panel-list li {
            display: flex;
            gap: 8px;
            padding: 6px 0;
        }

        .panel-list li span {
            color: #a5b4fc;
        }
    </style>
</head>
<body>
<div class="shell">
    <section class="hero">
        <div class="badge">
            <div class="badge-dot"></div>
            <span>AI Study Guide Generator</span>
        </div>

        <h1>
            Turn your <span>notes</span> into smart study guides.
        </h1>

        <p class="subtitle">
            Paste your class notes, pick a topic, and let the AI generate
            <strong>quizzes, summaries, and flashcards</strong> in seconds.
        </p>

        <div class="cta-row">
            <a href="/register" class="btn-primary">
                Get started free
            </a>
            <a href="/login" class="btn-outline">
                I already have an account
            </a>
        </div>

        <p class="cta-note">
            No credit card needed. <span>Log in</span> anytime to see all your generated study guides.
        </p>
    </section>

    <aside class="panel">
        <div class="panel-title">
            What can it generate?
            <span class="pill">Live preview</span>
        </div>
        <ul class="panel-list">
            <li><span>•</span> Clean summaries for each chapter.</li>
            <li><span>•</span> Multiple-choice and short-answer questions.</li>
            <li><span>•</span> Flashcards you can review before exams.</li>
            <li><span>•</span> Quick “exam mode” practice sets.</li>
        </ul>
    </aside>
</div>
</body>
</html>
