import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/plugins/contents/search_story_notifier.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController _searchController;

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
  Widget build(BuildContext context) => TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _clearSearch(context),
                )
              : null,
        ),
        textInputAction: TextInputAction.search,
        onChanged: _searchStoriesByTitle,
      );

  void _searchStoriesByTitle(String value) {
    context.read<SearchStoryNotifier>().searchStoriesByTitle(value);
  }

  void _clearSearch(BuildContext context) {
    if (_isNotEmpty) {
      _searchController.clear();
      context.read<SearchStoryNotifier>().searchStoriesByTitle('');
    }
  }

  bool get _isNotEmpty => _searchController.text.isNotEmpty;
}
