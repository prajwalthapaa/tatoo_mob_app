import 'package:hotel_booking/domain/repositories/AuthRepository.dart';

class AuthUseCase {
  final AuthRepository repository;
  AuthUseCase(this.repository);
  Future<bool> createAccount(String name, String email, String password) async {
    return await repository.createAccount(name, email, password);
  }

  Future<bool> login(String email, String password) async {
    return await repository.login(email, password);
  }

  Future<bool> isLoggedIn() async {
    return await repository.isLoggedIn();
  }

  Future<void> logout() async {
    await repository.logout();
  }
}
