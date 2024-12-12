import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Page"),
      ),
      body: const Center(
        child: Text(
          "Join Page Content",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
