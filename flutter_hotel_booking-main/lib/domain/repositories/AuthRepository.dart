abstract class AuthRepository {
  Future<bool> createAccount(String name, String email, String password);
  Future<bool> login(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
}
