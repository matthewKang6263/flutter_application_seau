import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends AutoDisposeNotifier<int> {
  @override
  int build() => 0; // 초기 상태는 첫 번째 탭

  void onIndexChanged(int newIndex) {
    state = newIndex; // 새 인덱스로 상태 업데이트
  }
}

final homeViewModel =
    NotifierProvider.autoDispose<HomeViewModel, int>(() => HomeViewModel());
