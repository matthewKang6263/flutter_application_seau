// home_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/home_tab/widgets/home_tab_app_bar.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/home_tab/widgets/home_tab_user_list.dart';

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
          HomeTabAppBar(
            onSearchChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          HomeTabUserList(searchQuery: searchQuery),
        ],
      ),
    );
  }
}
