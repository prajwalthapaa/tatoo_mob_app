import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/pages/BookingPage.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

void main() {
  // Test for BookingPage
  testWidgets('BookingPage displays tattoo details and date picker', (WidgetTester tester) async {
    // Build the widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BookingPage(tattooId: '1', tattooName: 'Tattoo Design 1'),
      ),
    );

    // Check if the tattoo name is displayed
    expect(find.text('Tattoo Design 1'), findsOneWidget);

    // Check if the select date text is displayed
    expect(find.text('Select Appointment Date:'), findsOneWidget);

    // Check if the date is default "Select Date"
    expect(find.text('Select Date'), findsOneWidget);

    // Check if the confirm booking button is present
    expect(find.text('Confirm Booking'), findsOneWidget);
  });

  testWidgets('Date picker works and updates the selected date', (WidgetTester tester) async {
    // Build the widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BookingPage(tattooId: '1', tattooName: 'Tattoo Design 1'),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    final DateTime selectedDate = DateTime(2025, 12, 25);
    await tester.tap(find.text(DateFormat.yMMMd().format(selectedDate)));
    await tester.pumpAndSettle();

    expect(find.text(DateFormat.yMMMd().format(selectedDate)), findsOneWidget);
  });

  testWidgets('Confirm Booking button shows correct SnackBar when date is selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BookingPage(tattooId: '1', tattooName: 'Tattoo Design 1'),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    final DateTime selectedDate = DateTime(2025, 12, 25);
    await tester.tap(find.text(DateFormat.yMMMd().format(selectedDate)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirm Booking'));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Booking confirmed for Tattoo Design 1 on ${DateFormat.yMMMd().format(selectedDate)}'),
        findsOneWidget);
  });

  testWidgets('Confirm Booking button shows SnackBar when no date is selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BookingPage(tattooId: '1', tattooName: 'Tattoo Design 1'),
      ),
    );

    await tester.tap(find.text('Confirm Booking'));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please select an appointment date.'), findsOneWidget);
  });
}
