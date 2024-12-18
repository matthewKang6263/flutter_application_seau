import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/global_widgets/email_text_form_field.dart';
import 'package:flutter_application_seau/interface/global_widgets/nickname_text_form_field.dart';
import 'package:flutter_application_seau/interface/global_widgets/pw_text_form_field.dart';
import 'package:flutter_application_seau/interface/pages/address_search/address_search_page.dart';
import 'package:flutter_application_seau/interface/pages/join/join_view_model.dart';
import 'package:flutter_application_seau/interface/pages/join/widgets/join_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_seau/core/validator_util.dart';

class JoinForm extends ConsumerStatefulWidget {
  const JoinForm({super.key});

  @override
  ConsumerState<JoinForm> createState() => _JoinFormState();
}

class _JoinFormState extends ConsumerState<JoinForm> {
  // 컨트롤러 선언
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // 폼 키 선언
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 컨트롤러 해제
    nicknameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final joinViewModel = ref.watch(joinViewModelProvider.notifier);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("계정을 생성하세요",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            NicknameTextFormField(
              controller: nicknameController,
              validator: ValidatorUtil.validateNickname,
            ),
            const SizedBox(height: 16),
            EmailTextFormField(
              controller: emailController,
              validator: ValidatorUtil.validateEmail,
            ),
            const SizedBox(height: 16),
            PwTextFormField(
              controller: passwordController,
              validator: ValidatorUtil.validatePassword,
            ),
            const SizedBox(height: 40),
            JoinButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await joinViewModel.initiateSignUp(
                      emailController.text,
                      passwordController.text,
                      nicknameController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressSearchPage()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
