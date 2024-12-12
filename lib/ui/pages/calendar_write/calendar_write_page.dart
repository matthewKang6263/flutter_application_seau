import 'package:flutter/material.dart';

class CalendarWritePage extends StatelessWidget {
  final DateTime selectedDate; // 선택된 날짜를 받아오는 변수 추가

  CalendarWritePage({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // 요일을 한글로 변환하는 함수
  String getKoreanWeekday(int weekday) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[weekday - 1];
  }

  String getEnglishWeekday(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    // 선택된 날짜를 자동으로 설정
    dateController.text =
        '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일 ${getKoreanWeekday(selectedDate.weekday)}요일';

    return Scaffold(
      appBar: AppBar(
        title: Text('일정 등록', style: TextStyle(fontSize: 16)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: '이름 입력',
                          hintText: '예시) 나의 버디',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: dateController,
                        enabled: false, // 날짜 필드를 수정 불가능하게 설정
                        decoration: InputDecoration(
                          labelText: '날짜',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          labelText: '시간 입력',
                          hintText: '예시) 오후 2:00',
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: '장소 입력',
                          hintText: '예시) 서울 강남구',
                          prefixIcon: Icon(Icons.location_on),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String date = dateController.text;
                  String time = timeController.text;
                  String location = locationController.text;

                  Navigator.pop(context, {
                    'name': name,
                    'date': date,
                    'time': time,
                    'location': location,
                    'weekday': getEnglishWeekday(selectedDate.weekday),
                    'day': selectedDate.day.toString(),
                  });
                },
                child: Text('등록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
