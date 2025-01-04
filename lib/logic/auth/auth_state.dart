import 'package:doctor_flutter_web/model/User.dart';

enum AuthType { login, register }

enum RegisterType { doctor, patient, init }
enum GetUserState { init, loading, failure,success }

class AuthState {
  final AuthType? authType;
  final RegisterType? registerType;
  final User? user;
  final GetUserState? getUserState;
  final String? error;

  AuthState({this.authType, this.registerType, this.user,this.getUserState = GetUserState.init,this.error});

  AuthState copyWith({
    AuthType? authType,
    RegisterType? registerType,
    User? user,
    GetUserState? getUserState,
    String? error,
  }) {
    return AuthState(
      authType: authType ?? this.authType,
      registerType: registerType ?? this.registerType,
      user: user ?? this.user,
      getUserState: getUserState ?? this.getUserState,
      error: error ?? this.error,
    );
  }
  AuthState clearUser(){
    return AuthState(user: null);
  }
}
