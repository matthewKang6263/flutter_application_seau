import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarView extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final List<Map<String, String>> savedItems;

  const CalendarView({
    Key? key,
    required this.onDateSelected,
    required this.savedItems,
  }) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _focusedDay;
  DateTime? _selectedDate;
  Map<DateTime, List<dynamic>> _events = {};

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _focusedDay = DateTime.now();
    _selectedDate = _focusedDay;
    _updateEvents(); // 초기 이벤트 설정
  }

  @override
  void didUpdateWidget(CalendarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.savedItems != oldWidget.savedItems) {
      _updateEvents();
    }
  }

  void _updateEvents() {
    setState(() {
      _events.clear();
      for (var item in widget.savedItems) {
        try {
          final date = parseDateString(item['date']!);
          final eventDate = DateTime.utc(date.year, date.month, date.day);
          if (_events[eventDate] == null) {
            _events[eventDate] = [];
          }
          _events[eventDate]!.add(item);
          // print('이벤트 추가 날짜: $eventDate'); // 디버그 출력 추가
        } catch (e) {
          // print('Date parsing error: ${e.toString()}');
        }
      }
      // print('전체 이벤트: ${_events.length}'); // 전체 이벤트 수 출력
    });
  }

  DateTime parseDateString(String dateStr) {
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

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      daysOfWeekHeight: 20,
      rowHeight: 60,
      locale: 'ko_KR',
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2021, 01, 01),
      lastDay: DateTime.utc(2030, 12, 31),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Color.fromRGBO(7, 112, 233, 1), // 원하는 색상으로 변경
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Color.fromRGBO(235, 247, 255, 1), // 투명도가 있는 색상
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: Color.fromRGBO(6, 94, 195, 1),
          fontSize: 14,
        ),
        markerDecoration: BoxDecoration(
          color: Color.fromRGBO(7, 112, 233, 1),
          shape: BoxShape.circle,
        ),
        markersMaxCount: 1,
        markerSize: 5, // 점 크기를 좀 더 크게
        markersAlignment: Alignment.bottomCenter, // 점의 위치 조정
        markerMargin: const EdgeInsets.only(top: 8),
        cellMargin: EdgeInsets.all(12), // 셀 마진 줄이기
        cellPadding: EdgeInsets.all(2),
        defaultTextStyle: TextStyle(fontSize: 16), // 날짜 텍스트 크기 줄이기
        selectedTextStyle: TextStyle(fontSize: 16, color: Colors.white),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _focusedDay = focusedDay;
          widget.onDateSelected(selectedDay);
        });
      },
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onPageChanged: (focusedDay) => _focusedDay = focusedDay,
      eventLoader: (day) {
        return _events[day] ?? [];
      },
    );
  }
}
