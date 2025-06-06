import 'package:agendamento_postagens/style/Cor.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/Postagem.dart'; // ajuste se o caminho for diferente

class CalendarioWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Map<DateTime, List<Postagem>> eventosPorDia;

  const CalendarioWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.eventosPorDia,
  });

  List<Postagem> _eventLoader(DateTime day) {
    final dataNormalizada = DateTime(day.year, day.month, day.day);
    return eventosPorDia[dataNormalizada] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TableCalendar<Postagem>(
        locale: 'pt_BR',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        eventLoader: _eventLoader,
        calendarStyle:  CalendarStyle(
          todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: Cor.primaria, shape: BoxShape.circle),
          markerDecoration: BoxDecoration(color: Cor.primaria, shape: BoxShape.circle),
        ),
        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    events.length > 3 ? 3 : events.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0.5),
                      width: 5,
                      height: 5,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Cor.primaria,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
