
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(super.initialState);
  changeAuthType({required AuthType authType}){
    emit(state.copyWith(authType: authType,registerType: RegisterType.init));
  }
  changeRegisterType({required RegisterType registerType}){
    emit(state.copyWith(registerType: registerType));
  }
}