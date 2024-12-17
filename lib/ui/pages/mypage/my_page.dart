import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/mypage/certification_edit/certification_edit_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/profile_edit/profile_edit_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/widgets/info_card.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '나의 프로필',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0, // 그림자 제거
        ),
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            // 상단: 프로필 섹션
            Container(
              color: Colors.white, // 프로필 섹션 배경 색상
              padding: EdgeInsets.only(bottom: 40), // 프로필 섹션 하단 패딩
              child: Column(
                // 프로필 섹션 콘텐츠 1. 프로필이미지 2. 사용자닉네임 3. 사용자주소 4. 수정버튼
                children: [
                  SizedBox(height: 20),
                  UserProfileImage(
                    dimension: 100,
                    imgUrl: '',
                    onEdit: () {}, // 프로필 이미지 수정 로직 추가!
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '닉네임',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '서울시 강동구 명일동',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  // 프로필 수정 버튼
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: PrimaryButton(
                      text: '프로필 수정',
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0770E9)),
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey,
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditPage() // 버튼 클릭 시 페이지 이동
                              ),
                        );
                        if (result == true) {
                          _showToast('수정이 완료되었습니다.'); // 반환 값이 true면 토스트 메시지 표시
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 하단: 레벨 정보 카드
            InfoCard(
              title: '레벨 정보',
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    // 첫 번째 아이콘과 텍스트
                    Row(
                      children: [
                        Icon(Icons.verified, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          'Lv.2',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    // 두 번째 아이콘과 텍스트
                    Row(
                      children: [
                        Icon(Icons.waves, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          '프리다이버',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CertificationEditPage()),
                );
              },
            ),
          ],
        ));
  }
}
