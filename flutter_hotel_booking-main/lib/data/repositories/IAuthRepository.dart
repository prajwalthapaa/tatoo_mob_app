import 'package:hotel_booking/data/datasources/Auth_remote_data_Source.dart';
import 'package:hotel_booking/domain/repositories/AuthRepository.dart';

class IAuthRepository implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  IAuthRepository({required this.dataSource});
  @override
  Future<bool> createAccount(String name, String email, String password) async {
    return dataSource.createAccount(name, email, password);
  }

  @override
  Future<bool> isLoggedIn() {
    return dataSource.isLoggedIn();
  }

  @override
  Future<bool> login(String email, String password) async {
    return await dataSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }
}
