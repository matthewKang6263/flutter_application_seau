import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/calendar/calendar_registor_page.dart';

class CalendarTabAppBar extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(Map<String, String>) onAddItem;

  const CalendarTabAppBar({
    Key? key,
    required this.selectedDate,
    required this.onAddItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '나의 캘린더',
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
      centerTitle: true,
      actions: [
        Container(
          child: IconButton(
            icon: Icon(
              Icons.add,
              size: 24,
            ),
            onPressed: () async {
              if (selectedDate != null) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarRegistorPage(
                      selectedDate: selectedDate!,
                    ),
                  ),
                );

                if (result != null && result is Map<String, String>) {
                  onAddItem(result);
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
