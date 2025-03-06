// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:hotel_booking/presentation/pages/ProfilePage.dart';
//
// void main() {
//   group('ProfilePage Widget Test', () {
//     testWidgets('renders ProfilePage and checks UI elements', (WidgetTester tester) async {
//       // Build the widget and trigger a frame.
//       await tester.pumpWidget(
//         MaterialApp(
//           home: AutoRouter(),
//           routes: [
//             AutoRoute(page: ProfilePage),
//           ],
//         ),
//       );
//
//       // Verify if the profile picture (CircleAvatar) is displayed
//       expect(find.byType(CircleAvatar), findsOneWidget);
//
//       // Verify if the name is displayed
//       expect(find.text('John Doe'), findsOneWidget);
//
//       // Verify if the email is displayed
//       expect(find.text('johndoe@example.com'), findsOneWidget);
//
//       // Verify if the phone number is displayed
//       expect(find.text('+123 456 7890'), findsOneWidget);
//
//       // Verify if the location is displayed
//       expect(find.text('New York, USA'), findsOneWidget);
//
//       // Verify if the "Edit Profile" button is displayed
//       expect(find.text('Edit Profile'), findsOneWidget);
//     });
//
//     testWidgets('checks the functionality of Edit Profile button', (WidgetTester tester) async {
//       // Build the widget and trigger a frame.
//       await tester.pumpWidget(
//         MaterialApp(
//           home: AutoRouter(),
//           routes: [
//             AutoRoute(page: ProfilePage),
//           ],
//         ),
//       );
//
//       // Verify if the "Edit Profile" button is present
//       expect(find.text('Edit Profile'), findsOneWidget);
//
//       // Tap the "Edit Profile" button
//       await tester.tap(find.text('Edit Profile'));
//       await tester.pump(); // Rebuild widget after the tap
//
//       // Verify that the action was triggered.
//       // (You could check for navigation if it were implemented, but in this case, we're only testing UI interaction.)
//       // This test assumes that the button should do something (like navigation), so we would typically look for any
//       // navigation events triggered or other state changes that result from tapping the button.
//     });
//
//     testWidgets('ensures the ProfilePage has AppBar with title "Profile"', (WidgetTester tester) async {
//       // Build the widget and trigger a frame.
//       await tester.pumpWidget(
//         MaterialApp(
//           home: AutoRouter(),
//           routes: [
//             AutoRoute(page: ProfilePage),
//           ],
//         ),
//       );
//
//       // Verify if AppBar is present and has correct title
//       expect(find.byType(AppBar), findsOneWidget);
//       expect(find.text('Profile'), findsOneWidget);
//     });
//   });
// }
