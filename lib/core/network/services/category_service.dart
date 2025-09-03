import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/category.dart';

class CategoryService {
  final _api = BaseApiService();

  Future<List<Category>> getCategories() async {
    try {
      final response = await _api.get(
        '/v1/categories',
        parser: (data) =>
            (data as List).map((item) => Category.fromJson(item)).toList(),
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
