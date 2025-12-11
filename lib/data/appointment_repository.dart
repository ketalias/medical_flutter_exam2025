import '../../models/appointment_model.dart';
import '../../models/doctor_model.dart';

class AppointmentRepository {
  // Shared mock data for appointments
  static final List<AppointmentModel> _mockAppointments = [
    AppointmentModel(
      id: '1',
      doctor: DoctorModel(
        id: '1',
        fullName: 'Олена Петренко',
        specialty: 'Кардіолог',
        imageUrl:
            'https://www.future-doctor.de/wp-content/uploads/2024/08/shutterstock_2480850611.jpg',
        likes: 120,
        location: 'Київ, Україна',
      ),
      appointmentTime: DateTime.now().add(const Duration(days: 2)),
      notes: 'Регулярний огляд серця',
      status: 'scheduled',
    ),
    AppointmentModel(
      id: '2',
      doctor: DoctorModel(
        id: '3',
        fullName: 'Ірина Ковальчук',
        specialty: 'Педіатр',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS5Ub-r2wrDnint_u-2HMQ9wQeLVPKoy9glg&s',
        likes: 102,
        location: 'Одеса, Україна',
      ),
      appointmentTime: DateTime.now().add(const Duration(days: 5)),
      notes: 'Щеплення',
      status: 'scheduled',
    ),
    AppointmentModel(
      id: '3',
      doctor: DoctorModel(
        id: '5',
        fullName: 'Марія Левченко',
        specialty: 'Стоматолог',
        imageUrl:
            'https://www.healthgrades.com/media-library/young-female-dentist-in-office.jpg?id=31910747&width=800&quality=85',
        likes: 77,
        location: 'Дніпро, Україна',
      ),
      appointmentTime: DateTime.now().subtract(const Duration(days: 1)),
      notes: 'Чищення зубів',
      status: 'completed',
    ),
    AppointmentModel(
      id: '4',
      doctor: DoctorModel(
        id: '8',
        fullName: 'Віталій Мельник',
        specialty: 'Хірург',
        imageUrl:
            'https://images.unsplash.com/photo-1606813902932-5d07a2f07f2c',
        likes: 150,
        location: 'Тернопіль, Україна',
      ),
      appointmentTime: DateTime.now().add(const Duration(days: 10)),
      notes: 'Консультація',
      status: 'scheduled',
    ),
    AppointmentModel(
      id: '5',
      doctor: DoctorModel(
        id: '2',
        fullName: 'Максим Залізняк',
        specialty: 'Терапевт',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1iWM7UCc6j1DMSd9ATpxfkUZB2SeC44Kmw&s',
        likes: 85,
        location: 'Львів, Україна',
      ),
      appointmentTime: DateTime.now().add(const Duration(days: 7)),
      notes: 'Загальний огляд',
      status: 'scheduled',
    ),
  ];

  Future<List<AppointmentModel>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List<AppointmentModel>.unmodifiable(_mockAppointments);
  }

  Future<List<AppointmentModel>> getAppointmentsByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final dateOnly = DateTime(date.year, date.month, date.day);
    return _mockAppointments.where((appointment) {
      final appointmentDate = DateTime(
        appointment.appointmentTime.year,
        appointment.appointmentTime.month,
        appointment.appointmentTime.day,
      );
      return appointmentDate == dateOnly;
    }).toList();
  }

  Future<List<AppointmentModel>> getUpcomingAppointments() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    return _mockAppointments
        .where((appointment) => appointment.appointmentTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.appointmentTime.compareTo(b.appointmentTime));
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockAppointments.add(appointment);
  }
}
