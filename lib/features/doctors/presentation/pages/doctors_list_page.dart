import 'package:flutter/material.dart';
import '../../../../data/doctor_repository.dart';
import '../../../../models/doctor_model.dart';
import '../../widgets/doctor_card.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({Key? key}) : super(key: key);

  @override
  State<DoctorsListPage> createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  final _repository = DoctorRepository();
  bool _isLoading = true;
  String? _error;
  String _selectedSpecialty = 'Усі';
  List<DoctorModel> _doctors = [];
  List<DoctorModel> _allDoctors = [];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      _allDoctors = await _repository.getDoctors();
      _applyFilter();
    } catch (e) {
      _error = 'Помилка завантаження даних: $e';
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _applyFilter() {
    setState(() {
      _doctors = _selectedSpecialty == 'Усі'
          ? _allDoctors
          : _allDoctors
                .where((d) => d.specialty == _selectedSpecialty)
                .toList();
    });
  }

  Future<void> _openFilter() async {
    final options = [
      'Усі',
      ...{
        for (var d in _allDoctors)
          if (d.specialty.isNotEmpty) d.specialty,
      },
    ];

    String tempSelected = _selectedSpecialty;

    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // дозволяє задавати власну висоту
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final screenHeight = MediaQuery.of(ctx).size.height;

        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                height: screenHeight * 0.5, // 50% висоти екрана
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Filter by specialty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Прокручуваний список опцій
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final opt = options[index];
                            return RadioListTile<String>(
                              title: Text(opt),
                              value: opt,
                              groupValue: tempSelected,
                              onChanged: (val) {
                                setModalState(() => tempSelected = val!);
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    // Кнопки внизу
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(ctx, tempSelected),
                              child: const Text('Apply'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    if (result != null && result != _selectedSpecialty) {
      setState(() {
        _selectedSpecialty = result;
        _applyFilter();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        title: const Text(
          'Список лікарів',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilter,
          ),
        ],
      ),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadDoctors,
              child: const Text('Спробувати знову'),
            ),
          ],
        ),
      );
    }
    if (_doctors.isEmpty) {
      return const Center(child: Text('Список лікарів порожній'));
    }

    return RefreshIndicator(
      onRefresh: _loadDoctors,
      child: ListView.builder(
        itemCount: _doctors.length,
        itemBuilder: (context, index) => DoctorCard(doctor: _doctors[index]),
      ),
    );
  }
}
