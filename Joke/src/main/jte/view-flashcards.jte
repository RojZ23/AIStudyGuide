@import com.example.joke.Flashcard
@param java.util.List<Flashcard> flashcards
@param Long studyGuideId

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Flashcards - StudyGuide AI</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&display=swap" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
            padding: 40px;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2563eb;
            text-align: center;
            margin-bottom: 24px;
        }
        .back-button {
            display: flex;
            justify-content: center;
            margin-bottom: 24px;
        }
        .back-button a {
            background-color: #2563eb;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }
        .back-button a:hover {
            background-color: #1d4ed8;
        }

        /* Flashcards grid */
        .flashcards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 22px;
            justify-items: center;
        }

        /* Individual card wrapper */
        .card-wrapper {
            perspective: 1000px;
            width: 240px;
            height: 160px;
        }

        /* Card body, handles flipping */
        .card-body {
            position: relative;
            width: 100%;
            height: 100%;
            text-align: center;
            transition: transform 0.6s;
            transform-style: preserve-3d;
            cursor: pointer;
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
            border-radius: 16px;
        }

        /* Flip card on hover */
        .card-wrapper:hover .card-body {
            transform: rotateY(180deg);
        }

        /* Front and Back of card */
        .card-front,
        .card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            -webkit-backface-visibility: hidden;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px 20px;
            box-sizing: border-box;
        }

        /* Front style */
        .card-front {
            background-color: #2563eb;
            color: white;
            font-weight: 700;
            font-size: 20px;
            user-select: none;
        }

        /* Back style */
        .card-back {
            background-color: #f3f4f6;
            color: #1e293b;
            font-weight: 500;
            font-size: 16px;
            transform: rotateY(180deg);
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="back-button">
        <a href="/dashboard">&larr; Back to Dashboard</a>
    </div>
    <h1>Flashcards</h1>
    @if(flashcards != null && !flashcards.isEmpty())
        <div class="flashcards-grid">
            @for(Flashcard flashcard : flashcards)
                <div class="card-wrapper">
                    <div class="card-body" tabindex="0" role="button" aria-label="Flashcard for ${flashcard.term}">
                        <div class="card-front">
                            ${flashcard.term}
                        </div>
                        <div class="card-back">
                            ${flashcard.definition}
                        </div>
                    </div>
                </div>
            @endfor
        </div>
    @else
        <p>No flashcards generated yet. Go back and generate flashcards from your study guide's key terms.</p>
    @endif
</div>
</body>
</html>
