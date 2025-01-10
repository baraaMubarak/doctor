import 'package:doctor_flutter_web/logic/auth/auth_cubit.dart';
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:doctor_flutter_web/model/User.dart';
import 'package:doctor_flutter_web/presentation/core/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthCubit,AuthState>(
      builder: (context, state) {
        if(state.user != null){
          Future.delayed(Duration.zero,() => Navigator.pushReplacementNamed(context, '/patient'),);
        }
        return Scaffold(
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
        );
      },

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
          const Spacer(),
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
                  const SizedBox(
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
                  const SizedBox(
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
        context.read<AuthCubit>().changeAuthType(authType: authType!);

            },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: EdgeInsets.only(
              right: Responsive.isMobile(context!) ? 20 : 75,
              left: Responsive.isMobile(context) ? 20 : 75,
              top: 3,
              bottom: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
            horizontal: Responsive.isMobile(context) ? 20 : 78, vertical: 8),
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
          style: const TextStyle(
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${isLoginPage ? 'Sign In' : 'Register'} to \nDoctor App',
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "If you ${isLoginPage ? "don't " : ''}have an account",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "You can",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 15),
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
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/illustration-2.png',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        if (Responsive.isDesktop(context))
          Expanded(
            child: Image.asset(
              'assets/images/illustration-1.png',
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
                    child: _formLogin(context),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _formLogin(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController userNameCont = TextEditingController();
    TextEditingController passCont = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 130,),
          TextFormField(
            // key: _formKey,
            controller: userNameCont,
            decoration: InputDecoration(
              hintText: 'User name',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
                return 'اسم المستخدم مطلوب';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            // key: _formKey,
            controller: passCont,
            decoration: InputDecoration(
              hintText: 'Password',
              counterText: 'Forgot password?',
              suffixIcon: const Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
                return 'كبمة المرور مطلوبة';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
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
            child: BlocBuilder<AuthCubit,AuthState>(
              builder: (context, state) {
                bool isLoading = state.getUserState == GetUserState.loading;
                if(state.getUserState == GetUserState.success){
                  Future.delayed(Duration.zero,() => Navigator.pushReplacementNamed(context, '/patient'),);
                }
                return Column(
                  children: [
                    if(state.getUserState == GetUserState.failure)
                    Text(state.error!,style: const TextStyle(color: Colors.red),),
                    ElevatedButton(
                      onPressed: !isLoading?() {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(userName: userNameCont.text, password: passCont.text);
                        } else {
                          print("Validation Failed");
                        }

                      }:null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          child:  Center(child: isLoading?Text("جار تسجيل الدخول"):Text("Sign In"))),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 40),

        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _formPatientRegister(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nationalIdController = TextEditingController();
    TextEditingController healthInsuranceNumberController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController gender = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          // Email
          TextFormField(
            controller:emailController,
            decoration: InputDecoration(

              hintText: 'البريد الإلكتروني',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // National ID
          TextFormField(
            controller: nationalIdController,
            decoration: InputDecoration(
              hintText: 'رقم الهوية الوطنية',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Health Insurance Number (Optional)
          TextFormField(
            controller: healthInsuranceNumberController,
            decoration: InputDecoration(
              hintText: 'رقم التأمين الصحي',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Age
          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'العمر',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Gender
          DropdownButtonFormField<String>(
            items: const [
              DropdownMenuItem(value: "male", child: Text("Male")),
              DropdownMenuItem(
                  value: "female",
                  child: Text("Female")),
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
          const SizedBox(height: 30),

          // Phone Number
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'رقم الهاتف',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Address
          TextFormField(
            decoration: InputDecoration(
              hintText: 'العنوان',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Identity Image
          TextButton.icon(
            onPressed: () {}, // Add functionality here
            icon: const Icon(Icons.upload_file, color: Colors.deepPurple),
            label: const Text("Upload Identity Image"),
          ),
          const SizedBox(height: 40),

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
                  child: const Center(child: Text("Submit"))),
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
          const SizedBox(height: 5),
          TextButton(onPressed: () {
            context.read<AuthCubit>().changeRegisterType(registerType: RegisterType.doctor);
          }, child: const Text('Register As A Doctor')),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _formDoctorRegister(BuildContext context) {
// Controllers
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _specialtyController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _userNameController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 50),
          // Doctor Name
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'اسم الدكتور',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(
              hintText: 'اسم المستخدم',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
                return 'اسم المستخدم مطلوب';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          // Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'البريد الإلكتروني',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Specialty
          TextFormField(
            controller: _specialtyController,
            decoration: InputDecoration(
              hintText: 'التخصص',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
          const SizedBox(height: 30),

          // Phone Number (Required)
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'رقم الهاتف',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
                return 'رقم الهاتف مطلوب';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          // Address (Required)
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              hintText: 'العنوان',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
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
                return 'العنوان مطلوب';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

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
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state.getUserState == GetUserState.success) {
                  Future.delayed(Duration.zero,() => Navigator.pushNamed(context, '/doctor'),);
                }
                return Column(
                  children: [
                    if (state.getUserState == GetUserState.failure)
                      Text(
                        state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ElevatedButton(
                      onPressed: state.getUserState != GetUserState.loading
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                User user = User(
                                  name: _nameController.text,
                                  username: _userNameController.text,
                                  email: _emailController.text,
                                  specialty: _specialtyController.text,
                                  phoneNumber: _phoneController.text,
                                  address: _addressController.text,
                                );

                                context.read<AuthCubit>().register(user);
                              } else {
                                print("Validation Failed");
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          child: state.getUserState == GetUserState.loading
                              ? SizedBox(
                                  width: 50,
                                  child: CircularProgressIndicator())
                              : const Center(child: Text("تسجيل"))),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              context
                  .read<AuthCubit>()
                  .changeRegisterType(registerType: RegisterType.patient);
            },
            child: const Text('Register As A Patient'),
          ),
          const SizedBox(height: 40),
        ],
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
            child: const Text("Register As a Doctor"),
          ),
        ),
        const SizedBox(height: 20),
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
            child: const Text("Register As a Patient"),
          ),
        ),
      ],
    );
  }


}
