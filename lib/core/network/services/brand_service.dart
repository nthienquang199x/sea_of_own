import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/brand.dart';

class BrandService {
  final _api = BaseApiService();

  Future<List<Brand>> getCategories() async {
    try {
      final response = await _api.get(
        '/v1/categories',
        parser: (data) =>
            (data as List).map((item) => Brand.fromJson(item)).toList(),
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
