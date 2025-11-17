import 'package:flutter/material.dart';
import 'route_names.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/messages/presentation/pages/messages_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/location/presentation/pages/location_page.dart';
import '../../features/doctors/presentation/pages/doctors_list_page.dart';
import '../../features/auth/login/pages/login_page.dart';
import '../../features/auth/signup/pages/sign_up_page.dart';
import '../../features/auth/passreset/pages/forgot_password_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case RouteNames.messages:
        return MaterialPageRoute(
          builder: (_) => const MessagesPage(),
          settings: settings,
        );
      case RouteNames.calendar:
        return MaterialPageRoute(
          builder: (_) => const CalendarPage(),
          settings: settings,
        );
      case RouteNames.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
          settings: settings,
        );
      case RouteNames.location:
        return MaterialPageRoute(
          builder: (_) => const LocationPage(),
          settings: settings,
        );
      case RouteNames.doctorsList:
        return MaterialPageRoute(
          builder: (_) => const DoctorsListPage(),
          settings: settings,
        );
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case RouteNames.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
          settings: settings,
        );
      case RouteNames.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404: Сторінку не знайдено')),
          ),
        );
    }
  }
}