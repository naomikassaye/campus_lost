import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String fullName,
    required String email,
    @Default(false) bool isCustodian,
  }) = _AuthUser;
}
