import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/global_widgets/primary_button.dart';
import 'package:flutter_application_seau/interface/pages/home/home_page.dart';
import 'package:flutter_application_seau/interface/pages/login/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/core/snackbar_util.dart';

// 로그인 버튼 위젯
class LoginButton extends ConsumerStatefulWidget {
  // 이메일 컨트롤러
  final TextEditingController emailController;
  // 비밀번호 컨트롤러
  final TextEditingController passwordController;
  // 폼 키
  final GlobalKey<FormState> formKey;

  // 생성자
  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  // 로딩 상태
  bool _isLoading = false;

  // 로그인 함수
  Future<void> _login() async {
    if (widget.formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final success = await ref.read(loginViewModelProvider.notifier).login(
              widget.emailController.text,
              widget.passwordController.text,
            );
        if (success) {
          SnackbarUtil.showSuccess(context, '로그인에 성공했습니다.');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          SnackbarUtil.showError(context, '로그인에 실패했습니다.');
        }
      } catch (e) {
        SnackbarUtil.showError(context, e.toString());
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 로딩 중이면 로딩 인디케이터를, 아니면 로그인 버튼을 표시
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : PrimaryButton(
            text: "로그인",
            onPressed: _login,
            backgroundColor: const Color(0xFF0770E9),
          );
  }
}
