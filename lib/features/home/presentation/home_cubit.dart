import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/services/category_service.dart';
import 'package:app_base/core/network/services/product_service.dart';
import 'package:app_base/core/network/services/recently_service.dart';
import 'package:app_base/core/network/services/space_service.dart';
import 'package:app_base/features/home/presentation/home_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());

  final _categoryService = CategoryService();
  final _productService = ProductService();
  final _spaceService = SpaceService();
  final _recentlyViewedProductService = RecentlyService();
  final TextEditingController searchController = TextEditingController();

  Future<void> fetchCategories() async {
    try {
      showLoading();
      final categories = await _categoryService.getCategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchProducts() async {
    try {
      showLoading();
      final products = await _productService.getAllProducts(
        page: state.page,
        perPage: state.perPage,
        searchKeyword:
            searchController.text.isNotEmpty ? searchController.text : null,
      );
      emit(state.copyWith(products: products));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchCurratedList() async {
    try {
      showLoading();
      final products = await _productService.getCurratedList(
        page: state.page,
        perPage: state.perPage,
      );
      emit(state.copyWith(curratedList: products));
    } catch (e) {
      return;
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchSpaces() async {
    try {
      showLoading();
      final spaces = await _spaceService.getSpaces();
      emit(state.copyWith(spaces: spaces));
    } catch (e) {
      print('Error fetching spaces: $e');
    } finally {
      hideLoading();
    }
  }

  Future<void> upsertRecentlyViewed(int productId) async {
    try {
      await _recentlyViewedProductService.upsertRecentlyViewed(productId);
    } catch (e) {
      return;
    }
  }
}
