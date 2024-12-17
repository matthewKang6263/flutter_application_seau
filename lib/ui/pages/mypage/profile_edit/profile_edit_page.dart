import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/mypage/address_edit/address_edit_page.dart';
import 'package:flutter_application_seau/ui/pages/mypage/profile_edit/profile_edit_view_model.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? currentLocation;
  String? userId;

  @override
  void initState() {
    super.initState();

    // 초기 데이터 설정 (가입한 유저 데이터 불러오기)
    final user = ref.read(profileEditViewModelProvider);
    userId = user?.id; // userId 저장
    nicknameController.text = user?.nickname ?? '';
    emailController.text = user?.email ?? '';
    currentLocation = user?.location;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileEditViewModelProvider);
    final profileEditViewModel =
        ref.watch(profileEditViewModelProvider.notifier);

    // 상태가 null이면 로딩 상태를 표시
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // 상태가 있으면 컨트롤러에 데이터 설정
    nicknameController.text = user.nickname;
    emailController.text = user.email;
    currentLocation = user.location;

    return Scaffold(
      backgroundColor: Colors.white, // 전체 화면 흰색 배경
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 제거
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // 1. 프로필 이미지
            Center(
              child: UserProfileImage(
                dimension: 100,
                imgUrl: '', // 이미지 URL이 없으면 기본 아이콘 표시
                onEdit: () {
                  // 프로필 이미지 수정 로직
                },
              ),
            ),
            const SizedBox(height: 40),
            // 2. 위치 입력 필드
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddressEditPage()), // [가입-위치설정]페이지로 이동
                );
              },
              child: IgnorePointer(
                // 이벤트를 child가 가져가지 않도록 방지
                ignoring: true,
                child: CustomTextField(
                  label: '위치',
                  hintText: currentLocation,
                  prefixIcon: Icons.search,
                  readOnly: true,
                  textcontroller: TextEditingController(text: currentLocation),
                ),
              ),
            ),
            const SizedBox(height: 25),
            // 3. 닉네임 입력 필드
            CustomTextField(
              label: '닉네임',
              hintText: 'akeetuitui',
              textcontroller: nicknameController,
            ),
            const SizedBox(height: 25),
            // 4. 이메일 입력 필드
            CustomTextField(
              label: '이메일',
              hintText: 'divinglover@gmail.com',
              readOnly: true,
              textcontroller: emailController,
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(), // 아래 여백 확보
            // 수정하기 버튼
            PrimaryButton(
              text: '수정하기',
              onPressed: () async {
                try {
                  // 닉네임 또는 위치가 변경되었는지 확인
                  final isNicknameChanged =
                      nicknameController.text != user.nickname;
                  final isLocationChanged = currentLocation != user.location;

                  if (!isNicknameChanged && !isLocationChanged) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('수정할 내용이 없습니다.')),
                    );
                    return; // 변경사항이 없으므로 함수 종료
                  }

                  // 변경사항이 있으면 Firebase에 업데이트
                  await profileEditViewModel.updateUserProfile(
                    userId: userId!,
                    nickname: isNicknameChanged ? nicknameController.text : null,
                    location: isLocationChanged ? currentLocation : null,
                  );
                  // 업데이트 성공 시 이전 페이지로 돌아감
                  Navigator.pop(context, true); // 수정 완료 후 true 값 반환
                } catch (e) {
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
    );
  }
}

// CustomTextField 위젯
class CustomTextField extends StatelessWidget {
  final TextEditingController textcontroller;
  final String label;
  final String? hintText;
  final bool obscureText; // 비밀번호 입력 여부
  final bool readOnly; // 입력 필드를 읽기 전용으로 (true시 수정 불가, 이메일에 적용)
  final IconData? prefixIcon; // 입력 필드 왼쪽에 표시할 아이콘
  final TextStyle? style;

  const CustomTextField({
    super.key,
    required this.textcontroller,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // 텍스트필드 제목 & 텍스트필드 칼럼
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // 텍스트필드 제목
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: textcontroller,
          obscureText: obscureText,
          readOnly: readOnly,
          style: style,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF6F6F6), // 필드 배경색
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.grey)
                : null, // 아이콘 색
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
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
