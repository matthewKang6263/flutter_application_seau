import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_application_seau/data/model/app_user.dart';

class UserRepository {
  // Firestore 인스턴스
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Firebase Authentication 인스턴스
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // 새 사용자 생성
  Future<void> createUser(AppUser user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  // 사용자 정보 가져오기
  Future<AppUser?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      // fromFirestore 메서드를 사용하여 AppUser 객체 생성
      return AppUser.fromFirestore(doc);
    }
    return null;
  }

  // 사용자 정보 업데이트
  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedFields) async {
    try {
      await _firestore.collection('users').doc(userId).update(updatedFields);
    } catch (e) {
      throw Exception('사용자 정보를 업데이트하는 중 오류가 발생했습니다: $e');
    }
  }

  // 현재 로그인한 사용자 ID 가져오기
  String getCurrentUserId() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('로그인된 사용자가 없습니다.');
    }
  }

  // 회원가입
  Future<String?> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
