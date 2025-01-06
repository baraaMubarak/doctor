import 'dart:convert';

import 'package:doctor_flutter_web/core/api/api_config.dart';
import 'package:doctor_flutter_web/logic/midlle_content/middle_state.dart';
import 'package:doctor_flutter_web/model/User.dart';
import 'package:doctor_flutter_web/presentation/widgets/display_all_users.dart';
import 'package:doctor_flutter_web/presentation/widgets/display_doctors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MiddleCubit extends Cubit<MiddleState> {
  MiddleCubit(super.initialState);
  late User user;

  changeWidget({Widget? widget}) {
    if (widget != null) {
      emit(state.copyWith(
        widget: widget,
      ));
    }else{
      emit(MiddleState());
    }
  }
  changeRightUser({required User user}) {

      emit(state.copyWith(
        rightUser: user,

      ));

  }
  getPendingUsers({required User user}) async {
    changeWidget();
    emit(state.copyWith(
        doctorStatus: DoctorStatus.loading,
        message: 'Loading...'
    ));
    var response = await http.get(Uri.parse(ApiConfig.getPending),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.token}',
    });
    Logger().f(response.body);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        doctorStatus: DoctorStatus.success,
        users: (jsonDecode(response.body)['users'] as List).map((e) => User.fromJson(e),).toList(),
        widget: DisplayDoctors(title:'Pending Users:',),
      ));
    } else {
      emit(state.copyWith(
        message: 'We Can not Can Reach To Pending Users!!!',
      ));
    }
  }
  _deleteUserByUserName(String userName){
    if(state.users != null){
      for(int i=0;i<state.users!.length;i++){
        if(state.users![i].username == userName){
          state.users!.removeAt(i);
          emit(state.copyWith(
            rightUser: User(),
          ));
          Logger().d(state.users);
          return;
        }
      }
    }else if(state.allUsers != null){
      state.allUsers!.forEach((key, value) {
        for(int i=0;i<value.length;i++){
          if(value[i].username == userName){
            state.allUsers![key]!.removeAt(i);
            emit(state.copyWith(
              rightUser: User(),
              allUsers: state.allUsers!,
            ));
            Logger().d(state.allUsers);
            return;
            // return value[i].username == userName;
          }
        }
      },);
    }
  }
  deleteUser({required User user,required String userName}) async {
    // emit(state.copyWith(
    //     doctorStatus: DoctorStatus.loading,
    //     message: 'Loading...'
    // ));
    var response = await http.delete(Uri.parse('${ApiConfig.deleteUser}$userName'),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.token}',
    });
    Logger().f(response.body);
    if (response.statusCode == 200) {
      _deleteUserByUserName(userName);

      // emit(state.copyWith(
      //   doctorStatus: DoctorStatus.success,
      //   users: (jsonDecode(response.body)['users'] as List).map((e) => User.fromJson(e),).toList(),
      //   widget: DisplayDoctors(title:'Pending Users:',),
      // ));
    } else {
      emit(state.copyWith(
        message: 'Hi',
      ));
    }
  }
  getDoctors({required User user}) async {
    changeWidget();
    emit(state.copyWith(
      doctorStatus: DoctorStatus.loading,
      message: 'Loading...'
    ));
    var response = await http.get(Uri.parse(ApiConfig.getDoctors),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.token}',
    });
    Logger().f(response.body);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        doctorStatus: DoctorStatus.success,
        users: (jsonDecode(response.body)['doctors'] as List).map((e) => User.fromJson(e),).toList(),
        widget: DisplayDoctors(),
      ));
    } else {
      emit(state.copyWith(
        message: 'We Can not Can Reach To Your Doctor!!!',
      ));
    }
  }
  getUsers({required User user}) async {
    changeWidget();
    emit(state.copyWith(
        doctorStatus: DoctorStatus.loading,
        message: 'Loading...'
    ));
    var response = await http.get(Uri.parse(ApiConfig.getUsers),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.token}',
    });
    Logger().f(response.body);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        doctorStatus: DoctorStatus.success,
        allUsers: (jsonDecode(response.body)['data'] as Map).map((key, value) {
          List<User> userList = (value as List).map((item) => User.fromJson(item)).toList();
          return MapEntry(key, userList);
        }),
        widget:DisplayAllUsers(user:user),
      ));
    } else {
      emit(state.copyWith(
        message: 'We Can not Can Reach To The Users!!!',
      ));
    }
  }
}
