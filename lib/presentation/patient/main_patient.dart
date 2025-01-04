import 'package:doctor_flutter_web/logic/auth/auth_cubit.dart';
import 'package:doctor_flutter_web/logic/auth/auth_state.dart';
import 'package:doctor_flutter_web/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MainPatient extends StatelessWidget {
  const MainPatient({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d(context.read<AuthCubit>().state.user );

    User user;

    return BlocBuilder<AuthCubit,AuthState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        if(state.user == null){
          context.read<AuthCubit>().getUser(context:context);
          return const Scaffold(
            body: Center(
              child: Text('Loading Your Data....',style: TextStyle(fontSize: 20),),
            ),
          );
        }else {
          user = state.user!;
          return Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(70),
                              ),
                            ),

                          ),

                        ],
                      ),

                      Positioned.fill(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const CircleAvatar(
                                  maxRadius: 70,
                                ),
                                Text(user.name??'Good Morning Admin', textAlign: TextAlign.center,),
                                const SizedBox(height: 30,),
                                const Text('info',
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                            
                                /// use \n
                            
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...[
                                      if (user.username != null) 'User Name: ${user.username}',
                                      // if (user.name != null) 'Name: ${user.name}',
                                      if (user.email != null) 'Email: ${user.email}',
                                      if (user.nationalId != null) 'National ID: ${user.nationalId}',
                                      if (user.healthInsuranceNumber != null)
                                        'Health Insurance Number: ${user.healthInsuranceNumber}',
                                      if (user.age != null) 'Age: ${user.age}',
                                      if (user.gender != null) 'Gender: ${user.gender}',
                                      if (user.phoneNumber != null) 'Phone Number: ${user.phoneNumber}',
                                      if (user.address != null) 'Address: ${user.address}',
                                      if (user.identityImage != null) 'Identity Image: ${user.identityImage}',
                                      // if (user.role != null) 'Role: ${user.role}',
                                      if (user.isVerified != null) 'Verified: ${user.isVerified}',
                                      if (user.specialty != null) 'Specialty: ${user.specialty}',
                                      // if (user.updatedAt != null)
                                      //   'Last Login: ${DateFormat.yMMMMd().add_jm().format(DateTime.parse(user.updatedAt!))}',
                                      if (user.createdAt != null)
                                        'First Login At: ${DateFormat.yMMMMd().add_jm().format(DateTime.parse(user.createdAt!))}',
                                    ].map(
                                          (text) => Text(
                                        text,
                                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                                SizedBox(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(30),
                                          onTap: () {

                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Colors.blueGrey.withOpacity(0.2)
                                            ),
                                            height: 50,
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text('Find Doctor'),
                                                Icon(Icons.send),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(30),
                                          onTap: () {

                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Colors.blueGrey.withOpacity(0.2)
                                            ),
                                            height: 50,
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text('Your Appointment'),
                                                Icon(Icons.send),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(30),
                                          onTap: () {
                                            context.read<AuthCubit>().logout(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Colors.blueGrey.withOpacity(0.2)
                                            ),
                                            height: 50,
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text('Log Out'),
                                                Icon(Icons.logout),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),),

                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(

                      decoration: BoxDecoration(



                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(child: Image.asset('images/background.png',fit: BoxFit.cover,opacity: const AlwaysStoppedAnimation(.2),)),
                          Center(child: Text('Are You Ok?',style: TextStyle(fontSize: 30),),),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                    )),
              ],
            ),
          );
        }
      },
    );
  }
}
