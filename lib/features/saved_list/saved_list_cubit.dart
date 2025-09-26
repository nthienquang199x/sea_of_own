import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/services/collection_service.dart';
import 'package:app_base/core/network/services/product_collection_service.dart';
import 'package:app_base/core/network/services/recently_service.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/products/models/sort_direction.dart';
import 'package:app_base/features/saved_list/saved_list_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedListCubit extends BaseCubit<SavedListState> {
  SavedListCubit() : super(SavedListState());
  final TextEditingController searchController = TextEditingController();
  final TextEditingController createNameController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final _collectionService = CollectionService();
  final _productCollectionService = ProductCollectionService();
  final _recentlyViewedProductService = RecentlyService();

  void init() {
    addSearchListener();
    fetchSavedCollections();
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

  Future<void> fetchSavedCollections() async {
    try {
      showLoading();
      final collections = await _collectionService.getCollections();
      emit(state.copyWith(savedCollections: collections));
    } finally {
      hideLoading();
    }
  }

  Future<void> createCollection() async {
    try {
      showLoading();
      await _collectionService.createCollection(
          createNameController.text, 'http://example.com/image.jpg');
      createNameController.clear();
      fetchSavedCollections();
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteCollection(int collectionId) async {
    try {
      showLoading();
      await _collectionService.deleteCollection(collectionId);
    } finally {
      hideLoading();
    }
  }

  Future<bool> updateCollection(int collectionId, String name) async {
    try {
      showLoading();
      await _collectionService.updateCollection(collectionId, name);
      return true;
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

  Future<void> getAllProductsInCollection(int collectionId) async {
    try {
      showLoading();
      final products = await _productCollectionService
          .getAllProductsInCollection(collectionId);
      emit(state.copyWith(products: products));
    } finally {
      hideLoading();
    }
  }

  void updateSortDirection(SortDirection newDirection) {
    emit(state.copyWith(sortDirection: newDirection));
  }

  void updateSortBy(SortBy newSortBy) {
    emit(state.copyWith(sortBy: newSortBy));
    // getAllProductsInCollection(collectionId);
  }

  void toggleRename() {
    emit(state.copyWith(isRename: true));
  }
}
