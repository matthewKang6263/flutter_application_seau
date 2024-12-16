import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/certification/certification_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/ui/pages/address_search/address_search_view_model.dart';

class AddressSearchPage extends ConsumerWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addressSearchViewModelProvider.notifier);
    final state = ref.watch(addressSearchViewModelProvider);

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
                  TextField(
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
                    ),
                    onChanged: (value) => viewModel.searchLocation(value),
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
                    child: ListView.builder(
                      itemCount: state.searchResults.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            state.searchResults[index],
                            style: const TextStyle(fontSize: 16),
                          ),
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
              text: "다음",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CertificationPage(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF0770E9),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
