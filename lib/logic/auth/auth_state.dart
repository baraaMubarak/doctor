enum AuthType { login, register }

class AuthState {
  final AuthType? authType;

  AuthState({this.authType});

  AuthState copyWith({
    AuthType? authType,
  }) {
    return AuthState(
        authType: authType ?? this.authType,
    );
  }
}
