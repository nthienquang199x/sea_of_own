import 'package:app_base/models/category.dart';

class SearchState {
  final List<Category> categories;
  final Category? categorySelected;

  SearchState({this.categories = const [], this.categorySelected});

  SearchState copyWith(
      {List<Category>? categories, Category? categorySelected}) {
    return SearchState(
      categories: categories ?? this.categories,
      categorySelected: categorySelected ?? this.categorySelected,
    );
  }
}
