// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_5/main.dart';

void main() {
  testWidgets('Goal Tracker App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoalTrackerApp());

    // Wait for Firebase initialization and auth check
    await tester.pumpAndSettle();

    // Verify that the app title is correct (in app bar)
    expect(find.text('Goal Tracker App'), findsOneWidget);

    // Verify that the welcome text is displayed
    expect(find.text('Welcome to Goal Tracker App'), findsOneWidget);

    // Verify that exercise buttons are present
    expect(find.text('Exercise 1: Add Goal'), findsOneWidget);
    expect(find.text('Exercise 2: Search Goals'), findsOneWidget);
    expect(find.text('Exercise 3: Edit Goals'), findsOneWidget);
    expect(find.text('Exercise 4: Login (Already logged in)'), findsOneWidget);
  });
}
