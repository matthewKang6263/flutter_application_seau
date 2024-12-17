import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/widgets/input_field.dart';
import 'package:flutter_application_seau/ui/widgets/select_field.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class CalendarRegistorPage extends StatefulWidget {
  final DateTime selectedDate;

  CalendarRegistorPage({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _CalendarRegistorPageState createState() => _CalendarRegistorPageState();
}

class _CalendarRegistorPageState extends State<CalendarRegistorPage> {
  String getKoreanWeekday(int weekday) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[weekday - 1];
  }

  String getEnglishWeekday(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    dateController.text =
        '${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일 ${getKoreanWeekday(widget.selectedDate.weekday)}요일';

    nameController.addListener(updateButtonState);
    timeController.addListener(updateButtonState);
    locationController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          timeController.text.isNotEmpty &&
          locationController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(updateButtonState);
    timeController.removeListener(updateButtonState);
    locationController.removeListener(updateButtonState);
    super.dispose();
  }

  // ... 기존의 다른 메서드들 ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '일정 등록',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
            width: 1,
          ),
        ),
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
                        hintText: '예시) 오후 2시',
                        suffixIcon: Icons.access_time,
                      ),
                      SizedBox(height: 16),
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
              child: PrimaryButton(
                text: "등록하기",
                onPressed: isButtonEnabled
                    ? () {
                        String name = nameController.text;
                        String date = dateController.text;
                        String time = timeController.text;
                        String location = locationController.text;

                        Navigator.pop(context, {
                          'name': name,
                          'date': date,
                          'time': time,
                          'location': location,
                          'weekday':
                              getEnglishWeekday(widget.selectedDate.weekday),
                          'day': widget.selectedDate.day.toString(),
                        });
                      }
                    : null,
                backgroundColor:
                    isButtonEnabled ? const Color(0xFF0770E9) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
