import 'package:flutter/material.dart';
import '../data/doctor_repository.dart';
import '../models/doctor_model.dart';
import '../widgets/doctor_card.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({Key? key}) : super(key: key);

  @override
  State<DoctorsListPage> createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  final _repository = DoctorRepository();
  bool _isLoading = true;
  String? _error;
  String _selectedSpecialty = 'All';
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
      _doctors = _selectedSpecialty == 'All'
          ? _allDoctors
          : _allDoctors
                .where((d) => d.specialty == _selectedSpecialty)
                .toList();
    });
  }

  Future<void> _openFilter() async {
    final options = [
      'All',
      ...{
        for (var d in _allDoctors)
          if (d.specialty.isNotEmpty) d.specialty,
      },
    ];

    String tempSelected = _selectedSpecialty;

    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Filter by specialty',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              ...options.map(
                (opt) => RadioListTile<String>(
                  title: Text(opt),
                  value: opt,
                  groupValue: tempSelected,
                  onChanged: (val) => setState(() => tempSelected = val!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
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
    );

    if (result != null && result != _selectedSpecialty) {
      _selectedSpecialty = result;
      _applyFilter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Doctors List',
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
