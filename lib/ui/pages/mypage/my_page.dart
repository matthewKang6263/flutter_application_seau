import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/certification/certification_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/widgets/info_card.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('나의 프로필',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
          backgroundColor: Colors.white,
          elevation: 0, // 그림자 제거
        ),
        body: Column(
          children: [
            // 상단 프로필 섹션
            Container(
              color: Colors.white, // 프로필 섹션 배경 색상
              child: Column(
                // 프로필 섹션 콘텐츠 1. 프로필이미지 2. 사용자닉네임 3. 사용자주소
                children: [
                  SizedBox(height: 15),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[200],
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  // 프로필 수정 버튼
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                      ),
                      child: PrimaryButton(
                        text: '프로필 수정',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // 레벨 정보 카드
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
                    SizedBox(width: 20),
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
                  MaterialPageRoute(builder: (context) => CertificationPage()),
                );
              },
            ),
          ],
        ));
  }
}
