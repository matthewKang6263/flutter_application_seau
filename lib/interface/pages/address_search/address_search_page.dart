import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/address_search/address_search_view_model.dart';
import 'package:flutter_application_seau/interface/pages/certification/certification_page.dart';
import 'package:flutter_application_seau/interface/pages/join/join_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/address_search_app_bar.dart';
import 'widgets/address_search_progress_bar.dart';
import 'widgets/address_search_input.dart';
import 'widgets/current_location_button.dart';
import 'widgets/address_search_results.dart';
import 'widgets/next_button.dart';

class AddressSearchPage extends ConsumerWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HookBuilder(builder: (context) {
      // ViewModel과 State를 가져옵니다.
      final viewModel = ref.watch(addressSearchViewModelProvider.notifier);
      final state = ref.watch(addressSearchViewModelProvider);
      final joinViewModel = ref.watch(joinViewModelProvider.notifier);

      // TextField 컨트롤러를 생성합니다.
      final searchController = useTextEditingController();

      // 상태가 변경될 때마다 실행되는 useEffect 훅
      useEffect(() {
        if (state.currentAddress != null) {
          searchController.text = state.currentAddress!;
        }
        return null;
      }, [state.currentAddress]);

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AddressSearchAppBar(),
        body: Column(
          children: [
            const AddressSearchProgressBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "활동지역을 선택해주세요",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AddressSearchInput(
                      controller: searchController,
                      onChanged: (value) {
                        viewModel.updateSearchText(value);
                        viewModel.searchLocation(value);
                      },
                      onClear: () {
                        searchController.clear();
                        viewModel.updateSearchText('');
                        viewModel.searchLocation('');
                      },
                    ),
                    const SizedBox(height: 16),
                    CurrentLocationButton(
                      onPressed: () => viewModel.getCurrentLocation(),
                    ),
                    const SizedBox(height: 20),
                    AddressSearchResults(
                      isLoading: state.isLoading,
                      error: state.error,
                      searchResults: state.searchResults,
                      onTap: (address) {
                        searchController.text = address;
                        viewModel.setCurrentAddress(address);
                      },
                    ),
                  ],
                ),
              ),
            ),
            NextButton(
              isEnabled: state.currentAddress != null,
              onPressed: () {
                joinViewModel.setLocation(state.currentAddress!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CertificationPage()),
                );
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      );
    });
  }
}
