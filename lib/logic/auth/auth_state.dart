enum AuthType { login, register }
enum RegisterType { doctor, patient ,init}

class AuthState {
  final AuthType? authType;
  final RegisterType? registerType;

  AuthState({this.authType,this.registerType});

  AuthState copyWith({
    AuthType? authType,
    RegisterType? registerType,
  }) {
    return AuthState(
        authType: authType ?? this.authType,
      registerType: registerType ?? this.registerType,
    );
  }
}
