import 'package:flutter/material.dart';
import '../../../../../../core/widgets/navigation/bottom_nav_bar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Повідомлення')),
      body: const Center(child: Text('Messages Page')),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
