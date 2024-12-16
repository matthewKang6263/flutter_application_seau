import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/core/geolocator_helper.dart';
import 'package:flutter_application_seau/data/repository/address_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application_seau/data/model/address.dart';

// 주소 검색 상태를 관리하는 클래스
class AddressSearchState {
  final List<Address> searchResults;
  final Address? currentAddress;
  final bool isLoading;
  final String? error;

  AddressSearchState({
    this.searchResults = const [],
    this.currentAddress,
    this.isLoading = false,
    this.error,
  });

  // 불변성을 유지하면서 상태를 업데이트하는 메서드
  AddressSearchState copyWith({
    List<Address>? searchResults,
    Address? currentAddress,
    bool? isLoading,
    String? error,
  }) {
    return AddressSearchState(
      searchResults: searchResults ?? this.searchResults,
      currentAddress: currentAddress ?? this.currentAddress,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// 주소 검색 뷰모델 클래스
class AddressSearchViewModel extends StateNotifier<AddressSearchState> {
  AddressSearchViewModel(this._addressRepository) : super(AddressSearchState());

  final AddressRepository _addressRepository;

  // 주소 검색 메서드
  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(searchResults: [], isLoading: false, error: null);
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final results = await _addressRepository.searchAddressByName(query);
      state = state.copyWith(searchResults: results, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: '주소 검색 중 오류가 발생했습니다.', isLoading: false);
    }
  }

  // 현재 위치 기반 주소 검색 메서드
  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      Position? position = await GeolocatorHelper.getPositon();
      if (position != null) {
        final address = await _addressRepository.searchAddressByLatLng(
          position.latitude,
          position.longitude,
        );
        if (address != null) {
          state = state.copyWith(currentAddress: address, isLoading: false);
        } else {
          state = state.copyWith(error: '주소를 찾을 수 없습니다.', isLoading: false);
        }
      } else {
        state = state.copyWith(error: '위치를 가져올 수 없습니다.', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: '위치 정보 가져오기 오류: $e', isLoading: false);
    }
  }

  // 현재 주소 설정 메서드
  void setCurrentAddress(Address address) {
    state = state.copyWith(currentAddress: address);
  }
}

// AddressSearchViewModel 프로바이더
final addressSearchViewModelProvider =
    StateNotifierProvider<AddressSearchViewModel, AddressSearchState>((ref) {
  return AddressSearchViewModel(ref.watch(addressRepositoryProvider));
});

// AddressRepository 프로바이더
final addressRepositoryProvider =
    Provider<AddressRepository>((ref) => AddressRepository());
