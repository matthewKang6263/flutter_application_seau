import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap, // 탭 변경 시 호출
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      selectedItemColor: const Color(0xFF0770E9), // 선택된 항목 색상
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "홈",
          tooltip: "홈",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.calendar),
          activeIcon: Icon(CupertinoIcons.calendar),
          label: "캘린더",
          tooltip: "캘린더",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_2),
          activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
          label: "채팅",
          tooltip: "채팅",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          activeIcon: Icon(CupertinoIcons.person_fill),
          label: "나의 프로필",
          tooltip: "나의 프로필",
        ),
      ],
    );
  }
}
