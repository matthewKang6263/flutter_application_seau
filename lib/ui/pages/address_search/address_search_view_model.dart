import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/core/geolocator_helper.dart';
import 'package:flutter_application_seau/data/repository/vworld_repository.dart';
import 'package:geolocator/geolocator.dart';

// AddressSearchViewModel을 StateNotifier로 변경
class AddressSearchViewModel extends StateNotifier<AddressSearchState> {
  AddressSearchViewModel(this._vWorldRepository) : super(AddressSearchState());

  final VWorldRepository _vWorldRepository;

  Future<void> searchLocation(String query) async {
    final results = await _vWorldRepository.findByName(query);
    state = state.copyWith(searchResults: results);
  }

  Future<void> getCurrentLocation() async {
    try {
      Position? position = await GeolocatorHelper.getPositon();
      if (position != null) {
        List<String> addresses = await _vWorldRepository.findByLatLng(
          lat: position.latitude,
          lng: position.longitude,
        );
        if (addresses.isNotEmpty) {
          state = state.copyWith(currentAddress: addresses.first);
        }
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }
}

// 상태 클래스 정의
class AddressSearchState {
  final List<String> searchResults;
  final String? currentAddress;

  AddressSearchState({
    this.searchResults = const [],
    this.currentAddress,
  });

  AddressSearchState copyWith({
    List<String>? searchResults,
    String? currentAddress,
  }) {
    return AddressSearchState(
      searchResults: searchResults ?? this.searchResults,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }
}

// Provider 정의
final addressSearchViewModelProvider =
    StateNotifierProvider<AddressSearchViewModel, AddressSearchState>((ref) {
  return AddressSearchViewModel(VWorldRepository());
});
