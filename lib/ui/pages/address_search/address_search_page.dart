import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/certification/certification_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/ui/pages/address_search/address_search_view_model.dart';
import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';

// StatefulWidget으로 변경하여 controller 관리
class AddressSearchPage extends ConsumerStatefulWidget {
  const AddressSearchPage({super.key});

  @override
  ConsumerState<AddressSearchPage> createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends ConsumerState<AddressSearchPage> {
  // TextField controller 선언
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(addressSearchViewModelProvider.notifier);
    final state = ref.watch(addressSearchViewModelProvider);
    final joinViewModel = ref.watch(joinViewModelProvider.notifier);

    // state.currentAddress가 변경될 때 TextField 업데이트
    if (state.currentAddress != null &&
        state.currentAddress != _searchController.text) {
      _searchController.text = state.currentAddress!;
    }

    return Scaffold(
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
          // 프로그레스 바
          Stack(
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
          ),
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
                  // TextField 수정
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => viewModel.searchLocation(value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: "위치를 입력해주세요",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                      // 검색어 지우기 버튼 추가
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                viewModel.searchLocation('');
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 현재 위치로 찾기 버튼
                  ElevatedButton.icon(
                    onPressed: () => viewModel.getCurrentLocation(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14C2BF),
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    icon: const Icon(Icons.my_location, color: Colors.white),
                    label: const Text(
                      "현재 위치로 찾기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 검색 결과 리스트
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state.error != null
                            ? Center(child: Text(state.error!))
                            : ListView.builder(
                                itemCount: state.searchResults.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(state.searchResults[index]),
                                    onTap: () {
                                      _searchController.text =
                                          state.searchResults[index];
                                      viewModel.setCurrentAddress(
                                          state.searchResults[index]);
                                    },
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
          // 다음 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: PrimaryButton(
              text: "다음",
              onPressed: state.currentAddress != null
                  ? () {
                      joinViewModel.setLocation(state.currentAddress!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CertificationPage()),
                      );
                    }
                  : null,
              backgroundColor: const Color(0xFF0770E9),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
