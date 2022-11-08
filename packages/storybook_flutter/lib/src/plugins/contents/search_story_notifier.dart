import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/story.dart';

class SearchStoryNotifier extends ChangeNotifier {
  SearchStoryNotifier({required List<Story> stories})
      : _stories = stories.toList(),
        _filteredStories = stories.toList();

  String _searchTerm = '';
  final List<Story> _stories;
  List<Story> _filteredStories;

  List<Story> get searchedStories => UnmodifiableListView(_filteredStories);

  void searchStoriesByTitle(String value) {
    if (_searchTerm == value) return;
    _searchTerm = value;
    if (_searchTerm.isEmpty) {
      _filteredStories = _stories;
    } else {
      _filteredStories = _stories
          .where((story) =>
              story.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
