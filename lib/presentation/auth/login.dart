import 'package:doctor_flutter_web/logic/auth/auth_cubit.dart';
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:doctor_flutter_web/presentation/core/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) =>
          AuthCubit(AuthState(authType: AuthType.login)),
      child: Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          child: Column(
            children: [
              Menu(),
              // MediaQuery.of(context).size.width >= 980
              //     ? Menu()
              //     : SizedBox(), // Responsive
              Expanded(child: Body())
            ],
          ),
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
          margin: EdgeInsets.only(
              right: Responsive.isMobile(context!) ? 20 : 75,
              left: Responsive.isMobile(context!) ? 20 : 75,
              top: 3,
              bottom: 3),
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
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context!) ? 20 : 78, vertical: 8),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if()

        Visibility(
          visible:
              Responsive.isTablet(context) || Responsive.isDesktop(context),
          child: Expanded(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                bool isLoginPage = state.authType == AuthType.login;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${isLoginPage ? 'Sign In' : 'Register'} to \nDoctor App',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "If you ${isLoginPage ? "don't " : ''}have an account",
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
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              if (isLoginPage) {
                                context.read<AuthCubit>().changeAuthType(
                                    authType: AuthType.register);
                              } else {
                                context
                                    .read<AuthCubit>()
                                    .changeAuthType(authType: AuthType.login);
                              }
                            },
                            child: Text(
                              "${isLoginPage ? 'Register' : 'LogIn'} here!",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'images/illustration-2.png',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        if (Responsive.isDesktop(context))
          Expanded(
            child: Image.asset(
              'images/illustration-1.png',
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state.authType == AuthType.register) {
                  if(state.registerType == RegisterType.patient) {
                    return Container(
                      child: _formPatientRegister(context),
                    );
                  }else if(state.registerType == RegisterType.doctor) {
                    return Container(
                      child: _formDoctorRegister(context),
                    );
                  }
                  return Container(
                    child: _selectDoctorOrPatient(context),
                  );
                } else {
                  return Container(
                    child: _formLogin(),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 130,),
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

  final _formKey = GlobalKey<FormState>();

  Widget _formPatientRegister(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50,),
              // Email
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'البريد الإلكتروني',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'البريد الإلكتروني مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // National ID
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'رقم الهوية الوطنية',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'رقم الهوية الوطنية مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Health Insurance Number (Optional)
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'رقم التأمين الصحي',
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

              // Age
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'العمر',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'العمر مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Gender
              DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(child: Text("Male"), value: "male"),
                  DropdownMenuItem(child: Text("Female"), value: "female"),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'الجنس',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade50),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الجنس مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Phone Number
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
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

              // Address
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'العنوان',
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

              // Identity Image
              TextButton.icon(
                onPressed: () {}, // Add functionality here
                icon: const Icon(Icons.upload_file, color: Colors.deepPurple),
                label: const Text("Upload Identity Image"),
              ),
              SizedBox(height: 40),

              // Submit Button
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
                      child: Center(child: Text("Submit"))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Form Submitted");
                    } else {
                      print("Validation Failed");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextButton(onPressed: () {
                context.read<AuthCubit>().changeRegisterType(registerType: RegisterType.doctor);
              }, child: const Text('Register As A Doctor')),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formDoctorRegister(BuildContext context) {

    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50,),
              // Doctor Name
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'اسم الدكتور',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'اسم الدكتور مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Email
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'البريد الإلكتروني',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'البريد الإلكتروني مطلوب';
                  }
                  // Add logic to check if email is already taken
                  return null;
                },
              ),
              SizedBox(height: 30),




              // Specialty
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'التخصص',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'التخصص مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Phone Number (Optional)
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
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

              // Address (Optional)
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'العنوان',
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

              // Submit Button
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
                      child: Center(child: Text("Submit"))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Form Submitted");
                    } else {
                      print("Validation Failed");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextButton(onPressed: () {
                context.read<AuthCubit>().changeRegisterType(registerType: RegisterType.patient);
              }, child: const Text('Register As A Patient')),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  Widget _selectDoctorOrPatient(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 4,),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().changeRegisterType(registerType: RegisterType.doctor);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: Text("Register As a Doctor"),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().changeRegisterType(registerType: RegisterType.patient);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              Colors.grey[300],
              foregroundColor: Colors.black,
            ),
            child: Text("Register As a Patient"),
          ),
        ),
      ],
    );
  }


}
