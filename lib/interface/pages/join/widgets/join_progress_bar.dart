import 'package:flutter/material.dart';

class JoinProgressBar extends StatelessWidget {
  const JoinProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 4, color: const Color(0xFFDDDDDD)),
        FractionallySizedBox(
          widthFactor: 0.33,
          child: Container(height: 4, color: const Color(0xFF0770E9)),
        ),
      ],
    );
  }
}
