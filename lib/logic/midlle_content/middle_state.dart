import 'package:doctor_flutter_web/model/User.dart';
import 'package:flutter/material.dart';

enum DoctorStatus { loading, init, failure, success }

class MiddleState {
  late Widget widget;
  // late Widget rightWidget;
  late User? rightUser;
  List<User>? doctors;
  Map<String,List<User>>? allUsers;
  String? message;
  DoctorStatus doctorStatus;

  MiddleState({
    Widget? widget,
    this.rightUser,
    this.allUsers,
    // Widget? rightWidget,
    String? message,
    this.doctors,
    this.doctorStatus = DoctorStatus.init,
  }) {
    if (widget == null) {
      this.widget = _init(message: message);
    } else {
      this.widget = widget;
    }
  }

  MiddleState copyWith({
    Widget? widget,
    User? rightUser,
    Widget? rightWidget,
    String? message,
    List<User>? doctors,
    Map<String,List<User>>? allUsers,
    DoctorStatus? doctorStatus,
  }) {
    return MiddleState(
      widget: widget ?? this.widget,
      message: message ?? this.message,
      doctors: doctors ?? this.doctors,
      doctorStatus: doctorStatus ?? this.doctorStatus,
      // rightWidget: rightWidget ?? this.rightWidget,
      rightUser: rightUser ?? this.rightUser,
      allUsers: allUsers ?? this.allUsers,
    );
  }

  Widget _init({String? message}) {
    return Container(
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'images/background.png',
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(.2),
          )),
          Center(
            child: Text(
              message ?? 'Are You Ok?',
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
