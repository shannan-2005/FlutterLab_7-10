# Goal Tracker App Retheming TODO

- [x] Rename model: Change Flight to Goal in lib/models/word.dart, update fields 'flight' → 'goal', 'details' → 'description', 'airline' → 'category'.
- [x] Update firestore_service.dart: Change collection 'flights' → 'goals', field names, category 'SkyAir' → 'Personal'.
- [x] Update lib/screens/login_screen.dart: App bar title to 'Login - Goal Tracker', change app bar color to soft blue.
- [x] Update lib/screens/add_word_screen.dart: App bar title to 'Add Goal', labels 'Flight Number' → 'Goal Title', 'Flight Details' → 'Goal Description', messages to 'Goal added', button 'Add Flight' → 'Add Goal', app bar color.
- [x] Update lib/screens/search_screen.dart: App bar title to 'Search Goals', label 'Search for a flight' → 'Search for a goal', 'No flights found' → 'No goals found', app bar color, add goal icon to list.
- [x] Update lib/screens/edit_word_screen.dart: Already themed, verify consistency.
- [x] Update lib/main.dart: App title 'Flight Reservation App' → 'Goal Tracker App', home screen title 'Goal Tracker App', welcome text 'Welcome to Goal Tracker App', button texts to goal exercises, app bar color.
- [x] Update test/widget_test.dart: Change FlightReservationApp to GoalTrackerApp, update test strings to goal theme.
- [ ] Run app to verify UI changes and functionality.
