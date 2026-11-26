class AuthUser {
  const AuthUser({
    required this.id,
    required this.fullName,
    required this.email,
    this.isCustodian = false,
  });

  final String id;
  final String fullName;
  final String email;
  final bool isCustodian;

  AuthUser copyWith({
    String? id,
    String? fullName,
    String? email,
    bool? isCustodian,
  }) {
    return AuthUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      isCustodian: isCustodian ?? this.isCustodian,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AuthUser &&
      other.id == id &&
      other.fullName == fullName &&
      other.email == email &&
      other.isCustodian == isCustodian;

  @override
  int get hashCode => Object.hash(id, fullName, email, isCustodian);
}
