import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/mypage/certification_edit/certification_edit_view_model.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificationEditPage extends ConsumerStatefulWidget {
  const CertificationEditPage({super.key});

  @override
  ConsumerState<CertificationEditPage> createState() =>
      _CertificationEditPageState();
}

class _CertificationEditPageState extends ConsumerState<CertificationEditPage> {
  String selectedType = "freediving";
  String selectedLevel = "lv2";
  late String initialType;
  late String initialLevel;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(certificationEditViewModelProvider.notifier).loadUserData();
      final user = ref.read(certificationEditViewModelProvider);
      if (user != null) {
        setState(() {
          selectedType = user.certificationType;
          selectedLevel = user.certificationLevel;
          initialType = user.certificationType;
          initialLevel = user.certificationLevel;
        });
      }
    });
  }


  Future<void> _updateCertification() async {
    if (selectedType == initialType && selectedLevel == initialLevel) {
      // 수정 내역이 없는 경우
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수정 내역이 없습니다')),
      );
      return;
    }

    try {
      await ref
          .read(certificationEditViewModelProvider.notifier)
          .updateCertification(selectedType, selectedLevel);

      Navigator.pop(context, true); // 수정 후 이전 페이지로 돌아감
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생했습니다: $e')),
      );
    }
  }

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
                    "자격증 수정",
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
              text: "수정하기",
              onPressed: _updateCertification,
              backgroundColor: const Color(0xFF0770E9),
            ),
          ),
        ],
      ),
    );
  }
}
