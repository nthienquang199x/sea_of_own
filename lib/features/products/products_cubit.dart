import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/core/network/services/product_service.dart';
import 'package:app_base/core/network/services/sub_category_service.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/products/models/sort_direction.dart';
import 'package:app_base/features/products/products_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends BaseCubit<ProductsState> {
  ProductsCubit() : super(ProductsState());

  final _subCregoryService = SubCategoryService();
  final _productService = ProductService();

  void init(int categoryId) {
    fetchSubCategories(categoryId);
    fetchProducts(categoryId: categoryId);
  }

  void onChangeSortDirection(int categoryId) {
    final newDirection = state.sortDirection == SortDirection.asc
        ? SortDirection.desc
        : SortDirection.asc;
    fetchProducts(categoryId: categoryId, sortDirection: newDirection.name);
    emit(state.copyWith(sortDirection: newDirection));
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
      {required int categoryId, String? sortDirection}) async {
    try {
      showLoading();
      final products = await _productService.getAllProducts(
        page: state.page,
        perPage: state.perPage,
        sortDirection: sortDirection,
        categoryIds: [
          categoryId,
          ...state.selectedSubCategories.map((e) => e.id)
        ],
        onSale: state.onSale,
        minPrice: state.minPrice,
        maxPrice: state.priceRange,
        sortBy: state.recentlyAdded ? SortBy.createdAt.params : null,
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
}
