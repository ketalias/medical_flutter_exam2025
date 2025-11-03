import 'package:flutter/material.dart';
import 'route_names.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/messages/presentation/pages/messages_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/location/presentation/pages/location_page.dart';

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
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404: Сторінку не знайдено')),
          ),
        );
    }
  }
}
