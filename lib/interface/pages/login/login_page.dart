import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/login/widgets/login_form.dart';
import 'package:flutter_application_seau/interface/pages/login/widgets/login_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 로그인 페이지 위젯 (ConsumerStatefulWidget으로 변경)
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 화면의 빈 공간을 탭하면 키보드가 닫힘
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 20),
              // 로그인 헤더
              LoginHeader(),
              SizedBox(height: 40),
              // 로그인 폼
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
