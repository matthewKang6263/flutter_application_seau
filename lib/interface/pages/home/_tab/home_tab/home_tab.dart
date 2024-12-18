import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/home/_tab/home_tab/widgets/home_tab_app_bar.dart';
import 'package:flutter_application_seau/interface/pages/home/_tab/home_tab/widgets/home_tab_user_list.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 앱바 위젯
          HomeTabAppBar(
            onSearchChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          // 사용자 리스트 위젯 (검색어 전달)
          Expanded(
            child: HomeTabUserList(searchQuery: searchQuery),
          ),
        ],
      ),
    );
  }
}
