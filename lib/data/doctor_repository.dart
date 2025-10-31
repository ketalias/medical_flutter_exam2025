import '../models/doctor_model.dart';

class DoctorRepository {
  
  // Це наші "фейкові" дані, ніби вони прийшли з сервера
  final List<DoctorModel> _mockDoctors = [
    DoctorModel(
      id: '1',
      fullName: 'Олена Петренко',
      specialty: 'Кардіолог',
      imageUrl: 'https://www.future-doctor.de/wp-content/uploads/2024/08/shutterstock_2480850611.jpg',
    ),
    DoctorModel(
      id: '2',
      fullName: 'Максим Залізняк',
      specialty: 'Терапевт',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1iWM7UCc6j1DMSd9ATpxfkUZB2SeC44Kmw&s',
    ),
    DoctorModel(
      id: '3',
      fullName: 'Ірина Ковальчук',
      specialty: 'Педіатр',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS5Ub-r2wrDnint_u-2HMQ9wQeLVPKoy9glg&s',
    ),
  ];

  // Функція, яка вдає, що завантажує дані
  // Ми використовуємо Future, щоб імітувати реальний запит до API
  Future<List<DoctorModel>> getDoctors() async {
    // Імітуємо затримку мережі (1 секунда)
    await Future.delayed(const Duration(seconds: 1));
    
    // Повертаємо наш готовий список
    return _mockDoctors;
  }

  // Функція для отримання одного лікаря (поки не використовуємо, але для прикладу)
  Future<DoctorModel> getDoctorById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDoctors.firstWhere((doc) => doc.id == id);
  }
}