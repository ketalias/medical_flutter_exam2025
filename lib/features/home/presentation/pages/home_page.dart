import 'package:flutter/material.dart';
import 'package:medical_flutter_exam2025/app/router/route_names.dart';
import 'package:medical_flutter_exam2025/core/widgets/navigation/bottom_nav_bar.dart';
import 'package:medical_flutter_exam2025/core/theme/app_colors.dart';
import 'package:medical_flutter_exam2025/core/theme/app_text_styles.dart';
import 'package:medical_flutter_exam2025/core/widgets/categories/category_card.dart';
import 'package:medical_flutter_exam2025/features/doctors/domain/doctor_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openClinicOnMap(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.location);
  }

  void _openLogin(BuildContext context) {
    Navigator.pushNamed(context, RouteNames.login);
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
              const SizedBox(height: 12),
              _buildCategoriesRow(),
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
      'Твоє здоров`я — \nнаш пріоритет',
      style: AppTextStyles.h2.copyWith(
      color: AppColors.textPrimary,
        height: 1.3,
      ),
    ),
    ),
    Row(
    children: [
    IconButton(
    onPressed: () => _openLogin(context),
    icon: const Icon(
    Icons.login,
    color: AppColors.primary,
    size: 32,
    ),
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    ),
    const SizedBox(width: 16),
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
    ],
    ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Пошук категорії лікаря...',
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

  Widget _buildCategoriesRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20)),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: doctorCategories.length,
            itemBuilder: (context, index) {
              final cat = doctorCategories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 90,
                  child: CategoryItem(
                    category: cat,
                    onTap: () {
                      print('Натиснуто на: ${cat.name}');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}