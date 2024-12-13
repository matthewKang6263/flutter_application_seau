import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/calendar/widgets/input_field.dart';
import 'package:flutter_application_seau/ui/pages/calendar/widgets/select_field.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('일정 등록', style: TextStyle(fontSize: 16)),
      ),
      body: SafeArea(
        child: Column(
          // SafeArea의 child를 Column으로 변경
          children: [
            Expanded(
              // 기존 Expanded 유지
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '다이빙 일정을 등록하세요',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      InputField(
                        controller: nameController,
                        label: '버디 이름',
                        hintText: '예시) 나의 버디',
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: dateController,
                        label: '선택한 날짜',
                        suffixIcon: Icons.calendar_today,
                        enabled: false,
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: timeController,
                        label: '입장 시간',
                        hintText: '예시) 오후 2:00',
                        suffixIcon: Icons.access_time,
                      ),
                      SizedBox(height: 16),
                      // InputField(
                      //   controller: locationController,
                      //   label: '장소 선택',
                      //   hintText: '예시) 서울 강남구',
                      //   suffixIcon: Icons.location_on,
                      // ),
                      SelectField(
                        label: "장소 선택",
                        controller: locationController,
                        items: ["용인 딥스테이션", "시흥 파라다이브", "성남 아쿠아라인"],
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
