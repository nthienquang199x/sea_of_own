import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/models/collection.dart';
import 'package:app_base/core/network/services/collection_service.dart';
import 'package:app_base/core/network/services/product_collection_service.dart';
import 'package:app_base/core/network/services/product_service.dart';
import 'package:app_base/features/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductCubit extends BaseCubit<ProductState> {
  ProductCubit() : super(ProductState());
  final _collectionService = CollectionService();
  final _productService = ProductService();
  final _productCollectionService = ProductCollectionService();
  final createNameController = TextEditingController();

  void init(int productId) {
    fetchProductById(productId);
    fetchCollections();
  }

  Future<void> fetchProductById(int productId) async {
    try {
      showLoading();
      final product = await _productService.getProductById(productId);
      emit(state.copyWith(product: product));
    } catch (e) {
      hideLoading();
      emit(state.copyWith(product: null));
    } finally {
      hideLoading();
    }
  }

  Future<void> fetchCollections() async {
    try {
      showLoading();
      final collections = await _collectionService.getCollections();
      emit(state.copyWith(
        collections: collections,
      ));
    } finally {
      hideLoading();
    }
  }

  Future<void> createCollection() async {
    try {
      showLoading();
      final response = await _collectionService.createCollection(
          createNameController.text, 'http://example.com/image.jpg');
      createNameController.clear();
      if (response?.id != null) {
        addProductToCollections([response!.id], state.product!.id);
      }
      fetchCollections();
    } finally {
      hideLoading();
    }
  }

  Future<void> addProductToCollections(
      List<int> collectionIds, int productId) async {
    try {
      showLoading();
      final response = await _productService.addProductToCollections(
          productId, collectionIds);
      fetchProductById(productId);
      showToast(response);
    } catch (e) {
      showToast('Failed to add product to collection');
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteProductFromCollections(
      int collectionId, int productId) async {
    try {
      showLoading();
      final response = await _productCollectionService
          .deleteProductFromCollection(productId, collectionId);
      showToast(response);
      fetchProductById(productId);
    } catch (e) {
      showToast('Failed to remove product from collection');
    } finally {
      hideLoading();
    }
  }

  Future<void> chooseCollections(Collection collection) async {
    emit(state.copyWith(
        selectedCollections: state.selectedCollections.contains(collection)
            ? state.selectedCollections.where((c) => c != collection).toList()
            : [...state.selectedCollections, collection]));
  }

  Future<void> likeProduct(int productId) async {
    try {
      showLoading();
      await _productService.likeProduct(productId);
      // showToast(response);
      fetchProductById(productId);
    } catch (e) {
      showToast('Failed to like product');
    } finally {
      hideLoading();
    }
  }

  Future<void> dislikeProduct(int productId) async {
    try {
      showLoading();
      await _productService.dislikeProduct(productId);
      fetchProductById(productId);
      // showToast(response);
    } catch (e) {
      showToast('Failed to dislike product');
    } finally {
      hideLoading();
    }
  }
}
