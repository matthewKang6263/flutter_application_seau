import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String nickname;
  final String email;
  final String location;
  final String certificationType;
  final String certificationLevel;
  final String? profileImageUrl;

  AppUser({
    required this.id,
    required this.nickname,
    required this.email,
    required this.location,
    required this.certificationType,
    required this.certificationLevel,
    this.profileImageUrl,
  });

  // Firestore 문서를 AppUser 객체로 변환하는 팩토리 메서드
  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppUser(
      id: doc.id,
      nickname: data['nickname'] ?? '',
      email: data['email'] ?? '',
      location: data['location'] ?? '',
      certificationType: data['certificationType'] ?? '',
      certificationLevel: data['certificationLevel'] ?? '',
      profileImageUrl: data['profileImageUrl'],
    );
  }

  // AppUser 객체를 Map으로 변환하는 메서드 (Firestore에 저장할 때 사용)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'email': email,
      'location': location,
      'certificationType': certificationType,
      'certificationLevel': certificationLevel,
      'profileImageUrl': profileImageUrl,
    };
  }
}
