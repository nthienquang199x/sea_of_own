import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/collection.dart';

class CollectionService {
  final _api = BaseApiService();

  Future<List<Collection>> getCollections({String? searchKeyword}) async {
    try {
      final response = await _api.get(
        '/v1/collections/me',
        queryParams: {
          if (searchKeyword != null && searchKeyword.isNotEmpty)
            'searchKeyword': searchKeyword,
        },
        parser: (data) =>
            (data as List).map((item) => Collection.fromJson(item)).toList(),
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

  Future<Collection?> createCollection(String name, String thumbnail) async {
    try {
      final response = await _api.post(
        '/v1/collections',
        data: {'name': name, 'thumbnail': thumbnail},
        parser: (data) => Collection.fromJson(data),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to create collection: ${response.message}');
      }
    } catch (e) {
      return null;
    }
  }

  Future<Collection?> updateCollection(int collectionId, String name) async {
    try {
      final response = await _api.patch(
        '/v1/collections/$collectionId',
        data: {'name': name},
        parser: (data) => Collection.fromJson(data),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to update collection: ${response.message}');
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> deleteCollection(int collectionId) async {
    try {
      final response = await _api.delete(
        '/v1/collections/$collectionId',
        parser: (data) => data,
      );
      return response.message;
    } catch (e) {
      throw Exception('Failed to delete collection');
    }
  }
}
