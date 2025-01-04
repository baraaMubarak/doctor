import 'package:doctor_flutter_web/logic/auth/auth_cubit.dart';
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:doctor_flutter_web/presentation/auth/login.dart';
import 'package:doctor_flutter_web/presentation/patient/main_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider<AuthCubit>(
      create: (BuildContext context) =>
          AuthCubit(AuthState(authType: AuthType.login))..getUser(context: context),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Doctor',
        initialRoute: '/login',
        routes: {
            '/login': (context) => LoginPage(),
          '/patient': (context) => const MainPatient(),
          '/doctor': (context) => const MainPatient(),
        },
        theme: ThemeData(
          fontFamily: 'El_Messiri',

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
