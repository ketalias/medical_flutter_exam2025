import 'package:flutter/material.dart';
import '../../../data/doctor_repository.dart';
import '../../../models/doctor_model.dart';

class DoctorsFavorite extends StatefulWidget {
  const DoctorsFavorite({Key? key}) : super(key: key);

  @override
  State<DoctorsFavorite> createState() => _DoctorsFavoriteState();
}

class _DoctorsFavoriteState extends State<DoctorsFavorite> {
  final _repository = DoctorRepository();
  late Future<List<DoctorModel>> _doctorsFuture;

  @override
  void initState() {
    super.initState();
    _doctorsFuture = _repository.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DoctorModel>>(
      future: _doctorsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Помилка: ${snapshot.error}'));
        }

        final doctors = snapshot.data ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Наші лікарі',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/doctorsList');
                        },
                      child: Text(
                        'Дивитись всіх',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),),
                    ),
                  ],
                ),
              ),

              // Horizontal Scroll List
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _DoctorHorizontalCard(doctor: doctor),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _DoctorHorizontalCard extends StatelessWidget {
  final DoctorModel doctor;

  const _DoctorHorizontalCard({Key? key, required this.doctor})
    : super(key: key);

  Widget _buildInitials() {
    return Center(
      child: Text(
        doctor.fullName.isNotEmpty ? doctor.fullName[0] : '?',
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey[200],
              child: doctor.imageUrl.isNotEmpty
                  ? Image.network(
                      doctor.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildInitials(),
                    )
                  : _buildInitials(),
            ),
          ),

          // Doctor Info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  doctor.specialty,
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up,
                      size: 12,
                      color: Color.fromARGB(255, 37, 145, 153),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${doctor.likes}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 37, 145, 153),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
