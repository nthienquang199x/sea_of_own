class SavedListState {
  final String searchText;

  SavedListState({this.searchText = ''});

  SavedListState copyWith({String? searchText}) {
    return SavedListState(
      searchText: searchText ?? this.searchText,
    );
  }
}
