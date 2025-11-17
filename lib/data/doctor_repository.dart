import '../models/doctor_model.dart';

class DoctorRepository {
  // Це наші "фейкові" дані, ніби вони прийшли з сервера
  final List<DoctorModel> _mockDoctors = [
    DoctorModel(
      id: '1',
      fullName: 'Олена Петренко',
      specialty: 'Кардіолог',
      imageUrl:
          'https://www.future-doctor.de/wp-content/uploads/2024/08/shutterstock_2480850611.jpg',
      likes: 120,
      location: 'Київ, Україна',
    ),
    DoctorModel(
      id: '2',
      fullName: 'Максим Залізняк',
      specialty: 'Терапевт',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1iWM7UCc6j1DMSd9ATpxfkUZB2SeC44Kmw&s',
      likes: 85,
      location: 'Львів, Україна',
    ),
    DoctorModel(
      id: '3',
      fullName: 'Ірина Ковальчук',
      specialty: 'Педіатр',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS5Ub-r2wrDnint_u-2HMQ9wQeLVPKoy9glg&s',
      likes: 102,
      location: 'Одеса, Україна',
    ),
    DoctorModel(
      id: '4',
      fullName: 'Андрій Сидоренко',
      specialty: 'Терапевт',
      imageUrl: 'https://www.sutterhealth.org/images/doctor-male-2x.jpg',
      likes: 95,
      location: 'Харків, Україна',
    ),
    DoctorModel(
      id: '5',
      fullName: 'Марія Левченко',
      specialty: 'Стоматолог',
      imageUrl:
          'https://www.healthgrades.com/media-library/young-female-dentist-in-office.jpg?id=31910747&width=800&quality=85',
      likes: 77,
      location: 'Дніпро, Україна',
    ),
    DoctorModel(
      id: '6',
      fullName: 'Олег Кравець',
      specialty: 'Стоматолог',
      imageUrl:
          'https://www.verywellhealth.com/thmb/6j7VYEq2-mhViOwxM-LpU9dDgYo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/orthopedic-surgeon-56a488b43df78cf7728491db.jpg',
      likes: 64,
      location: 'Полтава, Україна',
    ),
    DoctorModel(
      id: '7',
      fullName: 'Світлана Гончаренко',
      specialty: 'Стоматолог',
      imageUrl:
          'https://www.ucsfhealth.org/-/media/project/ucsf/ucsf-health/body/doctor/doctor-female-3x2.jpg',
      likes: 112,
      location: 'Черкаси, Україна',
    ),
    DoctorModel(
      id: '8',
      fullName: 'Віталій Мельник',
      specialty: 'Хірург',
      imageUrl: 'https://images.unsplash.com/photo-1606813902932-5d07a2f07f2c',
      likes: 150,
      location: 'Тернопіль, Україна',
    ),
    DoctorModel(
      id: '9',
      fullName: 'Наталія Романюк',
      specialty: 'Офтальмолог',
      imageUrl:
          'https://cdn.create.vista.com/api/media/small/383566384/stock-photo-female-ophthalmologist-posing-office',
      likes: 98,
      location: 'Івано-Франківськ, Україна',
    ),
    DoctorModel(
      id: '10',
      fullName: 'Юрій Поліщук',
      specialty: 'Хірург',
      imageUrl:
          'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2020/04/27/17/18/male-doctor-16-9.jpg',
      likes: 73,
      location: 'Житомир, Україна',
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
