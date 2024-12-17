import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/ui/pages/address_search/address_search_view_model.dart';

class AddressEditPage extends ConsumerStatefulWidget {
  final String userId;

  const AddressEditPage({super.key, required this.userId});

  @override
  ConsumerState<AddressEditPage> createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends ConsumerState<AddressEditPage> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: PrimaryButton(
              text: "완료",
              onPressed: state.currentAddress != null
                  ? () {
                      // 수정된 주소만 반환
                      Navigator.pop(context, state.currentAddress);
                    }
                  : null,
              backgroundColor: const Color(0xFF0770E9),
            ),
          ),
        ],
      ),
    );
  }
}
