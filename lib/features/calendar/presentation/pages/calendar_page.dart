import 'package:flutter/material.dart';
import '../../../../../../core/widgets/navigation/bottom_nav_bar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Календар')),
      body: const Center(child: Text('Calendar Page')),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
