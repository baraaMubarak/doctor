import 'package:doctor_flutter_web/logic/auth/auth_cubit.dart';
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(AuthState()),
      child: Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          children: [
            Menu(),
            // MediaQuery.of(context).size.width >= 980
            //     ? Menu()
            //     : SizedBox(), // Responsive
            Body()
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     _menuItem(title: 'Home'),
          //     _menuItem(title: 'About us'),
          //     _menuItem(title: 'Contact us'),
          //     _menuItem(title: 'Help'),
          //   ],
          // ),
          BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            if (state.authType == AuthType.login) {
              return Row(
                children: [
                  _menuItem(
                      title: 'Sign In',
                      authType: AuthType.login,
                      context: context),
                  SizedBox(
                    width: 5,
                  ),
                  _unselectedButton(
                      title: 'Register',
                      context: context,
                      authType: AuthType.register),
                ],
              );
            } else {
              return Row(
                children: [
                  _unselectedButton(
                      title: 'Sign In',
                      context: context,
                      authType: AuthType.login),
                  SizedBox(
                    width: 5,
                  ),
                  _menuItem(
                      title: 'Register',
                      authType: AuthType.register,
                      context: context),
                ],
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _menuItem(
      {String title = 'Title Menu',
      BuildContext? context,
      AuthType? authType}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        if (context != null) {
          context.read<AuthCubit>().changeAuthType(authType: authType!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.only(right: 75, left: 75, top: 3, bottom: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _unselectedButton(
      {required String title,
      required BuildContext context,
      required AuthType authType}) {
    return InkWell(
      onTap: () => context.read<AuthCubit>().changeAuthType(authType: authType),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 78, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 10,
              blurRadius: 12,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<AuthCubit,AuthState>(
          builder: (context, state) {
            bool isLoginPage = state.authType == AuthType.login;
            return Container(
              width: 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${isLoginPage?'Sign In':'Register'} to \nDoctor App',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "If you ${isLoginPage?"don't ":''}have an account",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "You can",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          if(isLoginPage) {
                            context.read<AuthCubit>().changeAuthType(authType: AuthType.register);
                          }else{
                            context.read<AuthCubit>().changeAuthType(authType: AuthType.login);
                          }
                        },
                        child: Text(
                          "${isLoginPage?'Register':'LogIn'} here!",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'images/illustration-2.png',
                    width: 300,
                  ),
                ],
              ),
            );
          },

        ),

        Image.asset(
          'images/illustration-1.png',
          width: 300,
        ),
        // MediaQuery.of(context).size.width >= 1300 //Responsive
        //     ? Image.asset(
        //         'images/illustration-1.png',
        //         width: 300,
        //       )
        //     : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.authType == AuthType.register) {
                return Container(
                  width: 320,
                  child: _formRegister(),
                );
              }else{
                return Container(
                  width: 320,
                  child: _formLogin(),
                );
              }
            },
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter email or Phone number',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            counterText: 'Forgot password?',
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade50,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"))),
            onPressed: () => print("it's pressed"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        // Row(children: [
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[300],
        //       height: 50,
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Text("Or continue with"),
        //   ),
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[400],
        //       height: 50,
        //     ),
        //   ),
        // ]),
        // SizedBox(height: 40),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     _loginWithButton(image: 'images/google.png'),
        //     _loginWithButton(image: 'images/github.png', isActive: true),
        //     _loginWithButton(image: 'images/facebook.png'),
        //   ],
        // ),
      ],
    );
  }

  Widget _formRegister() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter Your Name',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
            hintText: 'Enter Your Age',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter email or Phone number',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            counterText: 'Forgot password?',
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade50,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"))),
            onPressed: () => print("it's pressed"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        // Row(children: [
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[300],
        //       height: 50,
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Text("Or continue with"),
        //   ),
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[400],
        //       height: 50,
        //     ),
        //   ),
        // ]),
        // SizedBox(height: 40),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     _loginWithButton(image: 'images/google.png'),
        //     _loginWithButton(image: 'images/github.png', isActive: true),
        //     _loginWithButton(image: 'images/facebook.png'),
        //   ],
        // ),
      ],
    );
  }

// Widget _loginWithButton({required String image, bool isActive = false}) {
//   return Container(
//     width: 90,
//     height: 70,
//     decoration: isActive
//         ? BoxDecoration(
//       color: Colors.white,
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.shade300,
//           spreadRadius: 10,
//           blurRadius: 30,
//         )
//       ],
//       borderRadius: BorderRadius.circular(15),
//     )
//         : BoxDecoration(
//       borderRadius: BorderRadius.circular(15),
//       border: Border.all(color: Colors.grey.shade400),
//     ),
//     child: Center(
//         child: Container(
//           decoration: isActive
//               ? BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(35),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.shade400,
//                 spreadRadius: 2,
//                 blurRadius: 15,
//               )
//             ],
//           )
//               : BoxDecoration(),
//           child: Image.asset(
//             '$image',
//             width: 35,
//           ),
//         )),
//   );
// }
}
