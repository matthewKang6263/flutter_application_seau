import 'package:flutter/material.dart';
import 'package:flutter_application_seau/navigation_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationPage(), // NavigationPage를 홈 화면으로 설정
    );
  }
}
