import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/auth/domain/auth_validators.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({required this.onAuthenticated, super.key});

  /// Called once after a successful sign-in or registration.
  final void Function() onAuthenticated;

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool _validate(bool isRegister) {
    final nameError = isRegister
        ? AuthValidators.fullName(_nameController.text)
        : null;
    final emailError = AuthValidators.email(_emailController.text);
    final passwordError = AuthValidators.password(
      _passwordController.text,
      checkLength: isRegister,
    );
    final confirmError = isRegister
        ? AuthValidators.confirmPassword(
            _confirmController.text,
            _passwordController.text,
          )
        : null;

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _passwordError = passwordError;
      _confirmError = confirmError;
    });

    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmError == null;
  }

  Future<void> _submit() async {
    final isRegister = ref.read(authModeProvider) == AuthMode.register;
    if (!_validate(isRegister)) return;

    final controller = ref.read(authControllerProvider.notifier);
    final success = isRegister
        ? await controller.register(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          )
        : await controller.signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

    if (!mounted) return;
    if (success) widget.onAuthenticated();
  }

  void _toggleMode() {
    ref.read(authControllerProvider.notifier).clearError();
    ref.read(authModeProvider.notifier).toggle();
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRegister = ref.watch(authModeProvider) == AuthMode.register;
    final isLoading = ref.watch(
      authControllerProvider.select((state) => state.isLoading),
    );
    final error = ref.watch(
      authControllerProvider.select((state) => state.error),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isRegister) ...[
          TextField(
            key: const Key('auth-name'),
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: const Icon(Icons.person_outline),
              errorText: _nameError,
            ),
          ),
          const SizedBox(height: 16),
        ],
        TextField(
          key: const Key('auth-email'),
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'University email',
            prefixIcon: const Icon(Icons.email_outlined),
            errorText: _emailError,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          key: const Key('auth-password'),
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            errorText: _passwordError,
            suffixIcon: IconButton(
              tooltip: _obscurePassword ? 'Show password' : 'Hide password',
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
        if (isRegister) ...[
          const SizedBox(height: 16),
          TextField(
            key: const Key('auth-confirm'),
            controller: _confirmController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Confirm password',
              prefixIcon: const Icon(Icons.lock_outline),
              errorText: _confirmError,
            ),
          ),
        ],
        if (error != null) ...[
          const SizedBox(height: 16),
          Text(
            error,
            key: const Key('auth-error'),
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ],
        const SizedBox(height: 24),
        FilledButton(
          key: const Key('auth-submit'),
          onPressed: isLoading ? null : _submit,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : Text(isRegister ? 'Create account' : 'Sign in'),
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const Key('auth-toggle-mode'),
          onPressed: isLoading ? null : _toggleMode,
          child: Text(
            isRegister
                ? 'Already have an account? Sign in'
                : 'New here? Create an account',
          ),
        ),
      ],
    );
  }
}
