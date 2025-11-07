# TODO List for Alfa Dictionary App Exercises

- [x] Update pubspec.yaml: Add cloud_firestore, firebase_core, shared_preferences dependencies
- [x] Modify lib/main.dart: Change app name to "Alfa", create home screen with navigation to 4 exercise screens
- [x] Create lib/services/firestore_service.dart: Handle Firestore operations (CRUD for words and users)
- [x] Create lib/models/word.dart: Model for dictionary word
- [x] Create lib/models/user.dart: Model for user
- [x] Create lib/screens/add_word_screen.dart: Exercise 1 - Form to add word, save to Firestore
- [x] Create lib/screens/search_screen.dart: Exercise 2 - Search bar, query Firestore, display list with StreamBuilder
- [x] Create lib/screens/edit_word_screen.dart: Exercise 3 - List words, tap to edit, update Firestore, show SnackBar
- [x] Create lib/screens/login_screen.dart: Exercise 4 - Login form, check against Firestore users, navigate to home, use SharedPreferences for session
- [x] Update README.md: Add setup instructions and exercise descriptions
- [x] Run flutter pub get
- [x] Test each screen (manual verification)
