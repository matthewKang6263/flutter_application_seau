import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/calendar_tab/widgets/calendar_tab_app_bar.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Column(
        children: [
          CalendarTabAppBar(),
        ],
      ),
    );
  }
}
