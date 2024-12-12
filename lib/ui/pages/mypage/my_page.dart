import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('나의 프로필'),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 제거
      ),
      body: Column(
        children: [ // 상단 프로필 섹션
          Container(
            color: Colors.white, // 프로필 섹션 배경 색상
            child: Column( // 프로필 섹션 콘텐츠 1. 프로필이미지 2. 사용자닉네임 3. 사용자주소
              children: [ 
                CircleAvatar(  
                  radius: 50,
                  backgroundColor: Colors.blue[200],
                  child: Icon(Icons.person,
                  size: 50,
                  color: Colors.white,
                  ),
                ),
                SizedBox(height: 15,),
                Text('닉네임',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 5,),
                Text('서울시 강동구 명일동',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600]
                ),
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  text: '프로필 수정',
                  onPressed: (){},
                  backgroundColor: Colors.white,
                  ),
              ],
            ),
          )
        ],
      )
    );
  }
}
