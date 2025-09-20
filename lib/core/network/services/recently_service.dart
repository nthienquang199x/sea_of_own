import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/recently_product.dart';

class RecentlyService {
  final _api = BaseApiService();

  Future<bool> upsertRecentlyViewed(int productId) async {
    try {
      final response = await _api.post(
        '/v1/recently-views',
        data: {'productId': productId},
        parser: (data) => data,
      );
      if (response.message != "Success") {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<RecentlyProduct>> getRecentlyViewed() async {
    try {
      final response = await _api.get(
        '/v1/recently-views',
        parser: (data) => (data as List)
            .map((item) => RecentlyProduct.fromJson(item))
            .toList(),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch recently viewed: ${response.message}');
      }
    } catch (e) {
      return [];
    }
  }
}
