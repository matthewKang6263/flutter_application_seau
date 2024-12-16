import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // 기본 유저 정보
  final String uid; // Firebase 문서 ID
  final String id; //사용자 아이디
  final String nickname; // 닉네임(화면에 표시될 이름)

  // 생성자
  User({
    required this.uid,
    required this.id,
    required this.nickname,
  });

  // Firestore 문서를 User 객체로 변환하는 팩토리 생성자
  factory User.fromFirestore(DocumentSnapshot doc) {
    // 문서 데이터를 Map으로 변환
    final data = doc.data() as Map<String, dynamic>;

    return User(
      uid: doc.id, // 문서 ID를 uid로 사용
      id: data['id'],
      nickname: data['nickname'], // 닉네임 필드
    );
  }

  // User 객체를 Firestore에 저장할 수 있는 Map으로 변환
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      'nickname': nickname,
    };
  }
}
