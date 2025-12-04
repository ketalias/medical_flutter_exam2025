import 'doctor_model.dart';

class AppointmentModel {
  final String id;
  final DoctorModel doctor;
  final DateTime appointmentTime;
  final String notes;
  final String status; // 'scheduled', 'completed', 'cancelled'

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.appointmentTime,
    required this.notes,
    this.status = 'scheduled',
  });
}
