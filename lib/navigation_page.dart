import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/calendar/calendar_page.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_page.dart';
import 'package:flutter_application_seau/ui/pages/home/home_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/my_page.dart';
import 'package:flutter_application_seau/ui/pages/welcome/welcome_page.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomePage())),
              child: const Text('웰컴페이지'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPage())),
              child: const Text('마이페이지'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalendarPage())),
              child: const Text('캘린더페이지'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage())),
              child: const Text('채팅페이지'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
              child: const Text('홈페이지'),
            ),
          ],
        ),
      ),
    );
  }
}
