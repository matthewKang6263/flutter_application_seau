// chat_detail_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_receive_item.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_send_item.dart';

class ChatDetailBody extends StatelessWidget {
  // 테스트용 더미 데이터 - 실제 채팅처럼 대화 구성
  final List<Widget> messages = [
    ChatDetailReceiveItem(
      imgUrl: "https://picsum.photos/200",
      showProfile: true, // 첫 메시지는 프로필 표시
      content: "안녕하세요. 함께 다이빙 하고 싶습니다.",
      dateTime: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    ChatDetailReceiveItem(
      imgUrl: "https://picsum.photos/200",
      showProfile: false, // 연속된 메시지는 프로필 숨김
      content: "이번주 토요일 오후 2시에 K26 어떠세요?",
      dateTime: DateTime.now().subtract(Duration(minutes: 29)),
    ),
    ChatDetailSendItem(
      content: "좋습니다! 시간과 장소 모두 괜찮아요.",
      dateTime: DateTime.now().subtract(Duration(minutes: 25)),
    ),
    ChatDetailReceiveItem(
      imgUrl: "https://picsum.photos/200",
      showProfile: true, // 새로운 대화 시작이므로 프로필 표시
      content: "그럼 일정 체크해놓을게요~ 수락 부탁드려요",
      dateTime: DateTime.now().subtract(Duration(minutes: 10)),
    ),
    ChatDetailSendItem(
      content: "넵! 수락 완료했습니다. 토요일에 뵐게요 :)",
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: messages.length,
        // 메시지 사이 간격
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) => messages[index],
      ),
    );
  }
}
