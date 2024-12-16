import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarEvent {
  final String id;
  final String title;
  final DateTime date;
  final String time;
  final String location;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
  });

  // Firestore에서 데이터를 가져올 때 사용
  factory CalendarEvent.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CalendarEvent(
      id: doc.id,
      title: data['title'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] ?? '',
      location: data['location'] ?? '',
    );
  }

  // Firestore에 데이터를 저장할 때 사용
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'date': Timestamp.fromDate(date),
      'time': time,
      'location': location,
    };
  }

  // UI에서 사용할 Map 형태로 변환
  Map<String, String> toMap() {
    return {
      'id': id,
      'name': title,
      'date': '${date.year}년 ${date.month}월 ${date.day}일',
      'time': time,
      'location': location,
      'weekday': _getWeekdayString(date.weekday),
      'day': date.day.toString(),
    };
  }

  static String _getWeekdayString(int weekday) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[weekday - 1];
  }
}
