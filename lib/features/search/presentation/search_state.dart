import 'package:app_base/models/category.dart';

class SearchState {
  final List<Category> categories;
  final Category? categorySelected;
  final String searchText;

  SearchState({
    this.categories = const [],
    this.categorySelected,
    this.searchText = '',
  });

  SearchState copyWith({
    List<Category>? categories,
    Category? categorySelected,
    String? searchText,
  }) {
    return SearchState(
      categories: categories ?? this.categories,
      categorySelected: categorySelected ?? this.categorySelected,
      searchText: searchText ?? this.searchText,
    );
  }
}
