import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon1;
  final String text1;
  final IconData icon2;
  final String text2;
  final VoidCallback onTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon1,
    required this.text1,
    required this.icon2,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4, // 카드 전체에 그림자 적용
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // 아이콘과 텍스트가 있는 Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon1, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        text1,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      Icon(icon2, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        text2,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}