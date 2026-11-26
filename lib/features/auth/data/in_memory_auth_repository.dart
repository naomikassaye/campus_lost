import 'package:campus_lost/features/auth/domain/auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_user.dart';

class _Account {
  const _Account(this.user, this.password);

  final AuthUser user;
  final String password;
}

class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository() {
    for (final account in _seed) {
      _accounts[account.user.email] = account;
    }
  }

  static const List<_Account> _seed = [
    _Account(
      AuthUser(
        id: 'user-1',
        fullName: 'Selam Kebede',
        email: 'student@aau.edu.et',
      ),
      'password123',
    ),
    _Account(
      AuthUser(
        id: 'custodian-1',
        fullName: 'Kebede Abebe',
        email: 'custodian@aau.edu.et',
        isCustodian: true,
      ),
      'password123',
    ),
  ];

  final Map<String, _Account> _accounts = {};
  int _nextId = 100;

  String _key(String email) => email.trim().toLowerCase();

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final account = _accounts[_key(email)];
    if (account == null || account.password != password) {
      throw const AuthException('Incorrect email or password.');
    }
    return account.user;
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final key = _key(email);
    if (_accounts.containsKey(key)) {
      throw const AuthException('An account with this email already exists.');
    }
    final user = AuthUser(
      id: 'user-${_nextId++}',
      fullName: fullName.trim(),
      email: key,
    );
    _accounts[key] = _Account(user, password);
    return user;
  }

  @override
  Future<void> signOut() async {}
}
