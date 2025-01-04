import 'dart:convert';

import 'package:doctor_flutter_web/core/api/api_config.dart';
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:doctor_flutter_web/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(super.initialState);
  changeAuthType({required AuthType authType}){
    emit(state.copyWith(authType: authType,registerType: RegisterType.init));
  }
  changeRegisterType({required RegisterType registerType}){
    emit(state.copyWith(registerType: registerType));
  }

  getUser({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if(user!=null) {
      User user = User.fromJson(jsonDecode(prefs.getString('user')!));
      emit(state.copyWith(user: user));
    }else if(state.user == null){
      Navigator.pushReplacementNamed(context, '/login');
    }else{
      emit(state.copyWith(user: state.user));
    }
    Logger().f(state.user);
  }
  _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));  // Save your state in a string format
  }

  logout(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    },);
    emit(state.clearUser());
    Navigator.pushReplacementNamed(context, '/login');
  }

  login({required String userName,required String password}) async {
    emit(state.copyWith(getUserState: GetUserState.loading));
    Logger().d(userName + password);
    var response = await http.post(Uri.parse(ApiConfig.login), body: jsonEncode({
      'username':userName,
      'password':password,
    }),headers: {
      'Content-Type': 'application/json',
    });
    Logger().f(response.body);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        getUserState: GetUserState.success,
        user: User.fromJson(jsonDecode(response.body)['user'],token:jsonDecode(response.body)['access_token']),
      ));
      _saveUser(state.user!);
    } else {
      emit(state.copyWith(
        getUserState: GetUserState.failure,
        error: 'اسم المستخدم أو كلمة المرور غير صحيحة',
      ));
    }

  }
  register(User user) async {

    // return;
    emit(state.copyWith(getUserState: GetUserState.loading));
    final Uri url;
    bool isPatient = state.registerType == RegisterType.patient;
    if (!isPatient) {
      url = Uri.parse(ApiConfig.registerDoctor);
    } else {
      url = Uri.parse(ApiConfig.registerPatient);
    }
    Map body = {
      "name": user.name,//
      "email": user.email,//
      "username": user.username,//
      "role": isPatient? "patient" : 'doctor',//
      "phone_number": user.phoneNumber,//
      "address": user.address,//
      "is_verified": false,//
    };
    if(isPatient) {
      body.addAll({
        "national_id": user.nationalId,
        "health_insurance_number": user.healthInsuranceNumber,
        "age": user.age,
        "gender": user.gender,
        ...body
      });
    }else {
      body.addAll({
        "specialty": user.specialty,
        ...body
      });
    }
    Logger().d(body);
    var response = await http.post(url, body: jsonEncode(body),headers: {
      'Content-Type': 'application/json',
    });
    Logger().d(jsonDecode(response.body));
    if (response.statusCode == 201) {

      emit(state.copyWith(
        getUserState: GetUserState.success,
        user: User.fromJson(jsonDecode(response.body)['user'],token:jsonDecode(response.body)['access_token']),
      ));
      _saveUser(state.user!);
    } else {
      String error = '';
      final errors = jsonDecode(response.body)['errors'];
      errors.forEach((key, value) {
        for(int i =0;i<errors[key]!.length;i++) {
          error += '$key: ${(value)[i]}\n';
        }
      },);
      emit(state.copyWith(
          getUserState: GetUserState.failure,
          error: error,
      ));
    }
  }
}