import 'package:flutter/material.dart';
import 'package:medical_flutter_exam2025/app/router/route_names.dart';
import 'package:medical_flutter_exam2025/core/widgets/navigation/bottom_nav_bar.dart';
import 'package:medical_flutter_exam2025/core/theme/app_colors.dart';
import 'package:medical_flutter_exam2025/core/theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openClinicOnMap(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Find your desire\nhealth solution',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _openClinicOnMap(context),
            icon: const Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
              size: 32,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search doctor...',
          hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColors.textLight),
          filled: true,
          fillColor: AppColors.background,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
