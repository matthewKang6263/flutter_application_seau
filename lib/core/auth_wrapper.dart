import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/home/home_page.dart';
import 'package:flutter_application_seau/interface/pages/welcome/welcome_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/core/auth_service.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AuthService의 authStateChanges 스트림을 구독
    final authStateStream = ref.watch(authServiceProvider).authStateChanges();

    return StreamBuilder(
      stream: authStateStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return WelcomePage();
          } else {
            return HomePage();
          }
        }
        // 연결 상태가 active가 아닐 경우 로딩 인디케이터 표시
        return const CircularProgressIndicator();
      },
    );
  }
}
