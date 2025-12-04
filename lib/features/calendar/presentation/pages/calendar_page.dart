import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../data/appointment_repository.dart';
import '../../../../models/appointment_model.dart';
import '../../widgets/appointment_card.dart';
import '../../../../core/widgets/navigation/bottom_nav_bar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _repository = AppointmentRepository();
  late Future<List<AppointmentModel>> _appointmentsFuture;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<AppointmentModel>> _appointmentsByDate;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _appointmentsFuture = _loadAppointments();
  }

  Future<List<AppointmentModel>> _loadAppointments() async {
    final appointments = await _repository.getAppointments();
    _buildAppointmentMap(appointments);
    return appointments;
  }

  void _buildAppointmentMap(List<AppointmentModel> appointments) {
    _appointmentsByDate = {};
    for (var appointment in appointments) {
      final dateKey = DateTime(
        appointment.appointmentTime.year,
        appointment.appointmentTime.month,
        appointment.appointmentTime.day,
      );
      if (_appointmentsByDate.containsKey(dateKey)) {
        _appointmentsByDate[dateKey]!.add(appointment);
      } else {
        _appointmentsByDate[dateKey] = [appointment];
      }
    }
  }

  List<AppointmentModel> _getAppointmentsForDay(DateTime day) {
    final dateKey = DateTime(day.year, day.month, day.day);
    return _appointmentsByDate[dateKey] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мої записи до лікарів',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Помилка: ${snapshot.error}'));
          }

          final appointments = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                // Calendar Widget
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TableCalendar<AppointmentModel>(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        eventLoader: _getAppointmentsForDay,
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: const Color(0xFFA8D5BA).withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: Color(0xFF56AB91),
                            shape: BoxShape.circle,
                          ),
                          markersMaxCount: 3,
                          markerDecoration: const BoxDecoration(
                            color: Color(0xFFA8D5BA),
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Appointments Section
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Записи на день:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_selectedDay?.day}/${_selectedDay?.month}/${_selectedDay?.year}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                // Appointments List for Selected Day
                if (_getAppointmentsForDay(_selectedDay!).isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Немає записів на цей день',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _getAppointmentsForDay(_selectedDay!).length,
                    itemBuilder: (context, index) {
                      final appointment = _getAppointmentsForDay(
                        _selectedDay!,
                      )[index];
                      return AppointmentCard(appointment: appointment);
                    },
                  ),

                const SizedBox(height: 24),

                // Upcoming Appointments Section
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Найближчі записи:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appointments.length > 3 ? 3 : appointments.length,
                  itemBuilder: (context, index) {
                    final sortedAppointments =
                        List<AppointmentModel>.from(appointments)..sort(
                          (a, b) =>
                              a.appointmentTime.compareTo(b.appointmentTime),
                        );
                    final filteredAppointments = sortedAppointments
                        .where((a) => a.appointmentTime.isAfter(DateTime.now()))
                        .toList();

                    if (filteredAppointments.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Немає майбутніх записів',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      );
                    }

                    return AppointmentCard(
                      appointment: filteredAppointments[index],
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
