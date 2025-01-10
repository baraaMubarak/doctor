import 'package:doctor_flutter_web/logic/midlle_content/middle_cubit.dart';
import 'package:doctor_flutter_web/logic/midlle_content/middle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayDoctors extends StatelessWidget {
  DisplayDoctors({super.key,this.title});
  String? title;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiddleCubit, MiddleState>(
      builder: (context, state) {
        if(state.doctorStatus == DoctorStatus.success){
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title??'All Doctors:',style: const TextStyle(fontSize: 30,color: Colors.deepPurple,),textAlign: TextAlign.start,),
                  for(int i=0;i<state.users!.length;i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(state.users![i].name!),
                      subtitle: Text('My Specialty: ${state.users![i].role!}, and My Phone: ${state.users![i].phoneNumber!}'),
                      focusColor: Colors.deepPurple.shade50,
                      trailing: const Icon(Icons.send),
                      style: ListTileStyle.drawer,
                      tileColor: Colors.deepPurple.shade50,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      leading: Image.asset('assets/images/doctor.png'),
                      onTap: () {
                        context.read<MiddleCubit>().changeRightUser(user: state.users![i]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('Un Expected Error'),);
      },
    );
  }
}
