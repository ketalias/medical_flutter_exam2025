import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../widgets/doctor_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<DoctorModel> doctors = [
    DoctorModel(
      id: '1',
      fullName: 'Dr. Emily Carter',
      specialty: 'Cardiologist',
      imageUrl: '',
      location: 'New York, USA',
    ),
    DoctorModel(
      id: '2',
      fullName: 'Dr. James Wilson',
      specialty: 'Neurologist',
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg?crop=0.66698xw:1xh;center,top&resize=640:*',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: DoctorCard(doctor: doctor),
          );
        },
      ),
    );
  }
}
