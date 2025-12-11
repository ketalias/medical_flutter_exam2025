import 'package:medical_flutter_exam2025/app/config/app_constants.dart';

class AuthService {
  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (email == AppConstants.testUsername &&
        password == AppConstants.testPassword) {
      return true;
    } else {
      return false;
    }
  }
}
