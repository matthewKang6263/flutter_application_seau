import 'package:flutter/material.dart';

class ProfileTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileTabAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '나의 프로필',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: const Border(
        bottom: BorderSide(
          color: Color.fromRGBO(240, 240, 240, 1),
          width: 1,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}