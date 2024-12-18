import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/global_widgets/primary_button.dart';

class NextButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const NextButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: PrimaryButton(
        text: "다음",
        onPressed: isEnabled ? onPressed : null,
        backgroundColor: const Color(0xFF0770E9),
      ),
    );
  }
}
