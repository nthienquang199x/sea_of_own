import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/product.dart';

class ProductCollectionService {
  final _api = BaseApiService();

  Future<List<Product>> getAllProductsInCollection(int collectionId) async {
    try {
      final response = await _api.get(
        '/v1/collections/$collectionId/products',
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

  Future<String> deleteProductFromCollection(
      int collectionId, int productId) async {
    try {
      final response = await _api.delete(
        '/v1/collections/$collectionId/products/$productId',
        parser: (data) => data,
      );
      return response.message;
    } catch (e) {
      throw Exception('Failed to delete product from collection');
    }
  }
}
