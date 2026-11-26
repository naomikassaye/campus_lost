import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/auth/data/in_memory_auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_user.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => InMemoryAuthRepository(),
);

final initialAuthUserProvider = Provider<AuthUser?>((ref) => null);

class AuthState {
  const AuthState({this.user, this.isLoading = false, this.error});

  final AuthUser? user;
  final bool isLoading;
  final String? error;
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState(user: ref.watch(initialAuthUserProvider));

  Future<bool> signIn({required String email, required String password}) async {
    state = const AuthState(isLoading: true);
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
      state = AuthState(user: user);
      return true;
    } on AuthException catch (e) {
      state = AuthState(error: e.message);
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = const AuthState(isLoading: true);
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .register(fullName: fullName, email: email, password: password);
      state = AuthState(user: user);
      return true;
    } on AuthException catch (e) {
      state = AuthState(error: e.message);
      return false;
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState();
  }

  void clearError() {
    if (state.error != null) state = AuthState(user: state.user);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

final currentUserProvider = Provider<AuthUser?>(
  (ref) => ref.watch(authControllerProvider.select((state) => state.user)),
);

enum AuthMode { signIn, register }

class AuthModeNotifier extends Notifier<AuthMode> {
  @override
  AuthMode build() => AuthMode.signIn;

  void toggle() {
    state = state == AuthMode.signIn ? AuthMode.register : AuthMode.signIn;
  }
}

final authModeProvider =
    NotifierProvider.autoDispose<AuthModeNotifier, AuthMode>(
      AuthModeNotifier.new,
    );
