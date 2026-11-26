abstract final class AuthValidators {
  static const String allowedDomain = 'aau.edu.et';

  static String? fullName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter your full name.';
    if (text.length < 2) return 'Name must contain at least 2 characters.';
    return null;
  }

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Please enter your email.';
    if (text.contains(' ')) return 'Please enter a valid email.';

    final atIndex = text.indexOf('@');
    final hasSingleAt = atIndex > 0 && text.indexOf('@', atIndex + 1) == -1;
    if (!hasSingleAt) return 'Please enter a valid email.';

    final domain = text.substring(atIndex + 1);
    final validDomain =
        domain.contains('.') &&
        !domain.startsWith('.') &&
        !domain.endsWith('.');
    if (!validDomain) return 'Please enter a valid email.';

    if (domain.toLowerCase() != allowedDomain) {
      return 'Please use your @$allowedDomain university email.';
    }

    return null;
  }

  static String? password(String? value, {bool checkLength = true}) {
    final text = value ?? '';
    if (text.isEmpty) return 'Please enter your password.';
    if (checkLength && text.length < 8) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password.';
    if (value != password) return 'Passwords do not match.';
    return null;
  }
}
