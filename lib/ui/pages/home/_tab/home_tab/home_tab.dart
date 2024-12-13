import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/home_tab/widgets/home_tab_app_bar.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          HomeTabAppBar(),
        ],
      ),
    );
  }
}
