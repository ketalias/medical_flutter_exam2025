import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/navigation/bottom_nav_bar.dart';
import '../../../../core/widgets/categories/category_card.dart';
import '../../../../features/doctors/domain/doctor_category.dart';
import '../../../../features/doctors/widgets/doctors_favorite.dart';
import '../../../../app/router/route_names.dart';
import '../../../../features/doctors/presentation/pages/doctors_list_page.dart';
// SEARCH IMPORTS
import '../../../../core/utils/search_trie.dart';
import '../../../../models/search_models.dart';
import '../../../../data/doctor_repository.dart';
import '../widgets/clinic_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SearchTrie _searchTrie = SearchTrie();
  final DoctorRepository _doctorRepository = DoctorRepository();

  @override
  void initState() {
    super.initState();
    _loadSearchData();
  }

  Future<void> _loadSearchData() async {
    // 1. Load Real Doctors into Search
    final doctors = await _doctorRepository.getDoctors();
    for (var doc in doctors) {
      _searchTrie.insert(SearchableDoctor(doc));
    }

    // 2. Load Symptom Mappings (The "Knowledge Base")
    // Note: The 'targetCategory' MUST match the strings in doctor_category.dart
    final symptoms = [
      Symptom(id: 's1', name: 'Біль у вусі', targetCategory: 'ЛОР'),
      Symptom(id: 's2', name: 'Закладеність носа', targetCategory: 'ЛОР'),
      Symptom(id: 's3', name: 'Аритмія', targetCategory: 'Кардіолог'),
      Symptom(id: 's4', name: 'Біль у серці', targetCategory: 'Кардіолог'),
      Symptom(id: 's5', name: 'Висип на шкірі', targetCategory: 'Дерматолог'),
      Symptom(id: 's6', name: 'Головний біль', targetCategory: 'Невролог'),
      Symptom(id: 's7', name: 'Кашель', targetCategory: 'Терапевт'),
      Symptom(id: 's8', name: 'Температура', targetCategory: 'Терапевт'),
      Symptom(id: 's9', name: 'Погіршення зору', targetCategory: 'Офтальмолог'),
    ];

    for (var s in symptoms) {
      _searchTrie.insert(s);
    }
  }

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
              _buildSearchBar(context),
              const SizedBox(height: 12),
              _buildCategoriesRow(),
              const SizedBox(height: 24),
              _buildBanner(),
              const SizedBox(height: 24),
              const DoctorsFavorite(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          showSearch(
            context: context,
            delegate: ClinicSearchDelegate(_searchTrie),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary, width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.textLight),
              const SizedBox(width: 12),
              Text(
                'Пошук симптому або лікаря...',
                style: TextStyle(color: AppColors.textLight, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Keep _buildHeader, _buildCategoriesRow, and _buildBanner exactly as they were in your full_code.txt) ...
  // Copy them here from your original file.

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

  Widget _buildCategoriesRow() {
    // ... (Use your existing code)
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DoctorsListPage(initialFilter: cat.name),
                        ),
                      );
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

  // Use your existing _buildBanner code here...
  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Image.asset(
              'assets/banners/home_page_banner.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 160,
            ),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.45), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Запишись на прийом',
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      print('Натиснуто "Записатися"');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Записатися',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
