import 'package:flutter/material.dart';

import 'package:flutter_application_seau/ui/pages/home/home_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class CertificationPage extends StatefulWidget {
  const CertificationPage({super.key});

  @override
  State<CertificationPage> createState() => _CertificationSelectionPageState();
}

class _CertificationSelectionPageState extends State<CertificationPage> {
  String selectedType = "freediving";
  String selectedLevel = "lv2";

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
          // 프로그레스 바
          Stack(
            children: [
              Container(
                height: 4,
                color: const Color(0xFFDDDDDD),
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  height: 4,
                  color: const Color(0xFF0770E9),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "자격증 정보를 선택해주세요",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "종류",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile(
                    title: const Text(
                      "프리다이빙",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: "freediving",
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value.toString();
                      });
                    },
                    activeColor: const Color(0xFF0770E9),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile(
                    title: const Text(
                      "스쿠버다이빙",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: "scuba",
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value.toString();
                      });
                    },
                    activeColor: const Color(0xFF0770E9),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "레벨",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile(
                    title: const Text(
                      "Lv.1",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: "lv1",
                    groupValue: selectedLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value.toString();
                      });
                    },
                    activeColor: const Color(0xFF0770E9),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile(
                    title: const Text(
                      "Lv.2",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: "lv2",
                    groupValue: selectedLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value.toString();
                      });
                    },
                    activeColor: const Color(0xFF0770E9),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 60),
            child: PrimaryButton(
              text: "완료",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF0770E9),
            ),
          ),
        ],
      ),
    );
  }
}
