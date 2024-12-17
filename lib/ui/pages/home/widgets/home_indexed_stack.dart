import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_list_page.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/calendar_tab/calendar_tab.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/home_tab/home_tab.dart';
import 'package:flutter_application_seau/ui/pages/home/home_view_model.dart';
import 'package:flutter_application_seau/ui/pages/mypage/my_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeIndexedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModel);
        return IndexedStack(
          index: currentIndex,
          children: [
            HomeTab(),
            CalendarTab(),
            ChatListPage(), //chatTap 페이지 삭제하고 여기서 바로 chatListPage로 연결되도록 수정함
            MyPage(),
          ],
        );
      },
    );
  }
}
