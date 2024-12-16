import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/certification/certification_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class AddressEditPage extends StatelessWidget {
  const AddressEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "활동지역을 선택해주세요",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 위치 입력 텍스트 필드
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: "위치를 입력해주세요",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 현재 위치로 찾기 버튼
                  ElevatedButton.icon(
                    onPressed: () {
                      // 현재 위치로 찾기 동작 정의
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14C2BF), // 새로운 색상
                      minimumSize: const Size.fromHeight(48), // 버튼 높이
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    icon: const Icon(Icons.my_location, color: Colors.white),
                    label: const Text(
                      "현재 위치로 찾기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // 볼드 처리
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 검색 결과 리스트 (예시 데이터 제거)
                  Expanded(
                    child: ListView.builder(
                      itemCount: 0, // 데이터가 없을 때
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "검색 결과 데이터",
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
