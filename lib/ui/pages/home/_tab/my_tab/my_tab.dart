import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/my_tab/widgets/my_tab_app_bar.dart';

class MyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          MyTabAppBar(),
        ],
      ),
    );
  }
}
