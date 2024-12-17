import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:flutter_application_seau/ui/pages/mypage/certification_edit/certification_edit_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/profile_edit/profile_edit_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/widgets/info_card.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepository = ref.watch(userRepositoryProvider);
    final userFuture = userRepository.getUser(userRepository.getCurrentUserId());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 프로필',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<AppUser?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          }

          final user = snapshot.data;

          if (user == null) {
            return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
          }

          return Column(
            children: [
              // 상단: 프로필 섹션
              Container(
                color: Colors.white, // 프로필 섹션 배경 색상
                padding: const EdgeInsets.only(bottom: 40), // 프로필 섹션 하단 패딩
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    UserProfileImage(
                      dimension: 100,
                      imgUrl: '',
                      onEdit: () {}, // 프로필 이미지 수정 로직 추가!
                    ),
                    const SizedBox(height: 30),
                    Text(
                      user.nickname,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.location,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PrimaryButton(
                        text: '프로필 수정',
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0770E9),
                        ),
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey,
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                          );
                          if (result == true) {
                            _showToast('수정이 완료되었습니다.');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 하단: 레벨 정보 카드
              InfoCard(
                title: '레벨 정보',
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified, color: Colors.blue),
                          const SizedBox(width: 5),
                          Text(
                            user.certificationLevel,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          const Icon(Icons.waves, color: Colors.blue),
                          const SizedBox(width: 5),
                          Text(
                            user.certificationType,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CertificationEditPage()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}