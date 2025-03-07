import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tattoo_booking_app/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:tattoo_booking_app/presentation/bloc/tattooBloc/tatto_bloc.dart';
import 'package:tattoo_booking_app/presentation/pages/splash_Screen.dart';

import 'core/theme/app_theme.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (final context) => di<AuthBloc>()),
        BlocProvider<TattooBloc>(create: (final context) => di<TattooBloc>()),
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
