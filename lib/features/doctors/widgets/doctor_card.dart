import 'package:flutter/material.dart';
import '../../../models/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  Widget _buildInitials() {
    return Center(
      child: Text(
        doctor.fullName.isNotEmpty ? doctor.fullName[0] : '?',
        style: const TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 128,
                height: 128,
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

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 68,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(17, 12, 206, 196),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: Color.fromARGB(255, 37, 145, 153),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${doctor.likes}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 37, 145, 153),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.location ?? '',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    overflow: TextOverflow.ellipsis,
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
