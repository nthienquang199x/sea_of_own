import 'dart:async';

import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/services/category_service.dart';
import 'package:app_base/core/network/services/product_service.dart';
import 'package:app_base/core/network/services/recently_service.dart';
import 'package:app_base/core/network/services/sub_category_service.dart';
import 'package:app_base/features/search/presentation/search_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit() : super(SearchState());
  final TextEditingController searchController = TextEditingController();
  final _categoryService = CategoryService();
  final _subCregoryService = SubCategoryService();
  final _productService = ProductService();
  final _recentlyViewedProductService = RecentlyService();
  Timer? _debounceTimer;

  Future<void> init() async {
    addSearchListener();
    await fetchCategories();

    fetchSubCategories();
    fetchProductsRecentlyViewed();
  }

  Future<void> fetchProducts({String? sortDirection}) async {
    try {
      showLoading();
      final products = await _productService.getAllProducts(
        page: state.page,
        perPage: state.perPage,
        sortDirection: sortDirection,
        searchKeyword: searchController.text,
      );
      emit(state.copyWith(products: products));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  // Future<void> fetchProductsRecentlyViewed() async {
  //   try {
  //     showLoading();
  //     final products = await _productService.getAllProducts(
  //       page: state.page,
  //       perPage: state.perPage,
  //       sortBy: SortBy.createdAt.name,
  //     );
  //     emit(state.copyWith(productsRecentlyViewed: products));
  //   } catch (e) {
  //     return;
  //   } finally {
  //     hideLoading();
  //   }
  // }

  Future<void> fetchCategories() async {
    try {
      showLoading();
      final categories = await _categoryService.getCategories();
      emit(state.copyWith(
          categories: categories,
          categorySelected: categories.isNotEmpty ? categories.first : null));
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchSubCategories() async {
    try {
      showLoading();
      final subCategories = await _subCregoryService.getSubCategories();
      emit(state.copyWith(
          subCategories: subCategories,
          subCategoriesCategory: subCategories
              .where((subCategory) =>
                  subCategory.category?.id == state.categorySelected?.id)
              .toList()));
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchProductsRecentlyViewed() async {
    try {
      showLoading();
      final products = await _recentlyViewedProductService.getRecentlyViewed();
      emit(state.copyWith(productsRecentlyViewed: products));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  Future<void> upsertRecentlyViewed(int productId) async {
    try {
      await _recentlyViewedProductService.upsertRecentlyViewed(productId);
      fetchProductsRecentlyViewed();
    } catch (e) {
      return;
    }
  }

  void _onSearchChanged() {
    emit(state.copyWith(
      searchText: searchController.text,
    ));
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      fetchProducts();
    });
  }

  void selectCategory(Category category) {
    final subCategories = state.subCategories
        .where((subCategory) => subCategory.category?.id == category.id)
        .toList();
    emit(state.copyWith(
        categorySelected: category, subCategoriesCategory: subCategories));
  }

  void addSearchListener() {
    searchController.addListener(_onSearchChanged);
  }

  void removeSearchListener() {
    searchController.removeListener(_onSearchChanged);
  }
}
