import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:hotel_booking/presentation/pages/LoginPage.dart';
import 'package:hotel_booking/presentation/pages/SignUpPage.dart';
import 'package:hotel_booking/presentation/pages/home_page.dart';
import 'package:mockito/mockito.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  group('LoginPage Widget Test', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    testWidgets('renders LoginPage and tests UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: LoginPage(),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
    });

    testWidgets('shows error message when login fails', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthErrorState('Login failed'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: LoginPage(),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Login failed'), findsOneWidget);
    });

    testWidgets('calls LoginEvent and navigates to HomePage on successful login', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthSuccessState(true));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: LoginPage(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockAuthBloc.add(LoginEvent('test@example.com', 'password123'))).called(1);

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('navigates to SignUpPage when the Sign Up link is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: LoginPage(),
          ),
        ),
      );

      await tester.tap(find.text("Don't have an account? Sign Up"));
      await tester.pumpAndSettle();

      expect(find.byType(SignUpPage), findsOneWidget);
    });
  });
}
