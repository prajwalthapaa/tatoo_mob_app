import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  const String baseUrl = 'http://10.0.2.2:8000/api';
  const String email = 'testuser@example.com';
  const String password = 'password123';

  group('Authentication Tests', () {
    test('User registration works', () async {
      final response = await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': 'saroj',
          'email': email,
          'password': password,
        }),
      );

      expect(response.statusCode, 201);
      expect(json.decode(response.body), contains('token'));
    });

    test('User login works with correct credentials', () async {
      // Register the user first
      await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      expect(response.statusCode, 200);
      expect(json.decode(response.body), contains('token'));
    });

    test('Login fails with incorrect credentials', () async {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': 'wrongpassword',
        }),
      );

      expect(response.statusCode, 400);
      expect(json.decode(response.body), contains('message'));
      expect(json.decode(response.body)['message'], 'Invalid credentials');
    });

    test('Access protected route with valid token', () async {
      final loginResponse = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final token = json.decode(loginResponse.body)['token'];

      final response = await http.get(
        Uri.parse('$baseUrl/protected-route'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      expect(response.statusCode, 200);
      expect(json.decode(response.body), contains('message'));
      expect(json.decode(response.body)['message'], 'You are authorized');
    });

    test('Access protected route with invalid token', () async {
      final response = await http.get(
        Uri.parse('$baseUrl/protected-route'),
        headers: {
          'Authorization': 'Bearer invalidtoken',
        },
      );

      expect(response.statusCode, 401);
      expect(json.decode(response.body), contains('message'));
      expect(json.decode(response.body)['message'], 'Invalid token');
    });
  });
}
