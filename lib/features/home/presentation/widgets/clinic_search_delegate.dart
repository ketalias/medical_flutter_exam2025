import 'package:flutter/material.dart';
import '../../../../core/utils/search_trie.dart';
import '../../../../models/search_models.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../doctors/presentation/pages/doctor_details_page.dart';
import '../../../doctors/presentation/pages/doctors_list_page.dart';

class ClinicSearchDelegate extends SearchDelegate {
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
    final results = searchTrie.search(query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];

        // Define Icon and Color based on type
        IconData icon;
        Color color;
        
        switch (item.type) {
          case SearchItemType.doctor:
            icon = Icons.person;
            color = AppColors.primary;
            break;
          case SearchItemType.symptom:
            icon = Icons.healing; // Bandage icon for symptoms
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
          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(item.subtitle),
          onTap: () {
            // LOGIC FOR ROUTING
            if (item.type == SearchItemType.doctor) {
              // 1. Go to specific Doctor Profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DoctorDetailsPage(doctor: (item as SearchableDoctor).doctor),
                ),
              );
            } else if (item.type == SearchItemType.symptom) {
              // 2. Go to Doctor List filtered by the symptom's category
              final symptom = item as Symptom;
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