import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/join/widgets/join_form.dart';
import 'package:flutter_application_seau/interface/pages/join/widgets/join_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GestureDetector를 사용하여 화면의 빈 공간을 탭하면 키보드가 닫힘
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            const JoinProgressBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    JoinForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
