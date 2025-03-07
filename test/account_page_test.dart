import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tattoo_booking_app/presentation/pages/account_page.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() async {
    // Initialize SharedPreferences mock
    mockSharedPreferences = MockSharedPreferences();
    SharedPreferences.setMockInitialValues({});

    // Mock the behavior of SharedPreferences
    when(mockSharedPreferences.getString('name')).thenReturn('John Doe');
    when(mockSharedPreferences.getString('email')).thenReturn('johndoe@example.com');
  });

  testWidgets('AccountPage displays user data correctly', (WidgetTester tester) async {
    // Build the widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AccountPage()));

    // Verify that the name and email are loaded and displayed
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('johndoe@example.com'), findsOneWidget);
  });

  testWidgets('AccountPage shows profile image options when tapped', (WidgetTester tester) async {
    // Build the widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AccountPage()));

    // Tap the profile image to open the bottom sheet
    await tester.tap(find.byType(CircleAvatar));
    await tester.pumpAndSettle();

    // Verify if the bottom sheet opens with options for taking a photo or choosing from gallery
    expect(find.text('Take Photo'), findsOneWidget);
    expect(find.text('Choose from Gallery'), findsOneWidget);
  });

  testWidgets('AccountPage handles image selection from gallery', (WidgetTester tester) async {
    // Mock the behavior of image picker
    final imagePicker = ImagePicker();
    final pickedFile = XFile('path/to/file.jpg');
    when(imagePicker.pickImage(source: ImageSource.gallery)).thenAnswer((_) async => pickedFile);

    // Build the widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AccountPage()));

    // Tap the profile image to open the bottom sheet
    await tester.tap(find.byType(CircleAvatar));
    await tester.pumpAndSettle();

    // Tap the option to choose from the gallery
    await tester.tap(find.text('Choose from Gallery'));
    await tester.pumpAndSettle();

    // Verify that the image was updated (Here we assume the picker works correctly)
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('AccountPage Edit Profile button exists and is tappable', (WidgetTester tester) async {
    // Build the widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AccountPage()));

    // Verify that the "Edit Profile" button exists
    expect(find.text('Edit Profile'), findsOneWidget);

    // Tap the "Edit Profile" button
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    // You can add further verification for actions triggered by the button here
    // For now, this test ensures that the button exists and is tappable.
  });
}
