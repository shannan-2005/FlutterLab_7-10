# Alfa Dictionary App

A Flutter application demonstrating CRUD operations with Google Firestore Database for a theme-based dictionary app named "Alfa".

## Setup Instructions

1. **Firebase Configuration**:
   - Create a Firebase project at https://console.firebase.google.com/
   - Enable Firestore Database
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`

2. **Firestore Collections**:
   - Create collection `dictionary_words` with fields: `word` (string), `meaning` (string), `timestamp` (timestamp), `brand` (string, set to "Alfa")
   - Create collection `users` with fields: `email` (string), `password` (string), `username` (string)

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   ```bash
   flutter run
   ```

## Exercises

### 1. Persistence Storage with Google Firestore Database
- **Screen**: Add Word Screen (`/add`)
- **Functionality**: Form to add new word and meaning, stored in `dictionary_words` collection
- **UI**: Clean form with validation, SnackBar on success/error

### 2. Searching Information in Google Firestore Database
- **Screen**: Search Screen (`/search`)
- **Functionality**: Search bar queries Firestore for matching words, displays results in list
- **UI**: StreamBuilder for live search, ListView for results

### 3. Update Information in Google Firestore Database
- **Screen**: Edit Word Screen (`/edit`)
- **Functionality**: List all words, tap to edit meaning, update Firestore
- **UI**: ListView with tap handlers, dialog for editing, SnackBar confirmation

### 4. Manual User Login Authentication using Google Firestore Database
- **Screen**: Login Screen (`/`)
- **Functionality**: Login form checks credentials against `users` collection, navigates to home on success
- **UI**: Form with email/password, session persistence with SharedPreferences

## Features
- Material UI design with clean layout
- Session persistence using SharedPreferences
- Real-time data with StreamBuilder
- Error handling and user feedback
- Navigation between exercises

## Dependencies
- `firebase_core`: Firebase initialization
- `cloud_firestore`: Firestore database operations
- `shared_preferences`: Local session storage
