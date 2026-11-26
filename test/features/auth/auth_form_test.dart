import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/domain/auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_user.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/auth/presentation/widgets/auth_form.dart';

class _FakeAuthRepository implements AuthRepository {
  int signInCalls = 0;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    signInCalls++;
    if (email == 'student@aau.edu.et' && password == 'password123') {
      return const AuthUser(
        id: 'user-1',
        fullName: 'Selam Tesfaye',
        email: 'student@aau.edu.et',
      );
    }
    throw const AuthException('Incorrect email or password.');
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return AuthUser(id: 'user-100', fullName: fullName, email: email);
  }

  @override
  Future<void> signOut() async {}
}

class _Harness {
  _Harness(this.fakeRepository);

  final _FakeAuthRepository fakeRepository;
  int authenticatedCalls = 0;
}

Future<_Harness> _pump(WidgetTester tester) async {
  final fakeRepository = _FakeAuthRepository();
  final harness = _Harness(fakeRepository);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(fakeRepository)],
      retry: (retryCount, error) => null,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: AuthForm(
              onAuthenticated: () => harness.authenticatedCalls++,
            ),
          ),
        ),
      ),
    ),
  );
  return harness;
}

Future<void> _tap(WidgetTester tester, Key key) async {
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('empty submit shows validation errors', (tester) async {
    final harness = await _pump(tester);

    await _tap(tester, const Key('auth-submit'));

    expect(find.text('Please enter your email.'), findsOneWidget);
    expect(find.text('Please enter your password.'), findsOneWidget);
    expect(harness.authenticatedCalls, 0);
  });

  testWidgets('toggle switches to the register form', (tester) async {
    await _pump(tester);
    expect(find.byKey(const Key('auth-name')), findsNothing);

    await _tap(tester, const Key('auth-toggle-mode'));

    expect(find.byKey(const Key('auth-name')), findsOneWidget);
    expect(find.byKey(const Key('auth-confirm')), findsOneWidget);
  });

  testWidgets('valid credentials sign in and call the callback', (
    tester,
  ) async {
    final harness = await _pump(tester);

    await tester.enterText(
      find.byKey(const Key('auth-email')),
      'student@aau.edu.et',
    );
    await tester.enterText(
      find.byKey(const Key('auth-password')),
      'password123',
    );
    await _tap(tester, const Key('auth-submit'));

    expect(harness.fakeRepository.signInCalls, 1);
    expect(harness.authenticatedCalls, 1);
  });

  testWidgets('wrong password shows an error and does not call back', (
    tester,
  ) async {
    final harness = await _pump(tester);

    await tester.enterText(
      find.byKey(const Key('auth-email')),
      'student@aau.edu.et',
    );
    await tester.enterText(find.byKey(const Key('auth-password')), 'wrongpass');
    await _tap(tester, const Key('auth-submit'));

    expect(find.text('Incorrect email or password.'), findsOneWidget);
    expect(harness.authenticatedCalls, 0);
  });
}
