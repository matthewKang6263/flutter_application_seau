// chat_detail_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_receive_item.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_send_item.dart';

class ChatDetailBody extends StatelessWidget {
  final String? userImg; // 상대방 프로필 이미지

  ChatDetailBody({
    required this.userImg,
  });

  // messages를 getter로 변경하여 동적으로 생성
  List<Widget> get messages {
    return [
      ChatDetailReceiveItem(
        imgUrl: userImg, // 전달받은 프로필 이미지 사용
        showProfile: true,
        content: "안녕하세요. 함께 다이빙 하고 싶습니다.",
        dateTime: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      ChatDetailReceiveItem(
        imgUrl: userImg, // 전달받은 프로필 이미지 사용
        showProfile: false,
        content: "이번주 토요일 오후 2시에 K26 어떠세요?",
        dateTime: DateTime.now().subtract(Duration(minutes: 29)),
      ),
      ChatDetailSendItem(
        content: "좋습니다! 시간과 장소 모두 괜찮아요.",
        dateTime: DateTime.now().subtract(Duration(minutes: 25)),
      ),
      ChatDetailReceiveItem(
        imgUrl: userImg, // 전달받은 프로필 이미지 사용
        showProfile: true,
        content: "그럼 일정 체크해놓을게요~ 수락 부탁드려요",
        dateTime: DateTime.now().subtract(Duration(minutes: 10)),
      ),
      ChatDetailSendItem(
        content: "넵! 수락 완료했습니다. 토요일에 뵐게요 :)",
        dateTime: DateTime.now(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: messages.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) => messages[index],
      ),
    );
  }
}
