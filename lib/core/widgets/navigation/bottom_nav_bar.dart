import 'package:flutter/material.dart';
import '../../../app/router/route_names.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Головна'),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Повідомлення',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Календар',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профіль'),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    final routes = [
      RouteNames.home,
      RouteNames.messages,
      RouteNames.calendar,
      RouteNames.profile,
    ];

    Navigator.pushReplacementNamed(context, routes[index]);
  }
}
