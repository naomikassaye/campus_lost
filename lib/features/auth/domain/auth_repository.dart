import 'package:campus_lost/features/auth/domain/auth_user.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}

abstract interface class AuthRepository {
  Future<AuthUser> signIn({required String email, required String password});

  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signOut();
}
