# FrenchPro

Flutter source for the FrenchPro A1/A2 study app embedded in the student
portal at `/french-pro`.

## Main Features

- 300-word A1/A2 vocabulary library with filters and conjugations
- Flashcards, quizzes, roleplay, and progress tracking
- 240 short writing-practice model texts, balanced across A1 and A2
- Grammar explanations, selectable French text, and tappable translations
- Light and dark themes

## Test

```powershell
flutter test
flutter analyze
```

## Build For The Student Portal

From this folder:

```powershell
flutter build web --release --base-href /french-pro/
Copy-Item build\web\* ..\vercel_student_portal\french-pro -Recurse -Force
```

The Flutter source remains in this folder. The portal contains the compiled
web build only.
