import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/sub_category.dart';

class SubCategoryService {
  final _api = BaseApiService();

  Future<List<SubCategory>> getSubCategories() async {
    try {
      final response = await _api.get(
        '/v1/sub-categories',
        parser: (data) =>
            (data as List).map((item) => SubCategory.fromJson(item)).toList(),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch sub-categories');
      }
    } catch (e) {
      return [];
    }
  }
}
