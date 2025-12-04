import 'package:flutter/material.dart';
import '../../../../data/doctor_repository.dart';
import '../../../../models/doctor_model.dart';
import 'package:medical_flutter_exam2025/features/doctors/widgets/doctor_card.dart';
import 'package:medical_flutter_exam2025/features/doctors/presentation/pages/doctor_booking_page.dart';

class DoctorDetailsPage extends StatefulWidget {
  final DoctorModel doctor;
  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  late DoctorModel doctor;
  int selectedDate = -1;
  int selectedTime = -1;

  final dates = [
    {"day": "21", "weekday": "Пн"},
    {"day": "22", "weekday": "Вт"},
    {"day": "23", "weekday": "Ср"},
    {"day": "24", "weekday": "Чт"},
    {"day": "25", "weekday": "Пт"},
    {"day": "26", "weekday": "Сб"},
  ];

  final times = [
    "09:00",
    "10:00",
    "11:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "19:00",
  ];

  @override
  void initState() {
    super.initState();
    doctor = widget.doctor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Деталі про лікаря",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            DoctorCard(doctor: doctor),
            const SizedBox(height: 16),
            const Text(
              "Про лікаря",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "Лікар з багаторічним досвідом роботи. Спеціалізується на консультаціях та лікуванні. Уважно ставиться до пацієнтів та підбирає індивідуальні методи лікування.",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            // Дати
            Center(
              child: SizedBox(
                height: 78,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final isSelected = selectedDate == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedDate = index),
                      child: Container(
                        width: 62,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00897B)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF00897B)
                                : Colors.grey.shade300,
                            width: isSelected ? 0 : 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dates[index]["weekday"]!,
                              style: TextStyle(
                                fontSize: 13,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              dates[index]["day"]!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(height: 0.8, color: Colors.grey.shade300),
            const SizedBox(height: 20),

            // Часи
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3.2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemCount: times.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedTime == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTime = index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF00897B)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF00897B)
                              : Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          times[index],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == -1 || selectedTime == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Оберіть дату та час")),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorBookingPage(
                          doctor: doctor,
                          selectedDate: dates[selectedDate]["day"]!,
                          selectedTime: times[selectedTime],
                        ),
                      ),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Записатися на консультацію",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
