import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/models/product.dart';
import 'package:app_base/core/network/models/recently_product.dart';
import 'package:app_base/core/network/models/sub_category.dart';

class SearchState {
  final List<Category> categories;
  final List<SubCategory> subCategories;
  final List<SubCategory> subCategoriesCategory;
  final List<Product> products;
  final List<RecentlyProduct> productsRecentlyViewed;
  final Category? categorySelected;
  final String searchText;
  final int page;
  final int perPage;

  SearchState({
    this.categories = const [],
    this.subCategories = const [],
    this.subCategoriesCategory = const [],
    this.products = const [],
    this.productsRecentlyViewed = const [],
    this.categorySelected,
    this.searchText = '',
    this.page = 1,
    this.perPage = 10,
  });

  SearchState copyWith({
    List<Category>? categories,
    List<SubCategory>? subCategories,
    List<SubCategory>? subCategoriesCategory,
    List<Product>? products,
    List<RecentlyProduct>? productsRecentlyViewed,
    Category? categorySelected,
    String? searchText,
    int? page,
    int? perPage,
  }) {
    return SearchState(
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      subCategoriesCategory:
          subCategoriesCategory ?? this.subCategoriesCategory,
      products: products ?? this.products,
      productsRecentlyViewed:
          productsRecentlyViewed ?? this.productsRecentlyViewed,
      categorySelected: categorySelected ?? this.categorySelected,
      searchText: searchText ?? this.searchText,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }
}
