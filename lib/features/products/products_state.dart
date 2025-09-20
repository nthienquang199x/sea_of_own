import 'package:app_base/app/app/app_state.dart';
import 'package:app_base/core/network/models/product.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/products/models/sort_direction.dart';
import 'package:app_base/features/products/models/sort_option.dart';

class ProductsState {
  final PageStatus pageStatus;
  final List<SubCategory> subCategories;
  final List<Product> products;
  final List<SubCategory> selectedSubCategories;
  final int page;
  final int perPage;
  final SortDirection sortDirection;
  final SortBy sortBy;
  final bool onSale;
  final double minPrice;
  final double maxPrice;
  final double priceRange;
  final bool recentlyAdded;
  final SortOption selectedSortOption;

  ProductsState({
    this.pageStatus = PageStatus.idle,
    this.subCategories = const [],
    this.products = const [],
    this.selectedSubCategories = const [],
    this.page = 1,
    this.perPage = 10,
    this.sortDirection = SortDirection.asc,
    this.sortBy = SortBy.createdAt,
    this.onSale = true,
    this.minPrice = 0,
    this.maxPrice = 1000,
    this.priceRange = 1000,
    this.recentlyAdded = false,
    this.selectedSortOption = SortOption.newlyAdded,
  });

  ProductsState copyWith({
    PageStatus? pageStatus,
    List<SubCategory>? subCategories,
    List<Product>? products,
    List<SubCategory>? selectedSubCategories,
    int? page,
    int? perPage,
    SortDirection? sortDirection,
    SortBy? sortBy,
    bool? onSale,
    double? minPrice,
    double? maxPrice,
    double? priceRange,
    bool? recentlyAdded,
    SortOption? selectedSortOption,
  }) {
    return ProductsState(
      pageStatus: pageStatus ?? this.pageStatus,
      subCategories: subCategories ?? this.subCategories,
      selectedSubCategories:
          selectedSubCategories ?? this.selectedSubCategories,
      products: products ?? this.products,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      sortDirection: sortDirection ?? this.sortDirection,
      sortBy: sortBy ?? this.sortBy,
      onSale: onSale ?? this.onSale,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      priceRange: priceRange ?? this.priceRange,
      recentlyAdded: recentlyAdded ?? this.recentlyAdded,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
    );
  }
}
