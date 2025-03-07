import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/authBloc/auth_bloc.dart';
import 'SignUpPage.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/tatto-bg.jpg"), // Add a tattoo-themed background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6), // Dark overlay for better visibility
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(child: CircularProgressIndicator()),
                );
              }

              if (state is AuthSuccessState) {
                Navigator.of(context).pop();
                if (state.isLoggedIn) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                }
              }

              if (state is AuthErrorState) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tatoo craft",
                      style: GoogleFonts.permanentMarker(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black45,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black45,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        if (email.isNotEmpty && password.isNotEmpty) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(email, password));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please fill in all fields'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Sign-Up Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
