import '../../models/user_model.dart';

class UserRepository {
  // Mock user data
  final UserModel _mockUser = UserModel(
    id: '1',
    fullName: 'Роман Петренко',
    email: 'roman.petrenko@example.com',
    phone: '+380 (98) 765-43-21',
    photoUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1iWM7UCc6j1DMSd9ATpxfkUZB2SeC44Kmw&s',
    dateOfBirth: '15.08.1990',
    address: 'Київ, вулиця Шевченка, 123',
  );

  Future<UserModel> getUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockUser;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Implement actual logout logic here
  }

  Future<void> updateUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Implement actual update logic here
  }
}
