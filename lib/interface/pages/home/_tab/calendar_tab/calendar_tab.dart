import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/model/calendar.dart';
import 'package:flutter_application_seau/data/repository/calendar_repository.dart';
import 'package:flutter_application_seau/interface/pages/home/_tab/calendar_tab/widgets/calendar_tab_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/calendar_view.dart';
import 'widgets/calendar_list.dart';

class CalendarTab extends StatefulWidget {
  CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final eventsAsyncValue = ref.watch(calendarEventsProvider);

        return Container(
          color: Colors.white,
          child: SizedBox.expand(
            child: Column(
              children: [
                CalendarTabAppBar(
                  selectedDate: selectedDate,
                  onAddItem: (Map<String, String> newItem) {
                    final event = CalendarEvent(
                      id: '',
                      title: newItem['name'] ?? '',
                      date: _parseDateString(newItem['date'] ?? ''),
                      time: newItem['time'] ?? '',
                      location: newItem['location'] ?? '',
                    );
                    ref.read(calendarRepositoryProvider).addEvent(event);
                  },
                ),
                Expanded(
                  child: Column(
                    children: [
                      CalendarView(
                        key: ValueKey(eventsAsyncValue.hashCode),
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        savedItems: eventsAsyncValue.when(
                          data: (events) =>
                              events.map((e) => e.toMap()).toList(),
                          loading: () => [],
                          error: (_, __) => [],
                        ),
                      ),
                      eventsAsyncValue.when(
                        data: (events) => CalendarList(
                          savedItems: events.map((e) => e.toMap()).toList(),
                          onDelete: (String id) {
                            // 여기에서 실제 삭제 로직을 구현합니다.
                            ref
                                .read(calendarRepositoryProvider)
                                .deleteEvent(id);
                          },
                        ),
                        loading: () => CircularProgressIndicator(),
                        error: (_, __) => Text('Error loading events'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DateTime _parseDateString(String dateStr) {
    final regex = RegExp(r'(\d{4})년\s*(\d{1,2})월\s*(\d{1,2})일');
    final match = regex.firstMatch(dateStr);
    if (match != null) {
      final year = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final day = int.parse(match.group(3)!);
      return DateTime(year, month, day);
    }
    return DateTime.now();
  }
}
