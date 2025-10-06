import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/core/network/services/product_service.dart';
import 'package:app_base/core/network/services/recently_service.dart';
import 'package:app_base/core/network/services/sub_category_service.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/products/models/sort_direction.dart';
import 'package:app_base/features/products/models/sort_option.dart';
import 'package:app_base/features/products/products_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends BaseCubit<ProductsState> {
  ProductsCubit() : super(ProductsState());

  final _subCregoryService = SubCategoryService();
  final _productService = ProductService();
  final _recentlyViewedProductService = RecentlyService();

  void init(int? categoryId, int? subCategoryId) {
    if (categoryId != null) {
      fetchSubCategories(categoryId);
    }
    fetchProducts(categoryId: categoryId, subCategoryId: subCategoryId);
  }

  void onChangeSortDirection(int categoryId, int? subCategoryId) {
    final newDirection = state.sortDirection == SortDirection.asc
        ? SortDirection.desc
        : SortDirection.asc;
    emit(state.copyWith(sortDirection: newDirection));
  }

  void onChangeSortBy(SortBy newSortBy) {
    emit(state.copyWith(sortBy: newSortBy));
  }

  void onChangeSortDirectionOnly(SortDirection newSortDirection) {
    emit(state.copyWith(sortDirection: newSortDirection));
  }

  void onChangeSortOption(SortOption sortOption) {
    emit(state.copyWith(
      selectedSortOption: sortOption,
      sortBy: sortOption.sortBy,
      sortDirection: sortOption.sortDirection,
    ));
  }

  void onChangePage(int newPage) {
    emit(state.copyWith(page: newPage));
  }

  void onChangePerPage(int newPerPage) {
    emit(state.copyWith(perPage: newPerPage));
  }

  void onResetFilters() {
    emit(state.copyWith(
      sortDirection: SortDirection.asc,
      sortBy: SortBy.createdAt,
      page: 1,
      perPage: 10,
      selectedSubCategories: [],
      onSale: true,
      priceRange: 1000,
    ));
  }

  Future<void> fetchSubCategories(int categoryId) async {
    try {
      showLoading();
      final subCategories = await _subCregoryService.getSubCategories();
      emit(state.copyWith(
          subCategories: subCategories
              .where((subCategory) => subCategory.category?.id == categoryId)
              .toList()));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchProducts(
      {int? categoryId, String? sortDirection, int? subCategoryId}) async {
    try {
      showLoading();
      final products = await _productService.getAllProducts(
        page: state.page,
        perPage: state.perPage,
        sortDirection: sortDirection,
        categoryIds: categoryId != null ? [categoryId] : null,
        subCategoryIds: subCategoryId != null
            ? [subCategoryId, ...state.selectedSubCategories.map((e) => e.id)]
            : state.selectedSubCategories.map((e) => e.id).toList(),
        onSale: state.onSale,
        minPrice: state.minPrice,
        maxPrice: state.priceRange,
        sortBy:
            state.recentlyAdded ? SortBy.createdAt.params : state.sortBy.params,
      );
      emit(state.copyWith(products: products));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  void selectSubCategory(SubCategory subCategory) {
    emit(state.copyWith(
        selectedSubCategories: state.selectedSubCategories.contains(subCategory)
            ? state.selectedSubCategories
                .where((c) => c != subCategory)
                .toList()
            : [...state.selectedSubCategories, subCategory]));
  }

  void toggleOnSale() {
    emit(state.copyWith(onSale: !state.onSale));
  }

  void setPriceRange(double value) {
    emit(state.copyWith(priceRange: value));
  }

  void toggleRecentlyAdded() {
    emit(state.copyWith(recentlyAdded: !state.recentlyAdded));
  }

  void toogleViewAll() {
    emit(state.copyWith(selectedSubCategories: []));
  }

  Future<void> upsertRecentlyViewed(int productId) async {
    try {
      await _recentlyViewedProductService.upsertRecentlyViewed(productId);
    } catch (e) {
      return;
    }
  }
}
