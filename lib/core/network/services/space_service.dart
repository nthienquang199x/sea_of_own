import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/core/network/models/space.dart';

class SpaceService {
  final _api = BaseApiService();

  Future<List<Space>> getSpaces() async {
    try {
      final response = await _api.get(
        '/v1/spaces',
        parser: (data) =>
            (data as List).map((item) => Space.fromJson(item)).toList(),
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
