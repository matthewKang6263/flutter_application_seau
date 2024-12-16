import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/core/geolocator_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application_seau/data/repository/vworld_repository.dart';

// 주소 검색 상태 클래스
class AddressSearchState {
  final List<String> searchResults;
  final String? currentAddress;
  final bool isLoading;
  final String? error;

  AddressSearchState({
    this.searchResults = const [],
    this.currentAddress,
    this.isLoading = false,
    this.error,
  });

  // 상태 복사 메서드
  AddressSearchState copyWith({
    List<String>? searchResults,
    String? currentAddress,
    bool? isLoading,
    String? error,
  }) {
    return AddressSearchState(
      searchResults: searchResults ?? this.searchResults,
      currentAddress: currentAddress ?? this.currentAddress,
      isLoading: isLoading ?? this.isLoading,
      error: error, // error가 null이면 error 상태 초기화
    );
  }
}

// 주소 검색 뷰모델
class AddressSearchViewModel extends StateNotifier<AddressSearchState> {
  AddressSearchViewModel(this._vWorldRepository) : super(AddressSearchState());

  final VWorldRepository _vWorldRepository;

  // 주소 검색
  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(searchResults: [], isLoading: false, error: null);
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    // 0.5초 딜레이 추가
    await Future.delayed(Duration(milliseconds: 500));

    try {
      final results = await _vWorldRepository.findByName(query);
      if (results.isEmpty) {
        state = state.copyWith(
          searchResults: [],
          isLoading: false,
          error: '검색 결과가 없습니다.',
        );
      } else {
        state = state.copyWith(
          searchResults: results,
          isLoading: false,
          error: null,
        );
      }
    } catch (e) {
      print('주소 검색 오류: $e');
      state = state.copyWith(
        error: '주소 검색 중 오류가 발생했습니다.',
        isLoading: false,
      );
    }
  }

  // 현재 위치 기반 주소 검색
  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          isLoading: false,
          error: '위치 서비스가 비활성화되어 있습니다.',
        );
        return;
      }

      // 위치 정보 가져오기
      Position? position = await GeolocatorHelper.getPosition();
      if (position != null) {
        final addresses = await _vWorldRepository.findByLatLng(
          lat: position.latitude,
          lng: position.longitude,
        );
        if (addresses.isNotEmpty) {
          state = state.copyWith(
            currentAddress: addresses.first,
            isLoading: false,
            error: null,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            error: '현재 위치의 주소를 찾을 수 없습니다.',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: '위치 권한이 필요합니다.',
        );
      }
    } catch (e) {
      print('위치 정보 오류: $e');
      state = state.copyWith(
        isLoading: false,
        error: '위치 정보를 가져오는 중 오류가 발생했습니다.',
      );
    }
  }

  // 현재 주소 설정
  void setCurrentAddress(String address) {
    state = state.copyWith(currentAddress: address);
  }
}

// 프로바이더 정의
final addressSearchViewModelProvider =
    StateNotifierProvider<AddressSearchViewModel, AddressSearchState>((ref) {
  return AddressSearchViewModel(VWorldRepository());
});
