import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_booking/presentation/pages/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading process
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Logo
            Image.asset('assets/tatto-bg.jpg', height: 150),
            SizedBox(height: 20),
            // Tagline
            Text(
              'Book Your Ink with Ease',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink), // Tattoo-inspired color
            ),
          ],
        ),
      ),
    );
  }
}
