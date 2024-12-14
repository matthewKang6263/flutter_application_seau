import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_body.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_input.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';

class ChatDetailPage extends StatelessWidget {
  final String userName; // 상대방 이름
  final String? userImg; // 상대방 프로필 이미지
  //
  const ChatDetailPage({
    Key? key,
    required this.userName,
    this.userImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 타이틀에 상대방 이름
        title: Text('$userName님과의 채팅'),
      ),
      body: Column(
        children: [
          ChatDetailBody(userImg: userImg),
          ChatDetailInput(),
        ],
      ),
    );
  }
}
