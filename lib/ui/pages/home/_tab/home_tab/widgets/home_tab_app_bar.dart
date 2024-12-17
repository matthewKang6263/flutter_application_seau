// home_tab_app_bar.dart
import 'package:flutter/material.dart';

class HomeTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSearchChanged;

  const HomeTabAppBar({Key? key, required this.onSearchChanged})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          onChanged: onSearchChanged,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: Icon(Icons.search, color: Colors.black),
            hintText: '검색어를 입력해주세요',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
        ),
      ),
    );
  }
}
