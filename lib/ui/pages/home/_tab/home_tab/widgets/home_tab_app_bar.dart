import 'package:flutter/material.dart';

class HomeTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          onTap: () {
            // 텍스트 필드 클릭 시 동작
          },
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.grey[150], // 더 밝은 회색으로 설정
            prefixIcon: Icon(Icons.search, color: Colors.black),
            hintText: '검색어를 입력해주세요',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 8, horizontal: 8), // 높이를 줄이기 위해 vertical 패딩 감소
          ),
        ),
      ),
    );
  }
}
