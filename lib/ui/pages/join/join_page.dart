import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/address_search/address_search_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_application_seau/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_application_seau/ui/widgets/email_text_form_field.dart';
import 'package:flutter_application_seau/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final joinViewModel = ref.watch(joinViewModelProvider.notifier);

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
              Container(height: 4, color: const Color(0xFFDDDDDD)),
              FractionallySizedBox(
                widthFactor: 0.33,
                child: Container(height: 4, color: const Color(0xFF0770E9)),
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
                  const Text("계정을 생성하세요",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  NicknameTextFormField(controller: nicknameController),
                  const SizedBox(height: 16),
                  EmailTextFormField(controller: emailController),
                  const SizedBox(height: 16),
                  PwTextFormField(controller: passwordController),
                  const Spacer(),
                  PrimaryButton(
                    text: "다음",
                    onPressed: () async {
                      try {
                        // 회원가입 첫 단계 실행
                        await joinViewModel.initiateSignUp(
                          emailController.text,
                          passwordController.text,
                          nicknameController.text,
                        );
                        // 주소 검색 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddressSearchPage()),
                        );
                      } catch (e) {
                        // 에러 메시지 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    backgroundColor: const Color(0xFF0770E9),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
