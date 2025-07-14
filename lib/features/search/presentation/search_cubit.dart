import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/features/search/presentation/search_state.dart';
import 'package:app_base/models/category.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit() : super(SearchState());
  final TextEditingController searchController = TextEditingController();

  void init() {
    addSearchListener();
    emit(state.copyWith(
      categories: categories,
    ));
  }

  void _onSearchChanged() {
    emit(state.copyWith(
      searchText: searchController.text,
    ));
  }

  void selectCategory(Category category) {
    emit(state.copyWith(categorySelected: category));
  }

  void addSearchListener() {
    searchController.addListener(_onSearchChanged);
  }

  void removeSearchListener() {
    searchController.removeListener(_onSearchChanged);
  }
}

final List<Category> categories = [
  Category(name: 'Tech & Audio'),
  Category(name: 'Tools'),
  Category(name: 'Work'),
  Category(name: 'Home'),
  Category(name: 'Personal'),
  Category(name: 'Craft'),
];
