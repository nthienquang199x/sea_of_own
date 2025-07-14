import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/features/saved_list/saved_list_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedListCubit extends BaseCubit<SavedListState> {
  SavedListCubit() : super(SavedListState());
  final TextEditingController searchController = TextEditingController();

  void init() {
    addSearchListener();
  }

  void _onSearchChanged() {
    emit(state.copyWith(
      searchText: searchController.text,
    ));
  }

  void removeSearchListener() {
    searchController.removeListener(_onSearchChanged);
  }

  void addSearchListener() {
    searchController.addListener(_onSearchChanged);
  }
}
