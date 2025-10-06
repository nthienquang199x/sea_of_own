import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/product.dart';

class ProductService {
  final _api = BaseApiService();

  Future<List<Product>> getAllProducts({
    required int page,
    required int perPage,
    String? searchKeyword,
    String? sortBy,
    String? sortDirection,
    bool? onSale,
    num? minPrice,
    num? maxPrice,
    List<int>? categoryIds,
    List<int>? subCategoryIds,
    List<int>? spaceIds,
  }) async {
    try {
      final response = await _api.get(
        '/v1/products',
        queryParams: {
          'page': page,
          'perPage': perPage,
          if (searchKeyword != null) 'searchKeyword': searchKeyword,
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDirection != null) 'sortDirection': sortDirection,
          if (onSale != null) 'onSale': onSale,
          if (minPrice != null) 'minPrice': minPrice,
          if (maxPrice != null) 'maxPrice': maxPrice,
          if (categoryIds != null && categoryIds.isNotEmpty)
            'categoryIds': categoryIds.join(','),
          if (subCategoryIds != null && subCategoryIds.isNotEmpty)
            'subCategoryIds': subCategoryIds.join(','),
          if (spaceIds != null && spaceIds.isNotEmpty)
            'spaceIds': spaceIds.join(','),
        },
        parser: (data) =>
            (data as List).map((item) => Product.fromJson(item)).toList(),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch categories: ${response.message}');
      }
    } catch (e) {
      return [];
    }
  }

  Future<Product?> getProductById(int productId) async {
    try {
      final response = await _api.get(
        '/v1/products/$productId',
        parser: (data) => Product.fromJson(data),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch product: ${response.message}');
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> addProductToCollections(
      int productId, List<int> collectionIds) async {
    try {
      final response = await _api.post(
        '/v1/products/$productId/collections',
        data: {
          'collectionIds': collectionIds,
        },
        parser: (data) => data,
      );
      return response.message;
    } catch (e) {
      throw Exception('Error adding product to collection: $e');
    }
  }

  Future<String> likeProduct(int productId) async {
    try {
      final response = await _api.post(
        '/v1/products/$productId/likes',
        parser: (data) => data,
      );
      return response.message;
    } catch (e) {
      throw Exception('Error liking product: $e');
    }
  }

  Future<String> dislikeProduct(int productId) async {
    try {
      final response = await _api.delete(
        '/v1/products/$productId/likes',
        parser: (data) => data,
      );
      return response.message;
    } catch (e) {
      throw Exception('Error unliking product: $e');
    }
  }

  Future<List<Product>> getCurratedList({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await _api.get(
        '/v1/collections/products/featured',
        queryParams: {
          'page': page,
          'perPage': perPage,
        },
        parser: (data) =>
            (data as List).map((item) => Product.fromJson(item)).toList(),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch categories: ${response.message}');
      }
    } catch (e) {
      return [];
    }
  }
}
