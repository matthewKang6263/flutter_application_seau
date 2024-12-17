import 'package:flutter/material.dart';

class CalendarList extends StatelessWidget {
  final List<Map<String, String>> savedItems;
  final Function(String) onDelete;

  const CalendarList({
    Key? key,
    required this.savedItems,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 0, top: 10),
            child: Text(
              '전체 일정 목록',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                final item = savedItems[index];
                return Dismissible(
                  key: Key(item['id'] ?? ''),
                  direction: DismissDirection.endToStart,
                  dismissThresholds: const {
                    DismissDirection.endToStart: 0.5, // 20%만 스와이프하면 동작하도록 설정
                  },
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('일정 삭제'),
                          content: Text('이 일정을 삭제하시겠습니까?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                '취소',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                '삭제',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    onDelete(item['id'] ?? '');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('일정이 삭제되었습니다')),
                    );
                  },
                  child: Card(
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
                                      style: TextStyle(fontSize: 14),
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
                                      style: TextStyle(fontSize: 14),
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
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
