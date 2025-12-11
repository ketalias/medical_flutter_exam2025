import 'package:flutter/material.dart';
import '../../../../core/utils/search_trie.dart';
import '../../../../models/search_models.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../doctors/presentation/pages/doctor_details_page.dart';
import '../../../doctors/presentation/pages/doctors_list_page.dart';

class ClinicSearchDelegate extends SearchDelegate {
  // Update: Accepts SearchTrie, not List<SearchableItem>
  final SearchTrie searchTrie;

  ClinicSearchDelegate(this.searchTrie);

  @override
  String get searchFieldLabel => 'Симптом (напр. біль), лікар...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  Widget _buildSearchResults(BuildContext context) {
    // FIX: Removed vector logic. Using Trie search.
    // tolerance: 1 allows for 1 typo (e.g. 'ьіль' -> 'біль')
    final results = searchTrie.search(query, tolerance: 1);

    if (results.isEmpty && query.isNotEmpty) {
      return Center(
        child: Text(
          'Нічого не знайдено для "$query"',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = results[index];
        
        IconData icon;
        Color color;
        
        switch (item.type) {
          case SearchItemType.doctor:
            icon = Icons.person;
            color = AppColors.primary;
            break;
          case SearchItemType.symptom:
            icon = Icons.healing;
            color = Colors.redAccent;
            break;
          case SearchItemType.service:
            icon = Icons.medical_services;
            color = Colors.orange;
            break;
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          title: RichText(
            text: TextSpan(
              text: item.title,
              style: const TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ),
          subtitle: Text(item.subtitle),
          onTap: () {
            if (item.type == SearchItemType.doctor) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DoctorDetailsPage(doctor: (item as SearchableDoctor).doctor),
                ),
              );
            } else if (item.type == SearchItemType.symptom) {
              final symptom = item as Symptom;
              // FIX: Using targetCategory instead of primaryCategory
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DoctorsListPage(initialFilter: symptom.targetCategory),
                ),
              );
            }
          },
        );
      },
    );
  }
}