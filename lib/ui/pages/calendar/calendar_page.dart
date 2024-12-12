import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/calendar_write/calendar_write_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // 1. 날짜 포맷팅 초기화
    _focusedDay = getFocusedDay(); // 2. 포커스 날짜 설정
    _selectedDate = _focusedDay; // 3. 선택된 날짜 설정
    _updateEvents(); // 4. 이벤트 업데이트
  }

  late DateTime _focusedDay;
  DateTime? _selectedDate;
  Map<DateTime, List<dynamic>> _events = {}; //코드 추가

  //코드 추가
  void _updateEvents() {
    _events.clear();
    for (var item in savedItems) {
      try {
        final date = parseDateString(item['date']!);
        // UTC 시간으로 통일
        final eventDate = DateTime.utc(date.year, date.month, date.day);
        if (_events[eventDate] == null) {
          _events[eventDate] = [];
        }
        _events[eventDate]!.add(item);
      } catch (e) {
        print('Date parsing error: ${e.toString()}');
      }
    }
    setState(() {}); // 상태 업데이트 추가
  }

//코드 추가
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

  // 리스트 데이터를 저장할 변수
  List<Map<String, String>> savedItems = [];

  DateTime getFocusedDay() {
    DateTime currentDate = DateTime.now();
    DateTime lastAllowedDate = DateTime(2030, 12, 31);
    return currentDate.isBefore(lastAllowedDate)
        ? currentDate
        : lastAllowedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 캘린더', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              //코드수정
              if (_selectedDate != null) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CalendarWritePage(selectedDate: _selectedDate!),
                  ),
                );

                if (result != null && result is Map<String, String>) {
                  setState(() {
                    savedItems.add(result);
                    _updateEvents(); // 추가
                  });
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 캘린더 위젯
          Expanded(
            flex: 2,
            child: TableCalendar(
              //코드수정
              daysOfWeekHeight: 20,
              rowHeight: 40,
              locale: 'ko_KR',
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2021, 01, 01),
              lastDay: DateTime.utc(2030, 12, 31),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.black),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color.fromRGBO(7, 112, 233, 1), // 원하는 색상으로 변경
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Color.fromRGBO(7, 112, 233, 1)
                      .withOpacity(0.3), // 투명도가 있는 색상
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Color.fromRGBO(7, 112, 233, 1),
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
                markerSize: 5, // 점 크기를 좀 더 크게
                markersAlignment: Alignment.bottomCenter, // 점의 위치 조정
                markerMargin: const EdgeInsets.only(top: 8), // 점과 날짜 사이 간격
              ),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
            ),
          ),

          // 저장된 리스트 출력
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                final item = savedItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      width: 1,
                    ),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 왼쪽 부분 (날짜와 요일)
                        Column(
                          children: [
                            Text(
                              item['weekday'] ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['day'] ?? '',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // 오른쪽 부분 (나머지 정보들)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '나의 버디: ${item['name'] ?? ''}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '확정됨',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text(
                                    item['date'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text(
                                    item['time'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text(
                                    item['location'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
