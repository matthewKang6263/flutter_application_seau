import 'package:flutter/material.dart';

class HomeTabUserList extends StatelessWidget {
  final int totalUsers = 20; // 예시 데이터

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text(
              '원하는 버디를 찾아보세요',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '총 ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: '$totalUsers',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '명의 추천 버디',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: totalUsers,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
                height: 1,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                  title: Text(
                    '닉네임',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('기본 정보: 프리다이빙'),
                      Text('다이버 레벨: 레벨 2'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text('채팅하기'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
