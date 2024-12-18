import 'package:flutter/material.dart';

class AddressSearchResults extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<String> searchResults;
  final ValueChanged<String> onTap;

  const AddressSearchResults({
    Key? key,
    required this.isLoading,
    required this.error,
    required this.searchResults,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (error != null) {
      return Center(child: Text(error!));
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(searchResults[index]),
              onTap: () => onTap(searchResults[index]),
            );
          },
        ),
      );
    }
  }
}
