import 'package:doctor_flutter_web/logic/midlle_content/middle_cubit.dart';
import 'package:doctor_flutter_web/logic/midlle_content/middle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayDoctors extends StatelessWidget {
  const DisplayDoctors({super.key});

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
                  const Text('All Doctors:',style: TextStyle(fontSize: 30,color: Colors.deepPurple,),textAlign: TextAlign.start,),
                  for(int i=0;i<state.doctors!.length;i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(state.doctors![i].name!),
                      subtitle: Text('My Specialty: ${state.doctors![i].role!}, and My Phone: ${state.doctors![i].phoneNumber!}'),
                      focusColor: Colors.deepPurple.shade50,
                      trailing: Icon(Icons.send),
                      style: ListTileStyle.drawer,
                      tileColor: Colors.deepPurple.shade50,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      leading: Image.asset('images/doctor.png'),
                      onTap: () {
                        context.read<MiddleCubit>().changeRightUser(user: state.doctors![i]);
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
