@param String error
@param String message
@param String username

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --bg: #0f172a;
            --card-bg: #0b1120;
            --accent: #3b82f6;
            --accent-soft: rgba(59, 130, 246, 0.15);
            --accent-hover: #2563eb;
            --border-subtle: rgba(148, 163, 184, 0.3);
            --text-main: #e5e7eb;
            --text-muted: #9ca3af;
            --danger: #ef4444;
            --danger-soft: rgba(239, 68, 68, 0.15);
            --success: #22c55e;
            --success-soft: rgba(34, 197, 94, 0.15);
            --radius-lg: 16px;
            --shadow-soft: 0 24px 60px rgba(15, 23, 42, 0.95);
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: var(--text-main);
            background:
                    radial-gradient(circle at top, #1d4ed8 0, transparent 55%),
                    radial-gradient(circle at bottom, #0f766e 0, transparent 55%),
                    var(--bg);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .auth-shell {
            width: 100%;
            max-width: 420px;
            position: relative;
        }

        .auth-card {
            position: relative;
            background: radial-gradient(circle at top left, rgba(59, 130, 246, 0.25), transparent 55%),
            radial-gradient(circle at bottom right, rgba(45, 212, 191, 0.18), transparent 55%),
            linear-gradient(145deg, rgba(15, 23, 42, 0.98), rgba(15, 23, 42, 0.96));
            border-radius: var(--radius-lg);
            padding: 28px 26px 26px;
            box-shadow: var(--shadow-soft);
            border: 1px solid rgba(148, 163, 184, 0.35);
            backdrop-filter: blur(26px);
            overflow: hidden;
        }

        .auth-card::before {
            content: "";
            position: absolute;
            inset: 0;
            background:
                    linear-gradient(120deg, transparent 0 30%, rgba(148, 163, 184, 0.08) 40%, transparent 55%),
                    radial-gradient(circle at top right, rgba(59, 130, 246, 0.24), transparent 55%);
            mix-blend-mode: screen;
            opacity: 0.9;
            pointer-events: none;
        }

        .auth-inner {
            position: relative;
            z-index: 1;
        }

        .logo-pill {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 4px 11px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.9);
            border: 1px solid rgba(148, 163, 184, 0.5);
            color: var(--text-muted);
            font-size: 11px;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .logo-dot {
            width: 7px;
            height: 7px;
            border-radius: 999px;
            background: radial-gradient(circle at 30% 20%, #f97316 0, #e11d48 40%, #22c55e 100%);
            box-shadow: 0 0 14px rgba(251, 113, 133, 0.9);
        }

        .auth-header {
            margin-top: 18px;
            margin-bottom: 18px;
        }

        .auth-title {
            margin: 0 0 4px;
            font-size: 24px;
            letter-spacing: -0.03em;
        }

        .auth-subtitle {
            margin: 0;
            font-size: 13px;
            color: var(--text-muted);
        }

        .auth-subtitle span {
            color: var(--accent);
        }

        .alert {
            margin-bottom: 14px;
            border-radius: 9px;
            padding: 9px 10px 9px 11px;
            font-size: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .alert-icon {
            width: 16px;
            height: 16px;
            border-radius: 999px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            flex-shrink: 0;
        }

        .alert-error {
            background: var(--danger-soft);
            color: #fecaca;
            border: 1px solid rgba(248, 113, 113, 0.7);
        }

        .alert-error .alert-icon {
            background: rgba(248, 113, 113, 0.18);
            color: #fecaca;
        }

        .alert-success {
            background: var(--success-soft);
            color: #bbf7d0;
            border: 1px solid rgba(74, 222, 128, 0.8);
        }

        .alert-success .alert-icon {
            background: rgba(34, 197, 94, 0.2);
            color: #bbf7d0;
        }

        .auth-form {
            margin-top: 10px;
        }

        .field-group {
            margin-bottom: 13px;
        }

        .field-label-row {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 5px;
        }

        .field-label {
            font-size: 12px;
            color: var(--text-muted);
        }

        .field-label span {
            color: var(--accent);
        }

        .field-input {
            width: 100%;
            padding: 9px 10px;
            border-radius: 9px;
            border: 1px solid var(--border-subtle);
            background: rgba(15, 23, 42, 0.95);
            color: var(--text-main);
            font-size: 13px;
            outline: none;
            transition: border-color 0.16s ease, box-shadow 0.16s ease, background 0.16s ease, transform 0.05s ease;
        }

        .field-input::placeholder {
            color: rgba(148, 163, 184, 0.7);
        }

        .field-input:focus {
            border-color: rgba(59, 130, 246, 0.9);
            box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.6), 0 0 0 10px rgba(59, 130, 246, 0.1);
            background: rgba(15, 23, 42, 1);
        }

        .field-input:focus-visible {
            outline: 2px solid transparent;
        }

        .password-row {
            display: flex;
            gap: 8px;
        }

        .password-row .field-group {
            flex: 1;
            margin-bottom: 0;
        }

        .hint {
            margin-top: 6px;
            font-size: 11px;
            color: var(--text-muted);
        }

        .hint strong {
            color: #e5e7eb;
            font-weight: 500;
        }

        .primary-button {
            width: 100%;
            margin-top: 14px;
            border: none;
            border-radius: 999px;
            padding: 10px 16px;
            font-size: 13px;
            font-weight: 500;
            letter-spacing: 0.02em;
            text-transform: none;
            cursor: pointer;
            background: radial-gradient(circle at top left, #4f46e5, #2563eb);
            color: #e5e7eb;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            box-shadow:
                    0 14px 35px rgba(37, 99, 235, 0.6),
                    0 0 0 1px rgba(148, 163, 184, 0.45);
            transition: transform 0.08s ease-out, box-shadow 0.12s ease-out, filter 0.12s ease-out;
        }

        .primary-button span {
            font-size: 12px;
            opacity: 0.9;
        }

        .primary-button:hover {
            transform: translateY(-1px);
            box-shadow:
                    0 18px 45px rgba(37, 99, 235, 0.8),
                    0 0 0 1px rgba(191, 219, 254, 0.8);
            filter: brightness(1.05);
        }

        .primary-button:active {
            transform: translateY(0);
            box-shadow:
                    0 12px 30px rgba(30, 64, 175, 0.7),
                    0 0 0 1px rgba(129, 140, 248, 0.8);
            filter: brightness(0.98);
        }

        .primary-button:focus-visible {
            outline: 2px solid #bfdbfe;
            outline-offset: 2px;
        }

        .primary-button-icon {
            font-size: 13px;
        }

        .auth-footer {
            margin-top: 14px;
            font-size: 12px;
            color: var(--text-muted);
            display: flex;
            justify-content: space-between;
            gap: 10px;
            flex-wrap: wrap;
        }

        .auth-footer a {
            color: var(--accent);
            text-decoration: none;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .auth-card {
                padding: 22px 18px 18px;
            }
            .auth-title {
                font-size: 21px;
            }
            .password-row {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="auth-shell">
    <div class="auth-card">
        <div class="auth-inner">
            <div class="logo-pill">
                <div class="logo-dot"></div>
                <span>Account security</span>
            </div>

            <div class="auth-header">
                <h1 class="auth-title">Reset your password</h1>
                <p class="auth-subtitle">
                    Enter your <span>username</span> and a new password to update your account.
                </p>
            </div>

            @if(error != null && !error.isBlank())
                <div class="alert alert-error">
                    <div class="alert-icon">!</div>
                    <div>${error}</div>
                </div>
            @endif

            @if(message != null && !message.isBlank())
                <div class="alert alert-success">
                    <div class="alert-icon">✓</div>
                    <div>${message}</div>
                </div>
            @endif

            <!--
              Current behavior in your AuthController only expects "username" here.
              If you change the POST mapping to also accept newPassword + confirmPassword
              and perform the update, this form already supports that.
            -->
            <form class="auth-form" method="post" action="/forgot-password">
                <div class="field-group">
                    <div class="field-label-row">
                        <label class="field-label" for="username">Username</label>
                        <span class="field-label"><span>Required</span></span>
                    </div>
                    <input
                            class="field-input"
                            type="text"
                            id="username"
                            name="username"
                            value="${username != null ? username : ""}"
                            placeholder="your.username"
                            required
                            autocomplete="username">
                </div>

                <div class="password-row">
                    <div class="field-group">
                        <div class="field-label-row">
                            <label class="field-label" for="newPassword">New password</label>
                            <span class="field-label"><span>Required</span></span>
                        </div>
                        <input
                                class="field-input"
                                type="password"
                                id="newPassword"
                                name="newPassword"
                                placeholder="Choose a strong password"
                                required
                                minlength="8"
                                autocomplete="new-password">
                    </div>

                    <div class="field-group">
                        <div class="field-label-row">
                            <label class="field-label" for="confirmPassword">Confirm</label>
                            <span class="field-label"><span>Required</span></span>
                        </div>
                        <input
                                class="field-input"
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="Repeat new password"
                                required
                                minlength="8"
                                autocomplete="new-password">
                    </div>
                </div>

                <p class="hint">
                    <strong>Security tip:</strong> Use at least 8 characters, mixing letters, numbers, and symbols.
                </p>

                <button type="submit" class="primary-button">
                    <span class="primary-button-icon">⟲</span>
                    <span>Update password</span>
                </button>
            </form>

            <div class="auth-footer">
                <span>Remembered it?</span>
                <a href="/login">Back to login</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
