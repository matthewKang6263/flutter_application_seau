import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/home/home_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 화면 흰색 배경
      appBar: AppBar(
        backgroundColor: Colors.white, // 앱바 흰색
        elevation: 0, // 그림자 제거
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
            const Text(
              "로그인 하세요",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // 아이디 입력 필드
            const CustomTextField(
              label: "아이디",
            ),
            const SizedBox(height: 16),
            // 이메일 입력 필드
            const CustomTextField(
              label: "이메일",
            ),
            const SizedBox(height: 16),
            // 비밀번호 입력 필드
            const CustomTextField(
              label: "비밀번호",
              obscureText: true,
            ),
            const Spacer(), // 아래 여백 확보
            // 완료 버튼
            PrimaryButton(
              text: "완료",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ); // 완료 버튼 동작 정의
              },
              backgroundColor: const Color(0xFF0770E9), // 기존 버튼 색상
            ),
            const SizedBox(height: 60), // 하단 여백
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // 텍스트 필드 상단의 제목
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8), // 제목과 필드 간 간격
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F6F6), // 필드 배경색
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10, // 위아래 여백을 줄임 (기본값보다 작게)
              horizontal: 12, // 좌우 여백
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
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
