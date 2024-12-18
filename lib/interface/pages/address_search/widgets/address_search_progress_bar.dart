import 'package:flutter/material.dart';

class AddressSearchProgressBar extends StatelessWidget {
  const AddressSearchProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 4,
          color: const Color(0xFFDDDDDD),
        ),
        FractionallySizedBox(
          widthFactor: 0.66,
          child: Container(
            height: 4,
            color: const Color(0xFF0770E9),
          ),
        ),
      ],
    );
  }
}
