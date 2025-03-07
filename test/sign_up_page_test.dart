import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tattoo_booking_app/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:tattoo_booking_app/presentation/pages/LoginPage.dart';
import 'package:tattoo_booking_app/presentation/pages/SignUpPage.dart';
import 'package:tattoo_booking_app/presentation/pages/home_page.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  group('SignUpPage Widget Test', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    testWidgets('renders SignUpPage and tests UI elements', (WidgetTester tester) async {
      // Build the widget and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(home: BlocProvider<AuthBloc>(create: (_) => mockAuthBloc, child: SignUpPage())),
      );

      // Verify if the sign-up form fields exist
      expect(find.byType(TextField), findsNWidgets(4)); // Four text fields (name, email, password, confirm password)
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);

      // Verify SignUp button
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Verify Login link
      expect(find.text("Already have an account? Login"), findsOneWidget);
    });

    testWidgets('shows error message when fields are empty and SignUp is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: BlocProvider<AuthBloc>(create: (_) => mockAuthBloc, child: SignUpPage())),
      );

      // Tap the SignUp button without filling fields
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild widget after button tap

      // Verify the error message is shown
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Please fill in all fields'), findsOneWidget);
    });

    testWidgets('calls CreateAccountEvent and navigates to HomePage on successful sign up', (
      WidgetTester tester,
    ) async {
      when(mockAuthBloc.state).thenReturn(AuthSuccessState(true));

      await tester.pumpWidget(
        MaterialApp(home: BlocProvider<AuthBloc>(create: (_) => mockAuthBloc, child: SignUpPage())),
      );

      await tester.enterText(find.byType(TextField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextField).at(1), 'john.doe@example.com');
      await tester.enterText(find.byType(TextField).at(2), 'password123');
      await tester.enterText(find.byType(TextField).at(3), 'password123');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockAuthBloc.add(CreateAccountEvent('John Doe', 'john.doe@example.com', 'password123'))).called(1);

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('navigates to LoginPage when the "Already have an account? Login" link is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: BlocProvider<AuthBloc>(create: (_) => mockAuthBloc, child: SignUpPage())),
      );

      await tester.tap(find.text("Already have an account? Login"));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('shows loading spinner when AuthBloc is in loading state', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthLoadingState());

      await tester.pumpWidget(
        MaterialApp(home: BlocProvider<AuthBloc>(create: (_) => mockAuthBloc, child: SignUpPage())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when AuthBloc has error state', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthErrorState('Sign Up failed'));

      await tester.pumpWidget(
        MaterialApp(home: BlocProvider<AuthBloc>(create: (_) => mockAuthBloc, child: SignUpPage())),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Sign Up failed'), findsOneWidget);
    });
  });
}
