import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/core/router/app_router.dart';
import 'package:hotel_booking/core/theme/app_theme.dart';
import 'package:hotel_booking/di.dart';
import 'package:hotel_booking/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:hotel_booking/presentation/bloc/tattooBloc/tatto_bloc.dart';
import 'package:hotel_booking/presentation/pages/splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (final context) => di<AuthBloc>(),
        ),
        BlocProvider<TattooBloc>(
          create: (final context) => di<TattooBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking',
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
