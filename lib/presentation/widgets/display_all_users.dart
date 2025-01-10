import 'package:doctor_flutter_web/logic/midlle_content/middle_cubit.dart';
import 'package:doctor_flutter_web/logic/midlle_content/middle_state.dart';
import 'package:doctor_flutter_web/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class DisplayAllUsers extends StatelessWidget {
  const DisplayAllUsers({super.key,required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiddleCubit, MiddleState>(
      builder: (context, state) {
        Logger().d(state.allUsers);
        if(state.doctorStatus == DoctorStatus.success){
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('All Admins:',style: TextStyle(fontSize: 30,color: Colors.deepPurple,),textAlign: TextAlign.start,),
                    if(state.allUsers!['admins']!.length == 1)
                      const Text('         No Admins To Show',style: TextStyle(fontSize: 15,color: Colors.grey,),textAlign: TextAlign.start,),
                    for(int i=0;i<state.allUsers!['admins']!.length;i++)
                      Visibility(
                        visible: state.allUsers!['admins']![i].username != user.username,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(state.allUsers!['admins']![i].name!),
                            subtitle: Text('My Email: ${state.allUsers!['admins']![i].role!}, and My Phone: ${state.allUsers!['admins']![i].phoneNumber!}'),
                            focusColor: Colors.deepPurple.shade50,
                            trailing: Icon(Icons.send),
                            style: ListTileStyle.drawer,
                            tileColor: Colors.deepPurple.shade50,
                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            leading: Image.asset('assets/images/doctor.png'),
                            onTap: () {
                              context.read<MiddleCubit>().changeRightUser(user: state.allUsers!['admins']![i]);
                            },
                          ),
                        ),
                      ),
                    const Text('All Doctors:',style: TextStyle(fontSize: 30,color: Colors.deepPurple,),textAlign: TextAlign.start,),
                    if(state.allUsers!['doctors']!.isEmpty)
                    const Text('         No Doctors To Show',style: TextStyle(fontSize: 15,color: Colors.grey,),textAlign: TextAlign.start,),
                    for(int i=0;i<state.allUsers!['doctors']!.length;i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(state.allUsers!['doctors']![i].name!),
                          subtitle: Text('My Email: ${state.allUsers!['doctors']![i].role!}, and My Phone: ${state.allUsers!['doctors']![i].phoneNumber!}'),
                          focusColor: Colors.deepPurple.shade50,
                          trailing: Icon(Icons.send),
                          style: ListTileStyle.drawer,
                          tileColor: Colors.deepPurple.shade50,
                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          leading: Image.asset('assets/images/doctor.png'),
                          onTap: () {
                            try {
                              Logger().f(state.allUsers);
                              Logger().f(state.allUsers!['doctors']);
                              Logger().f(state.allUsers!['doctors']![i]);
                              context.read<MiddleCubit>().changeRightUser(
                                  user: state.allUsers!['doctors']![i]);
                            } on Exception catch (_, e){
                              Logger().e(e);
                            }
                          },
                        ),
                      ),
                    const Text('All Patients:',style: TextStyle(fontSize: 30,color: Colors.deepPurple,),textAlign: TextAlign.start,),
                    if(state.allUsers!['patients']!.isEmpty)
                      const Text('         No Patients To Show',style: TextStyle(fontSize: 15,color: Colors.grey,),textAlign: TextAlign.start,),
                    for(int i=0;i<state.allUsers!['patients']!.length;i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(state.allUsers!['patients']![i].name!),
                          subtitle: Text('My Email: ${state.allUsers!['patients']![i].role!}, and My Phone: ${state.allUsers!['patients']![i].phoneNumber!}'),
                          focusColor: Colors.deepPurple.shade50,
                          trailing: Icon(Icons.send),
                          style: ListTileStyle.drawer,
                          tileColor: Colors.deepPurple.shade50,
                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          leading: Image.asset('assets/images/doctor.png'),
                          onTap: () {
                            context.read<MiddleCubit>().changeRightUser(user: state.allUsers!['patients']![i]);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: Text('Un Expected Error'),);
      },
    );
  }
}
