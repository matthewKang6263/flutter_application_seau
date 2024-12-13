import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/_tab/chat_tab/widgets/chat_tab_app_bar.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          ChatTabAppBar(),
        ],
      ),
    );
  }
}
