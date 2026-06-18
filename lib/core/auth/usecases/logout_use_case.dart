import 'package:cinema_app/core/auth/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> call() async {
    await repository.logout();
  }
}