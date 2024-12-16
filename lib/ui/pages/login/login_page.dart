import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/home_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_application_seau/ui/widgets/email_text_form_field.dart';
import 'package:flutter_application_seau/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_application_seau/ui/pages/login/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(); // 이메일 컨트롤러 생성
    final passwordController = TextEditingController(); // 비밀번호 컨트롤러 생성
    final loginViewModel = LoginViewModel();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("로그인 하세요",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            EmailTextFormField(controller: emailController),
            const SizedBox(height: 16),
            PwTextFormField(controller: passwordController),
            const Spacer(),
            PrimaryButton(
              text: "완료",
              onPressed: () async {
                try {
                  // 로그인 로직 실행
                  await loginViewModel.signIn(
                    emailController.text,
                    passwordController.text,
                  );
                  // 로그인 성공 시 홈 페이지로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } on FirebaseAuthException catch (e) {
                  // 에러 메시지 설정
                  String errorMessage;
                  if (e.code == 'user-not-found') {
                    errorMessage = '등록되지 않은 이메일입니다.';
                  } else if (e.code == 'wrong-password') {
                    errorMessage = '잘못된 비밀번호입니다.';
                  } else {
                    errorMessage = '로그인에 실패했습니다: ${e.message}';
                  }
                  // 에러 메시지 표시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                }
              },
              backgroundColor: const Color(0xFF0770E9),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';


// class LoginPage extends StatefulWidget {
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final idController = TextEditingController();
//   final pwController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     idController.dispose();
//     pwController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Form(
//           key: formKey,
//           child: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             children: [
//               Text(
//                 '안녕하세요!\n아이디와 비밀번호로 로그인해주세요',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               IdTextFormField(controller: idController),
//               SizedBox(height: 20),
//               PwTextFormField(controller: pwController),
//               SizedBox(height: 20),
//               Consumer(builder: (context, ref, child) {
//                 return ElevatedButton(
//                   onPressed: () async {
//                     // 벨리데이션 성공했을 때, 로그인 요청
//                     if (formKey.currentState?.validate() ?? false) {
//                       final viewModel = ref.read(loginViewmodel);
//                       final loginResult = await viewModel.login(
//                         username: idController.text,
//                         password: pwController.text,
//                       );
//                       if (loginResult) {
//                         // 로그인 성공 => HomePage로 이동.(모든페이지를 제거한뒤 가야함)
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return HomePage();
//                             },
//                           ),
//                           // 기존 네이게이터 스택에 남아있는 페이지들이 하나씩
//                           // route라는 인자로 넘어와서 함수가 실행됨
//                           // 페이지 스택에 남길지 여부 리턴!
//                           (route) {
//                             return false;
//                           },
//                         );
//                       } else {
//                         // 로그인 실패 => 스낵바!
//                         SnackbarUtil.showSnackBar(context, '아이디와 비밀번호를 확인해주세요');
//                       }
//                     }

//                     ;
//                   },
//                   child: Text('로그인'),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
