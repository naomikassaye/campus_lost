import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campus_lost/features/auth/data/in_memory_auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_repository.dart';
import 'package:campus_lost/features/auth/domain/auth_validators.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';

void main() {
  group('AuthValidators', () {
    test('email accepts @aau.edu.et and rejects invalid or other domains', () {
      expect(AuthValidators.email('student@aau.edu.et'), isNull);
      expect(AuthValidators.email('Student@AAU.EDU.ET'), isNull);

      expect(AuthValidators.email(''), isNotNull);
      expect(AuthValidators.email('not-an-email'), isNotNull);
      expect(
        AuthValidators.email('student@gmail.com'),
        'Please use your @aau.edu.et university email.',
      );
      expect(
        AuthValidators.email('student@not-aau.edu.et'),
        'Please use your @aau.edu.et university email.',
      );
    });

    test('password enforces 8-char length only when checkLength is true', () {
      expect(AuthValidators.password(''), isNotNull);
      expect(AuthValidators.password('short'), isNotNull);
      expect(AuthValidators.password('short', checkLength: false), isNull);
      expect(AuthValidators.password('longenough1'), isNull);
    });

    test('fullName and confirmPassword enforce rules', () {
      expect(AuthValidators.fullName('A'), isNotNull);
      expect(AuthValidators.fullName('Ab'), isNull);
      expect(AuthValidators.confirmPassword('abc', 'abcd'), isNotNull);
      expect(AuthValidators.confirmPassword('abcd', 'abcd'), isNull);
    });
  });

  group('InMemoryAuthRepository', () {
    test('register creates a non-custodian that can sign in', () async {
      final repository = InMemoryAuthRepository();

      final created = await repository.register(
        fullName: 'New Student',
        email: 'new@aau.edu.et',
        password: 'password123',
      );
      final signedIn = await repository.signIn(
        email: 'new@aau.edu.et',
        password: 'password123',
      );

      expect(created.isCustodian, isFalse);
      expect(signedIn.id, created.id);
    });

    test('register rejects a duplicate email', () {
      expect(
        InMemoryAuthRepository().register(
          fullName: 'Copy',
          email: 'student@aau.edu.et',
          password: 'password123',
        ),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('AuthController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer.test();
    });

    test('signIn exposes student and custodian users', () async {
      final controller = container.read(authControllerProvider.notifier);

      final studentOk = await controller.signIn(
        email: '  Student@AAU.edu.et ',
        password: 'password123',
      );
      expect(studentOk, isTrue);
      expect(container.read(currentUserProvider)?.id, 'user-1');
      expect(container.read(currentUserProvider)?.isCustodian, isFalse);

      await controller.signIn(
        email: 'custodian@aau.edu.et',
        password: 'password123',
      );
      expect(container.read(currentUserProvider)?.isCustodian, isTrue);
    });

    test('failed signIn sets an error and leaves no current user', () async {
      final ok = await container
          .read(authControllerProvider.notifier)
          .signIn(email: 'student@aau.edu.et', password: 'nope');

      expect(ok, isFalse);
      expect(container.read(currentUserProvider), isNull);
      expect(container.read(authControllerProvider).error, isNotNull);
    });

    test('signOut clears the current user', () async {
      final controller = container.read(authControllerProvider.notifier);
      await controller.signIn(
        email: 'student@aau.edu.et',
        password: 'password123',
      );

      await controller.signOut();

      expect(container.read(currentUserProvider), isNull);
    });
  });
}
