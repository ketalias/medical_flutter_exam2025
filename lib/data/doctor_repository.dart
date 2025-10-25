import '../models/doctor_model.dart';

class DoctorRepository {
  
  // Це наші "фейкові" дані, ніби вони прийшли з сервера
  final List<DoctorModel> _mockDoctors = [
    DoctorModel(
      id: '1',
      fullName: 'Олена Петренко',
      specialty: 'Кардіолог',
      imageUrl: 'https://example.com/images/doctor1.png',
    ),
    DoctorModel(
      id: '2',
      fullName: 'Максим Залізняк',
      specialty: 'Терапевт',
      imageUrl: 'https://example.com/images/doctor2.png',
    ),
    DoctorModel(
      id: '3',
      fullName: 'Ірина Ковальчук',
      specialty: 'Педіатр',
      imageUrl: 'https://example.com/images/doctor3.png',
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