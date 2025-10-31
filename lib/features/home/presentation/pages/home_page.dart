import 'package:flutter/material.dart';
import '../../../../../../core/widgets/navigation/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Головна')),
      body: const Center(child: Text('Home Page')),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
