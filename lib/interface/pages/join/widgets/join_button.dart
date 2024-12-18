import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/global_widgets/primary_button.dart';

class JoinButton extends StatelessWidget {
  final VoidCallback onPressed;

  const JoinButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: "다음",
      onPressed: onPressed,
      backgroundColor: const Color(0xFF0770E9),
    );
  }
}
