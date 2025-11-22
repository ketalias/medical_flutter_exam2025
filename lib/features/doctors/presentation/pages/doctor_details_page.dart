import 'package:flutter/material.dart';
import '../../../../data/doctor_repository.dart';
import '../../../../models/doctor_model.dart';
import '../../../../widgets/doctor_card.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String doctorId;
  const DoctorDetailsPage({super.key, required this.doctorId});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  final DoctorRepository _repo = DoctorRepository();
  DoctorModel? doctor;

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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDoctor();
  }

  Future<void> _loadDoctor() async {
    final doc = await _repo.getDoctorById(widget.doctorId);
    setState(() {
      doctor = doc;
      isLoading = false;
    });
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  DoctorCard(doctor: doctor!),
                  const SizedBox(height: 16),
                  const Text(
                    "Про лікаря",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.55,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              "Лікар з понад 12-річним досвідом роботи. Спеціалізується на профілактиці, "
                              "ранній діагностиці та лікуванні дитячих захворювань. Проводить консультації...",
                        ),
                        const TextSpan(
                          text: "Читати далі",
                          style: TextStyle(
                            color: Color(0xFF00897B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

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

                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
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
                            const SnackBar(
                              content: Text("Оберіть дату та час"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.teal.shade600,
                              content: const Text(
                                "Ви успішно записані!",
                                style: TextStyle(fontWeight: FontWeight.w600),
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
