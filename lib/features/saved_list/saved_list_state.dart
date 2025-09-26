import 'package:app_base/core/network/models/collection.dart';
import 'package:app_base/core/network/models/product.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/products/models/sort_direction.dart';

class SavedListState {
  final String searchText;
  final List<Collection> savedCollections;
  final List<Product> products;
  final SortDirection sortDirection;
  final SortBy sortBy;
  final bool isRename;

  SavedListState(
      {this.searchText = '',
      this.savedCollections = const [],
      this.sortDirection = SortDirection.asc,
      this.sortBy = SortBy.createdAt,
      this.isRename = false,
      this.products = const []});

  SavedListState copyWith(
      {String? searchText,
      List<Collection>? savedCollections,
      SortDirection? sortDirection,
      SortBy? sortBy,
      bool? isRename,
      List<Product>? products}) {
    return SavedListState(
      searchText: searchText ?? this.searchText,
      savedCollections: savedCollections ?? this.savedCollections,
      sortBy: sortBy ?? this.sortBy,
      sortDirection: sortDirection ?? this.sortDirection,
      products: products ?? this.products,
      isRename: isRename ?? this.isRename,
    );
  }
}
