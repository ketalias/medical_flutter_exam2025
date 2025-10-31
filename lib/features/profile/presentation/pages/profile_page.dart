import 'package:flutter/material.dart';
import '../../../../../../core/widgets/navigation/bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: const Center(child: Text('Profile Page')),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
