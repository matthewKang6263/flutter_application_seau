import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/home/home_view_model.dart';
import 'package:flutter_application_seau/interface/pages/home/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter_application_seau/interface/pages/home/widgets/home_indexed_stack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeViewModel); // 현재 인덱스 상태를 구독
    final vm = ref.read(homeViewModel.notifier); // ViewModel 접근

    return Scaffold(
      body: HomeIndexedStack(), // 탭 화면 관리
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: currentIndex, // 현재 선택된 탭의 인덱스 전달
        onTap: vm.onIndexChanged, // 탭 변경 시 상태 업데이트
      ),
    );
  }
}
