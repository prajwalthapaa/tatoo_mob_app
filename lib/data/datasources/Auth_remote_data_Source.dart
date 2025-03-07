import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource({required this.dio});
  Future<bool> createAccount(String name, String email, String password) async {
    try {
      final response = await dio
          .post("http://10.0.2.2:8000/api/user/register", data: {'name': name, 'email': email, 'password': password});

      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        String token = response.data['token'];
        String name = response.data['user']['name'];
        String email = response.data['user']['email'];
        await prefs.setString('auth_token', token);
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(
        "http://10.0.2.2:8000/api/user/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      print(response);
      print(response.data['user']['name']);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        String token = response.data['token'];
        String name = response.data['user']['name'];
        String email = response.data['user']['email'];
        print(name);
        print(email);
        await prefs.setString('auth_token', token);
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Log the error if needed
      print('Error logging in: $e');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    return token != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
