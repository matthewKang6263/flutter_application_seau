import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/global_widgets/email_text_form_field.dart';
import 'package:flutter_application_seau/interface/global_widgets/pw_text_form_field.dart';
import 'package:flutter_application_seau/interface/pages/login/widgets/login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/core/validator_util.dart';

// 로그인 폼 위젯
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  // 이메일 컨트롤러
  final emailController = TextEditingController();
  // 비밀번호 컨트롤러
  final passwordController = TextEditingController();
  // 폼 키
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 컨트롤러 해제
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        // 스크롤 가능하도록 변경
        child: Column(
          children: [
            // 이메일 입력 필드
            EmailTextFormField(
              controller: emailController,
              validator: ValidatorUtil.validateEmail,
            ),
            const SizedBox(height: 16),
            // 비밀번호 입력 필드
            PwTextFormField(
              controller: passwordController,
              validator: ValidatorUtil.validatePassword,
            ),
            const SizedBox(height: 40), // Spacer 대신 고정된 높이 사용
            // 로그인 버튼
            LoginButton(
              emailController: emailController,
              passwordController: passwordController,
              formKey: _formKey,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
