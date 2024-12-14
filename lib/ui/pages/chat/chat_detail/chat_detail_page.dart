import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_body.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_input.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다이빙 러버와의 채팅'), // 상단 제목
      ),
      body: Column(
        children: [
          // 메시지 영역
          ChatDetailBody(),
          // 메시지 입력 영역
          ChatDetailInput(),
        ],
      ),
    );
  }
}
